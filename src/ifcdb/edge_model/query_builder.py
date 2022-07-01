from __future__ import annotations

import copy
import json
import logging
from dataclasses import dataclass, field

import edgedb

from ifcdb.edge_model.utils import clean_name


def introspect_schema(client, module_name):
    query_str = f"""with module schema
select ObjectType {{
    name,
    __type__ : {{ name}},
    abstract,
    bases: {{ name }},
    ancestors: {{ name }} filter .name like '{module_name}::%',
    annotations: {{ name, @value }},
    links: {{
        name,
        cardinality,
        required,
        target: {{ name }}
    }} filter .target.name like '{module_name}::%',
    properties: {{
        name,
        cardinality,
        required,
        target: {{ name }} filter .name like '{module_name}::%',
    }},
    constraints: {{ name }},
    indexes: {{ expr }},
}} filter .name like '{module_name}::%'"""

    edge_objects: dict[str, EdgeObject] = dict()

    def append_to_obj_refs(result_list, ref_list):
        for x in result_list:
            ref_name = clean_name(x, module_name)
            existing_aeo = edge_objects.get(ref_name)
            if existing_aeo is None:
                edge_objects[ref_name] = EdgeObject(ref_name)
            else:
                ref_list.append(existing_aeo)

    output = json.loads(client.query_json(query_str))

    for r in output:
        name = clean_name(r, module_name)
        if "|" in name:
            continue
        abstract = r["abstract"]
        ancestors = []
        links: dict[str, EdgeObject | list[EdgeObject]] = dict()
        append_to_obj_refs(r["ancestors"], ancestors)
        properties = [x["name"] for x in r["properties"] if x["name"] != "id"]
        for li in r["links"]:
            li_name = li["name"]
            ref_obj = li["target"]["name"].replace(f"{module_name}::", "")
            if "|" in ref_obj:
                ref_obj = ref_obj.replace(f"{module_name}:", "").replace("(", "").replace(")", "").split("|")
                existing_aeos = []
                for x in ref_obj:
                    xname = x.strip()
                    existing_aeo = edge_objects.get(xname)
                    if existing_aeo is None:
                        existing_aeo = EdgeObject(xname)
                        edge_objects[xname] = existing_aeo
                    existing_aeos.append(existing_aeo)
                links[li_name] = existing_aeos
            else:
                existing_aeo = edge_objects.get(ref_obj)
                if existing_aeo is None:
                    existing_aeo = EdgeObject(ref_obj)
                    edge_objects[ref_obj] = existing_aeo

                links[li_name] = existing_aeo

        existing_eo = edge_objects.get(name)
        if existing_eo is None:
            eo = EdgeObject(name, abstract, ancestors, links, properties)
            edge_objects[name] = eo
        else:
            existing_eo.abstract = abstract
            existing_eo.ancestors = ancestors
            existing_eo.links = links

    for obj in edge_objects.values():
        if obj.ancestors is None:
            continue
        for ancestor in obj.ancestors:
            ancestor.subtypes.append(obj)

    return edge_objects


@dataclass
class EdgeProp:
    name: str
    is_inherited: bool


@dataclass
class EdgeObject:
    name: str
    abstract: bool = None
    ancestors: list[EdgeObject] = field(default=None, repr=False)
    links: dict[str, EdgeObject] = None
    properties: list[str] = None
    subtypes: list[EdgeObject] = field(default_factory=list, repr=False)

    @property
    def all_properties(self):
        all_props = self.properties if self.properties is not None else []
        for ancestor in self.ancestors:
            if ancestor.properties is None:
                continue
            for prop in ancestor.properties:
                if prop not in all_props:
                    all_props.append(prop)

        return all_props

    def get_links_from_subtypes(self) -> dict[str, EdgeObject]:
        link_list = dict()
        for subtype in self.subtypes:
            if subtype.name in link_list.keys():
                continue
            for key, st_link in subtype.links.items():
                if key in link_list:
                    continue
                link_list[key] = st_link
        return link_list

    def get_all_link_references(self, link_list: list[EdgeObject] = None):
        link_list = [] if link_list is None else link_list

        for link in self.links.values():
            if isinstance(link, list):
                for sublink in link:
                    if sublink not in link_list:
                        link_list.append(sublink)
                        sublink.get_all_link_references(link_list)
            else:
                if link not in link_list:
                    link_list.append(link)
                    link.get_all_link_references(link_list)

        if self.abstract is True and len(self.links) == 0:
            for slink in self.get_links_from_subtypes().values():
                if slink not in link_list:
                    link_list.append(slink)
                    slink.get_all_link_references(link_list)

        return link_list


@dataclass
class EQBuilder:
    client: edgedb.Client
    module: str = "default"
    edgedb_objects: dict[str, EdgeObject] = None

    def __post_init__(self):
        self.edgedb_objects = introspect_schema(self.client, self.module)

    def build_object_property_tree(
        self, class_name, swriter: SelectWriter = None, referring_classes: list[str] = None, level=0
    ) -> dict:
        if referring_classes is None:
            referring_classes = []

        if swriter is None:
            swriter = SelectWriter()
            swriter.add_initial_select_str(class_name)

        swriter.current_level = level + 1
        eobj = self.edgedb_objects[class_name]
        if eobj.name in referring_classes:
            logging.warning(f'"{eobj.name}" was skipped as it would lead to recursion issues -> "{referring_classes}"')
            return {eobj.name: {x: None for x in eobj.all_properties}}

        referring_classes.append(eobj.name)
        if eobj.abstract is True:
            property_dict = {eobj.name: {"is_abstract": True}}
        else:
            property_dict = {eobj.name: {x: None for x in eobj.all_properties}}
            swriter.add_properties(eobj.all_properties)
            for key, top_link in eobj.links.items():
                if isinstance(top_link, list) is False:
                    links = [top_link]
                else:
                    links = top_link
                for link in links:
                    copy_ref = copy.copy(referring_classes)
                    swriter.select_str += f"{swriter.indent_str}{key}: {{\n"
                    new_entry = self.build_object_property_tree(link.name, swriter, copy_ref, level=level + 1)
                    if key not in property_dict[eobj.name].keys():
                        property_dict[eobj.name][key] = []
                    swriter.select_str += f"{swriter.indent_str}}}"
                    property_dict[eobj.name][key].append(new_entry)

        property_dict[eobj.name]["subtypes"] = []
        subtype_list = property_dict[eobj.name]["subtypes"]
        subtypes = eobj.subtypes
        for stype in subtypes:
            if stype.abstract is True:
                continue
            key = stype.name
            swriter.add_abstract_classes(stype.name, stype.all_properties)
            new_entry = self.build_object_property_tree(key, swriter, copy.copy(referring_classes), level=level + 1)
            subtype_list.append(new_entry)

        # if level == 0:
        #     res = WalkPropTreeSelect(property_dict)
        return swriter

    def select_linked_objects_query_str(self, class_name, level=0, ref_classes: list[str] = None):
        from itertools import chain

        if ref_classes is None:
            ref_classes = []

        eobj = self.edgedb_objects[class_name]
        if eobj in ref_classes:
            logging.debug("cyclic pointing class")
            return ""

        ref_classes.append(eobj)

        indent = 4 * (level + 1) * " "
        props_str = ""
        if level != 0:
            props_str += f"{indent}id, __type__: {{name}},\n"

        # subtype_links = eobj.get_links_from_subtypes()
        all_related_links = dict()
        all_related_links.update(eobj.links)
        # if len(eobj.links) == 0:
        #     all_related_links.update(subtype_links)

        for prop_name, link in all_related_links.items():
            key = prop_name
            # res = subtype_links.get(key)
            # if res is not None:
            #     key = f"[is {res.name}].{key}"
            if isinstance(link, list):
                all_link_references = len(list(list(chain.from_iterable([l.get_all_link_references() for l in link]))))
                if all_link_references > 0:
                    props_str += f"{indent}{key} : {{ id,  __type__: {{ name }},}}\n"
            else:
                if len(link.get_all_link_references()) > 0:
                    subselect_str = self.select_linked_objects_query_str(
                        link.name, level=level + 1, ref_classes=ref_classes
                    )
                    props_str += f"{indent}{key} : {{\n{subselect_str}{indent}}},\n"

        return props_str

    def select_object_str(
        self,
        class_name: str,
        include_all_nested_objects=True,
        level=0,
        include_select_str=False,
        include_linked_objects=True,
        include_is_a_prefix=False,
    ) -> str:
        eobj = self.edgedb_objects[class_name]
        indent = 4 * (level + 1) * " "
        props_str = ",\n".join([f"{indent}{x}" for x in eobj.all_properties])
        if include_linked_objects is False:
            return props_str

        if props_str != "":
            props_str += ",\n"

        for prop_name, link in eobj.links.items():
            key = prop_name

            # does the link refer to other links?

            if include_all_nested_objects is False:
                props_str += f"{indent}{key} : {{ id, __type__ : {{name}} }},\n"
                continue

            if isinstance(link, list):
                props_str += f"{indent}{key} : {{ id, __type__ : {{name}} }},\n"
                continue

            if include_is_a_prefix is True:
                key = f"[is {link.name}].{key}"

            if len(link.links) == 0:
                res = link.get_all_link_references()
                if len(res) > 0:
                    for r in res:
                        ref_link_str = self.select_object_str(r.name, level=level + 1, include_is_a_prefix=True)
                        props_str += f"{indent}{key} : {{\n{ref_link_str}{indent}}},\n"
                else:
                    props_str += f"{indent}{key} : {{ id, __type__ : {{name}} }},\n"
            else:
                ref_link_str = self.select_object_str(link.name, level=level + 1)
                props_str += f"{indent}{key} : {{\n{ref_link_str}{indent}}},\n"

        if include_select_str:
            return f"SELECT {class_name} {{\n{props_str}\n}}"
        else:
            return props_str + "\n"


@dataclass
class SelectWriter:
    select_str: str = ""
    current_level: int = 0

    def add_initial_select_str(self, class_name):
        self.select_str += f"SELECT {class_name} {{\n"

    def add_properties(self, properties: list[str]):
        self.select_str += "".join([f"{self.indent_str}{x},\n" for x in properties])

    def add_abstract_classes(self, class_name: str, properties: list[str]):
        for prop in properties:
            self.select_str += f"{self.indent_str}[is {class_name}].{prop},\n"

    @property
    def indent_str(self) -> str:
        return self.current_level * 4 * " "


def WalkPropTreeSelect(prop_tree):
    select_str = ""

    def walk_tree(obj, level=0):
        nonlocal select_str
        if isinstance(obj, dict):
            if level == 0:
                class_name = list(obj.keys())[0]
                select_str += f"select {class_name} {{"
                walk_tree(list(obj.values())[0], level + 1)
            else:
                subtypes = obj.get("subtypes")
                is_abstract = obj.get("is_abstract")
                if is_abstract is True:
                    walk_tree(subtypes, level + 1)

                select_str += ",".join([key for key, value in obj.items() if value is None])
                select_str += ","
                for key, value in obj.items():
                    if isinstance(value, (list, dict)) is False:
                        continue
                    prefix = key[:3]
                    if prefix == "Ifc":
                        continue
                    select_str += f"{key} : {{"
                    walk_tree(value, level + 1)
                    select_str += "},\n"
        elif isinstance(obj, list):
            for o in obj:
                walk_tree(o, level + 1)
        else:
            raise NotImplementedError(f"Unknown type {type(obj)}")

    walk_tree(prop_tree)
    return select_str
