import logging
from dataclasses import dataclass

import ifcopenshell
from deepdiff import DeepDiff

from ifcdb.ifcdiff import IfcDiff


def validate_ifc_content(ofile: ifcopenshell.file, results: dict):
    obj_set = {key: value for key, value in results[0].items() if len(value) != 0}

    # Try to manually edit a single property to ensure that it fails if discrepancies are found
    # obj_set["IfcCartesianPointList3D"][0]["CoordList"][0][1] = 200

    for ifc_class, instances in obj_set.items():
        for instance in instances:
            original_instance_found = False
            ifc_class_entities = list(ofile.by_type(ifc_class, True))
            for original_instance in ifc_class_entities:
                match_found = True
                for prop_name, prop_value in instance.items():
                    if prop_name == "id":
                        continue
                    if isinstance(prop_value, (list, tuple)) and len(prop_value) == 0:
                        prop_value = None
                    inst_value = getattr(original_instance, prop_name)
                    if isinstance(inst_value, ifcopenshell.entity_instance):
                        continue
                    elif isinstance(inst_value, (list, tuple)) and isinstance(
                        inst_value[0], ifcopenshell.entity_instance
                    ):
                        if len(inst_value) != len(prop_value):
                            match_found = False
                            break
                    elif isinstance(inst_value, (list, tuple)) and isinstance(inst_value[0], float):
                        for x, y in zip(inst_value, prop_value):
                            if x != y:
                                match_found = False
                                break
                    elif isinstance(inst_value, (list, tuple)) and isinstance(inst_value[0], (list, tuple)):
                        for a1, a2 in zip(inst_value, prop_value):
                            for x, y in zip(a1, a2):
                                if x != y:
                                    match_found = False
                                    break
                    else:
                        if inst_value != prop_value:
                            match_found = False
                            break
                if match_found is True:
                    original_instance_found = True
                    break

            if len(ifc_class_entities) > 0 and original_instance_found is False:
                entity_description = "[" + ",\n".join([str(x) for x in ifc_class_entities]) + "]"
                raise ValueError(f'Instance "{instance}" not found among\n{entity_description}')

    print("Successfully Validated IFC Content")


def fingerprint(file: ifcopenshell.file):
    get_info_props = dict(include_identifier=False, recursive=True, return_type=frozenset)
    return frozenset(inst.get_info(**get_info_props) for inst in file)


def validate_ifc_objects(f1: ifcopenshell.file, f2: ifcopenshell.file):
    compare_ifcopenshell_objects_element_by_element(f1, f2)

    # This assertion does not work as intended
    assert fingerprint(f1) == fingerprint(f2)


def compare_ifcopenshell_objects_element_by_element(f1: ifcopenshell.file, f2: ifcopenshell.file):
    results = sorted(fingerprint(f1).symmetric_difference(fingerprint(f2)), key=lambda x: len(str(x)))

    res = [set([name for name, value in result]) for result in results]

    matches = []
    i = 0
    while i < len(res):
        x = res[i]
        for k, match_eval in enumerate(res):
            if k == i or x != match_eval:
                continue
            found = tuple(sorted([i, k]))
            if found not in matches:
                matches.append(found)
            break
        i += 1

    # Compare element by element
    for a, b in matches:
        m_a = {key: value for key, value in results[a]}
        m_b = {key: value for key, value in results[b]}
        ifc_class = m_a["type"]
        for key, value in m_a.items():
            other_val = m_b[key]
            if isinstance(value, frozenset):
                continue
            if isinstance(value, tuple) and isinstance(value[0], frozenset):
                continue
            if other_val != value:
                logging.error(f'Diff in Ifc Class "{ifc_class}" property: {key} := "{value}" != "{other_val}"')


def validate_using_ifc_diff(
    f1: ifcopenshell.file,
    f2: ifcopenshell.file,
    output_file: str = None,
    inverse_classes: list[str] = None,
):
    ifc_diff = IfcDiff(f1, f2, output_file, inverse_classes)
    ifc_diff.diff()
    return ifc_diff.to_json()


@dataclass
class ElDiff:
    guid: str
    name: str
    diff: dict


def element_validator(el1: ifcopenshell.entity_instance, el2: ifcopenshell.entity_instance) -> ElDiff:
    diff = dict()
    info1 = el1.get_info(recursive=True, include_identifier=False)
    info2 = el2.get_info(recursive=True, include_identifier=False)
    res = DeepDiff(info1, info2)
    changed_data = res.get("values_changed")
    if changed_data is not None:
        diff = changed_data

    return ElDiff(el1.GlobalId, el1.Name, diff)


def get_elem_ancestry(
    f: ifcopenshell.file, el: ifcopenshell.entity_instance, ancestry: list[ifcopenshell.entity_instance] = None
) -> list[ifcopenshell.entity_instance]:
    if ancestry is None:
        ancestry = []

    inv = f.get_inverse(el)
    for i in inv:
        ancestry.append(i)
        get_elem_ancestry(f, i, ancestry)

    return ancestry


def ifc_validator_v2(f1: ifcopenshell.file, f2: ifcopenshell.file) -> list[ElDiff]:
    """Go through element by element"""
    diffs = list()
    for el in f1.by_type("IfcRoot"):
        identifier = el.GlobalId
        other_el = f2.by_guid(identifier)

        result = element_validator(el, other_el)
        if len(result.diff) == 0:
            continue
        diffs.append(result)

    return diffs
