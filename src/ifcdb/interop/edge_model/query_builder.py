from __future__ import annotations

from dataclasses import dataclass, field
import json

import edgedb


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

    def clean_name(n):
        return n["name"].replace(f"{module_name}::", "")

    def append_to_obj_refs(result_list, ref_list):
        for x in result_list:
            ref_name = clean_name(x)
            existing_aeo = edge_objects.get(ref_name)
            if existing_aeo is None:
                edge_objects[ref_name] = EdgeObject(ref_name)
            else:
                ref_list.append(existing_aeo)

    output = json.loads(client.query_json(query_str))

    for r in output:
        name = clean_name(r)
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


@dataclass
class EQBuilder:
    client: edgedb.Client
    module: str = "default"
    edgedb_objects: dict[str, EdgeObject] = None

    def __post_init__(self):
        self.edgedb_objects = introspect_schema(self.client, self.module)

    def select_object_str(self, class_name: str, include_all_nested_objects=True, level=0, include_select_str=False) -> str:
        eobj = self.edgedb_objects[class_name]
        indent = 4*(level+1)*" "
        props_str = ",\n".join([f"{indent}{x}" for x in eobj.all_properties])

        if props_str != "":
            props_str += f",\n"

        for prop_name, link in eobj.links.items():
            key = prop_name

            # does the link refer to other links?

            if include_all_nested_objects is False:
                props_str += f"{indent}{key} : {{ id, __type__ : {{name}} }},\n"

            elif isinstance(link, list):
                props_str += f"{indent}{key} : {{ id, __type__ : {{name}} }},\n"
            elif link.abstract is True:
                if len(link.links) == 0:
                    props_str += f"{indent}{key} : {{ id, __type__ : {{name}} }},\n"
                else:
                    props_str += f"{indent}{key} : {{\n{self.select_object_str(link.name, level=level + 1)}{indent}}},\n"
            else:
                props_str += f"{indent}{key} : {{\n{self.select_object_str(link.name, level=level+1)}{indent}}},\n"

        if include_select_str:
            return f"SELECT {class_name} {{\n{props_str}\n}}"
        else:
            return props_str+"\n"
