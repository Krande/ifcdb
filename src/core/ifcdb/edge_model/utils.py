from typing import ClassVar, Union

import ifcopenshell

wrap = ifcopenshell.ifcopenshell_wrapper

BASE_TYPES: ClassVar[dict[wrap.simple_type, str]] = {
    "binary": "bytes",
    "logical": "bool",
    "number": "int64",
    "real": "float64",
    "integer": "int64",
    "boolean": "bool",
    "string": "str",
}


def get_aggregation_type(agg_entity: wrap.aggregation_type):
    shape_len = agg_entity.type_of_aggregation()
    aggregate_types = [agg_entity]
    for agg in range(0, shape_len - 1):
        prev_entry = aggregate_types[-1]
        if hasattr(prev_entry, "type_of_element") is False:
            type_result = prev_entry
        else:
            type_result = prev_entry.type_of_element()
        aggregate_types.append(type_result)

    last_entry = aggregate_types[-1]
    if isinstance(last_entry, wrap.named_type):
        content_type = last_entry
    else:
        content_type: wrap.named_type = last_entry.type_of_element()

    result = get_base_type_name(content_type)

    if isinstance(result, wrap.named_type):
        cast_type_str = content_type.declared_type().name()
    elif isinstance(result, wrap.enumeration_type):
        cast_type_str = result.name()
    else:
        cast_type_str = result

    return cast_type_str


def get_base_type_name(
    content_type: Union[wrap.named_type, wrap.type_declaration],
) -> Union[wrap.entity, str, wrap.enumeration_type, wrap.select_type]:
    cur_decl = content_type
    while hasattr(cur_decl, "declared_type") is True:
        cur_decl = cur_decl.declared_type()

    if isinstance(cur_decl, wrap.select_type):
        return cur_decl
    if isinstance(cur_decl, wrap.enumeration_type):
        return cur_decl
    if isinstance(cur_decl, wrap.aggregation_type):
        res = cur_decl.type_of_element()
        cur_decl = res.declared_type()
        while hasattr(cur_decl, "declared_type") is True:
            cur_decl = cur_decl.declared_type()

    if isinstance(cur_decl, wrap.entity):
        return cur_decl

    if isinstance(cur_decl, str):
        cast_type = BASE_TYPES.get(cur_decl)
        if cast_type is None:
            raise ValueError(f'Cast Simple Type not found for "{cur_decl}" related to {content_type}')
        return cast_type

    raise NotImplementedError(f"Base type is unknown type {cur_decl}")


def get_ancestors(entity: wrap.entity):
    cur_entity = entity
    ancestors = []
    while cur_entity.supertype() is not None:
        cur_entity = cur_entity.supertype()
        ancestors.append(cur_entity)

    return ancestors


def unwrap_selected_items(entity: wrap.select_type, selectable_type_entities: list[wrap.entity] = None):
    selectable_type_entities = [] if selectable_type_entities is None else selectable_type_entities
    for x in entity.select_list():
        if x in selectable_type_entities:
            continue
        if isinstance(x, wrap.entity):
            selectable_type_entities.append(x)
        elif isinstance(x, wrap.select_type):
            unwrap_selected_items(x, selectable_type_entities)
        else:
            if x in selectable_type_entities:
                continue
            selectable_type_entities.append(x)
    return selectable_type_entities


def get_aggregation_levels(agg_type):
    prev_entry = agg_type
    levels = []

    while isinstance(prev_entry, wrap.aggregation_type):
        levels.append(prev_entry)
        prev_entry = prev_entry.type_of_element()
    return levels


def get_array_str(levels):
    aggregate_parameter = levels[-1].type_of_element()
    parameter = get_base_type_name(aggregate_parameter)

    if isinstance(parameter, str):
        cast_type_str = parameter
    else:
        cast_type_str = parameter.name()
    indent = 4 * " "
    astr = ""
    ending = ""
    constr_str = ""
    for i, level in enumerate(levels):
        b1 = level.bound1()
        b2 = level.bound2()
        if len(levels) > 1 and i == 0:
            array_str = "array<"
        else:
            array_str = "array<" if b2 == 1 else "tuple<"

        if b1 != b2 and b2 != -1 and len(levels) == 1:
            array_str = "array<"
            g = 3 * indent
            g2 = 2 * indent
            range_str = ""
            range_l = list(range(b1, b2 + 1))
            for j, k in enumerate(range_l, start=1):
                range_str += f"len(__subject__) = {k}"
                range_str += " or " if j != len(range_l) else ""
            constr_str = f"{{\n{g}constraint expression on ({range_str})\n{g2}}}"
            entity_str = cast_type_str
        else:
            max_num = max(max(b1, b2), 1)
            entity_str = ", ".join([cast_type_str for i in range(max_num)])

        if i == len(levels) - 1:
            astr += array_str + f"{entity_str}"
        else:
            astr += array_str
        ending += ">"
    return astr + ending + constr_str
