from __future__ import annotations

import copy
import json
import logging
from dataclasses import dataclass, field
from itertools import chain

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
    links: dict[str, EdgeObject | list[EdgeObject]] = None
    properties: list[str] = None
    subtypes: list[EdgeObject] = field(default_factory=list, repr=False)

    links_instances: dict[str, EdgeObject] = field(default_factory=dict)
    property_instances: dict[str, EdgeProp] = field(default_factory=dict)

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

    def get_property_str(self, as_polymorph=False):
        props = self.all_properties
        return ",\n".join(props) if as_polymorph is False else ",\n".join([f"[is {self.name}].{x}" for x in props])

    def get_links(self) -> dict[str, list[EdgeObject]]:
        key_values = dict()
        links = self.links

        for stype in self.subtypes:
            if stype.abstract:
                continue
            links = stype.links
            for key, link in links.items():
                if key not in key_values.keys():
                    key_values[key] = []
                if link not in key_values[key]:
                    key_values[key].append(link)

        for key, link in links.items():
            if key not in key_values.keys():
                key_values[key] = []
            if link not in key_values[key]:
                key_values[key].append(link)

        return key_values


@dataclass
class SubTypeProp:
    subtype: EdgeObject
    weight: int
    unique_props: list[str]
    unique_links: dict[str, EdgeObject]
    parent_name: str


@dataclass
class SubTypeResolver:
    eobj: EdgeObject
    link_trvlr: LinkTraveller
    curr_depth: int
    ref_classes: list[str]
    key: str = None

    subtype_index: dict[str, SubTypeProp] = field(default_factory=dict)

    def __post_init__(self):
        self.resolve()
        self.find_overloading_keys()

    def has_unique_props(self) -> bool:
        for x in self.subtype_index.values():
            if len(x.unique_props) > 0 or len(x.unique_links) > 0:
                return True
        return False

    def resolve(self, eobj: EdgeObject = None):
        eobj = self.eobj if eobj is None else eobj
        o_links = frozenset({key: value.name for key, value in eobj.links.items()})
        o_props = set(eobj.all_properties)

        for subtype in eobj.subtypes:
            i = len(subtype.ancestors) - subtype.ancestors.index(self.eobj)
            sub_links = frozenset({key: value.name for key, value in subtype.links.items()})
            sub_props = set(subtype.all_properties)
            pdiff = sub_props.difference(o_props)
            odiff = sub_links.difference(o_links)
            unique_links = {x: subtype.links[x] for x in odiff}
            self.subtype_index[subtype.name] = SubTypeProp(subtype, i, list(pdiff), unique_links, eobj.name)
            self.resolve(subtype)

    def find_overloading_keys(self):
        keys = dict()
        link_pop = dict()
        prop_pop = dict()

        for stkey, st in self.subtype_index.items():
            for prop in st.unique_props:
                unique_prop = f"{st.parent_name}_{prop}"
                if unique_prop not in keys.keys():
                    keys[unique_prop] = (stkey, st)
                else:
                    old_stkey, old_st = keys[unique_prop]
                    if old_st.weight < st.weight:
                        if stkey not in prop_pop.keys():
                            prop_pop[stkey] = []
                        prop_pop[stkey].append(prop)
                    else:
                        if old_stkey not in prop_pop.keys():
                            prop_pop[old_stkey] = []
                        prop_pop[old_stkey].append(prop)

            for prop, link in st.unique_links.items():
                unique_prop = f"{st.parent_name}_{prop}"
                if unique_prop not in keys.keys():
                    keys[unique_prop] = (stkey, st)
                else:
                    old_stkey, old_st = keys[unique_prop]
                    if old_st.subtype in st.subtype.ancestors:
                        if stkey not in link_pop.keys():
                            link_pop[stkey] = []
                        link_pop[stkey].append(prop)
                    elif st.subtype in old_st.subtype.ancestors:
                        if old_stkey not in link_pop.keys():
                            link_pop[old_stkey] = []
                        link_pop[old_stkey].append(prop)
                    else:
                        continue
                    # Compare subtype levels and ensure that they are inherited from each other
        for key, props in link_pop.items():
            for prop in props:
                self.subtype_index[key].unique_links.pop(prop)

    def to_str(self) -> str:
        curr_depth = self.curr_depth
        ref_classes = self.ref_classes
        indent = indent_str(curr_depth)
        rstr = ""
        for subtype in self.subtype_index.values():
            for prop in subtype.unique_props:
                rstr += f"{indent}[is {subtype.subtype.name}].{prop},\n"

            for key, value in subtype.unique_links.items():
                if isinstance(value, EdgeObject) is False:
                    raise ValueError()

                copy_ref = copy.copy(ref_classes)
                substr = self.link_trvlr.walk_links_to_str(value, curr_depth + 1, ref_classes=copy_ref, key=key)
                if substr.strip() != "":
                    rstr += f"{indent}[is {subtype.subtype.name}].{key} : {{\n{substr}{indent}}},\n"

        return rstr


@dataclass
class LinkTraveller:
    eobj: EdgeObject
    max_depth: int | None = 0
    skip_link_classes: list[str] = None

    walk_history: list[str] = field(default_factory=list)

    curr_key: str = None
    curr_link: EdgeObject = None

    def __post_init__(self):
        if self.max_depth is None:
            self.max_depth = 999
        if self.skip_link_classes is None:
            self.skip_link_classes = []

    def walk_links_to_str(
        self, eobj: EdgeObject = None, curr_depth=0, ref_classes: list[str] = None, key: str = None
    ) -> str:
        if eobj is None:
            eobj = self.eobj
        if curr_depth > self.max_depth:
            return "\n"
        if ref_classes is None:
            ref_classes = []
        if eobj.name in ref_classes:
            logging.warning("Preventing recursion")
            return "\n"

        indent = indent_str(curr_depth)
        if eobj.name in self.skip_link_classes:
            return f"{indent}id\n,{indent}_e_type := .__type__.name\n"

        ref_classes.append(eobj.name)
        self.walk_history.append(eobj.name)
        rstr = ""

        # Resolve Subtypes
        sub_resolver = SubTypeResolver(eobj, self, curr_depth, ref_classes, key=key)
        substr = sub_resolver.to_str()

        if self.eobj != eobj:
            rstr += "".join([f"{indent}{x},\n" for x in eobj.all_properties])
        if substr != "":
            rstr += substr

        for key, value in eobj.links.items():
            rstr += indent + key
            self.curr_key = key
            if curr_depth == self.max_depth:
                rstr += ",\n"
                continue
            if (
                isinstance(value, EdgeObject)
                and self.skip_link_classes is not None
                and value.name in self.skip_link_classes
            ):
                rstr += f" : {{{indent}id\n,{indent}_e_type := .__type__.name\n}},"
                continue

            link_str = ""
            if isinstance(value, list):
                for link in value:
                    print(f'Adding select link "{link.name}"')
                    self.curr_link = link
                    copy_ref = copy.copy(ref_classes)
                    substr = self.walk_links_to_str(link, curr_depth + 1, ref_classes=copy_ref, key=key)
                    if substr.strip() != "":
                        link_str += substr + indent + "},\n"
            else:
                link = value
                self.curr_link = link
                copy_ref = copy.copy(ref_classes)
                substr = self.walk_links_to_str(link, curr_depth + 1, ref_classes=copy_ref, key=key)
                if substr.strip() != "":
                    link_str += substr + indent + "},\n"

            if link_str.strip() != "":
                rstr += " : {\n" + indent_str(curr_depth + 1) + "_e_type := .__type__.name,\n" + link_str
            else:
                rstr += ",\n"

        return rstr


def indent_str(curr_depth) -> str:
    return 4 * " " * (curr_depth + 1)


@dataclass
class EQBuilder:
    client: edgedb.Client
    module: str = "default"
    edgedb_objects: dict[str, EdgeObject] = None

    def __post_init__(self):
        self.load_db_objects()

    def load_db_objects(self):
        self.edgedb_objects = introspect_schema(self.client, self.module)

    def get_select_str(
        self, class_name, uuids: str | list[str] = None, max_depth=0, skip_link_classes: list[str] = None
    ) -> str:
        s_str = f"SELECT {class_name} {{\n"
        eobj = self.edgedb_objects[class_name]
        indent = 4 * " "

        s_str += "".join([f"{indent}{x},\n" for x in eobj.all_properties])

        link_trvlr = LinkTraveller(eobj, max_depth, skip_link_classes)
        s_str += link_trvlr.walk_links_to_str(eobj)

        if uuids is None:
            uuid_str = ""
        else:
            uuid_str = " filter .id = <uuid>'"
            if isinstance(uuids, list):
                uuid_str += "{" + ",".join([f"'{x}'" for x in uuids]) + "}"
            else:
                uuid_str += uuids
            uuid_str += "'"
        s_str += f"}}{uuid_str}"
        return s_str

    def select_linked_objects_query_str(self, class_name, level=0, ref_classes: list[str] = None):
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

        obj_info = "{id, _e_type := .__type__.name}"

        if props_str != "":
            props_str += ",\n"

        for prop_name, link in eobj.links.items():
            key = prop_name

            # does the link refer to other links?

            if include_all_nested_objects is False:
                props_str += f"{indent}{key} : {obj_info},\n"
                continue

            if isinstance(link, list):
                props_str += f"{indent}{key} : {obj_info},\n"
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
                    props_str += f"{indent}{key} : {obj_info},\n"
            else:
                ref_link_str = self.select_object_str(link.name, level=level + 1)
                props_str += f"{indent}{key} : {{\n{ref_link_str}{indent}}},\n"

        if include_select_str:
            return f"SELECT {class_name} {{\n{props_str}\n}}"
        else:
            return props_str + "\n"

    def get_spatial_hierarchy_str(self, filter_by_name: str = None) -> str:
        if filter_by_name is not None:
            filter_str_stru = f" filter .RelatingStructure.Name = '{filter_by_name}'"
            filter_str_rel = f" filter .RelatingObject.Name = '{filter_by_name}'"
        else:
            filter_str_stru = ""
            filter_str_rel = ""

        edge_props = "id, _e_type := .__type__.name"

        in_str = f"""SELECT {{
    spatial_stru := (
        SELECT IfcRelContainedInSpatialStructure {{
            id,
            RelatingStructure : {{ Name, {edge_props}, OwnerHistory }},
            RelatedElements : {{ Name, {edge_props}, OwnerHistory }}
        }}{filter_str_stru}
    ),
    rel_aggs := (
        SELECT IfcRelAggregates {{
            id,
            RelatingObject : {{ Name, {edge_props}, OwnerHistory }},
            RelatedObjects : {{ Name, {edge_props}, OwnerHistory }}
        }}{filter_str_rel}
    )
}}"""
        return in_str

    def get_owner_history_str(self) -> str:
        """Returns all OwnerHistory-related objects"""
        query_str = "SELECT {\n"

        classes = ["IfcOrganization", "IfcPerson", "IfcApplication", "IfcPersonAndOrganization", "IfcOwnerHistory"]
        for class_name in classes:
            q_str = self.select_object_str(class_name, include_all_nested_objects=False)
            query_str += f"{class_name} := (\n  SELECT {class_name} {{\n    id,{q_str}}}),\n"
        query_str += "}"
        return query_str

    def get_object_placements_str(self) -> str:
        """Returns all related objects and properties needed to resolve locations of all IFC objects"""
        query_str = "SELECT {\n"

        classes = [
            "IfcLocalPlacement",
            "IfcAxis2Placement",
            "IfcDirection",
            "IfcAxis2Placement3D",
            "IfcAxis2Placement2D",
            "IfcRepresentationContext",
        ]
        for class_name in classes:
            q_str = self.select_object_str(class_name, include_all_nested_objects=False)
            query_str += f"{class_name} := (\n  SELECT {class_name} {{\n    id,\n{q_str}}}),\n"
        query_str += "}"

        return query_str


@dataclass
class CurrEdgeObject:
    key: str
    eobj: EdgeObject
    level: int
    parent: EdgeObject
    key_chain: dict
    prev_obj: CurrEdgeObject


@dataclass
class SelectWriter:
    select_class: EdgeObject
    select_str: str = ""
    current_level: int = 0
    current_class: EdgeObject = None

    def add_link(self, key: str, link: EdgeObject, level: int, tree_builder, ref_classes: list[str], is_subtype=True):
        s_str = f"{self.indent_str}{key}: {{\n"
        temp_swriter = SelectWriter(link)
        copy_ref = copy.copy(ref_classes)
        new_entry = tree_builder(link.name, temp_swriter, level=level, ref_classes=copy_ref, is_subtype=is_subtype)
        if temp_swriter.select_str == "":
            return new_entry
        s_str += temp_swriter.select_str
        s_str += f"{self.indent_str}}},\n"

        self.select_str += s_str
        return new_entry

    def add_initial_select_str(self):
        self.select_str += f"SELECT {self.select_class.name} {{\n"

    def add_properties(self, properties: list[str]):
        self.select_str += "".join([f"{self.indent_str}{x},\n" for x in properties])

    def add_as_subtype_properties(self, class_name: str, properties: list[str] = None):
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
            raise ValueError(f"Unknown type {type(obj)}")

    walk_tree(prop_tree)
    return select_str
