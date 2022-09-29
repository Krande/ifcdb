import logging

import ada
import numpy as np
from ada.core.vector_utils import linear_2dtransform_rotate, vector_length_2d
from ada.param_models.basic_module import SimpleStru

from ifcdb import EdgeIO
from ifcdb.utils import top_dir

IFC_FILE_1 = "temp/model_00.ifc"
IFC_FILE_2 = "temp/model_01_w_cubes.ifc"
IFC_FILE_3 = "temp/model_02_w_pipe.ifc"
IFC_FILE_4 = "temp/model_02_w_pen_detail.ifc"

# TODO: New models and modifications should be assigned to a separate modelling layer


def create_schema_one_time():
    extra_entities = ["IfcPump", "IfcCompressor", "IfcPipe", "IfcRevolvedAreaSolid"]
    with EdgeIO("ifc001", load_env=True) as io:
        entities = io.get_entities_from_ifc_files([top_dir() / "files/SimpleStru.ifc"])
        if extra_entities is not None:
            entities += extra_entities
        io.create_database()
        io.stepwise_migration(entities=entities, batch_size=50, dry_run=False)


def build_and_upload_first():
    a = ada.Assembly("PoC-Stru") / SimpleStru("A Simple Structure")
    with EdgeIO("ifc001", load_env=True) as io:
        io.wipe_database()
        ifc_obj = a.to_ifc(return_file_obj=True)
        io.insert_ifc(ifc_obj=ifc_obj)


def then_download_as(to_ifc_file):
    with EdgeIO("ifc001", load_env=True) as io:
        io.to_ifc_file(to_ifc_file)


def add_two_equipments_as_cubes(from_file, to_file):
    a = ada.from_ifc(from_file)

    fl1 = a.get_by_name("floor1")
    fl2 = a.get_by_name("floor2")

    meta = dict(auto_pipe=True)
    shp1 = fl1.add_shape(ada.PrimBox("Equip1", (1, 1, 0), (2, 2, 1), metadata=meta))
    shp2 = fl2.add_shape(ada.PrimBox("Equip2", (3, 3, 3), (4, 4, 4), metadata=meta))
    shp1.ifc_options.export_props = True
    shp2.ifc_options.export_props = True

    new_f = a.to_ifc(return_file_obj=True)
    new_f_str = new_f.wrapped_data.to_string()

    with open(to_file, "w") as f:
        f.write(new_f_str)
    #
    # ifc_file = ifcopenshell.file.from_string(new_f_str)
    # with EdgeIO("ifc001", load_env=True) as io:
    #     io.update_db_from_ifc_delta(ifc_file)


def if_two_equipments_make_a_pipe(from_file, to_file):

    a = ada.from_ifc(from_file)
    section = ada.Section("Psec", ada.Section.TYPES.TUBULAR, r=0.07, wt=0.01)

    def filter_equip_for_auto_connecting(x):
        return x.metadata.get("props", dict()).get("Properties", dict()).get("auto_pipe", None) is not None

    result: list[ada.Shape] = list(filter(filter_equip_for_auto_connecting, a.get_all_physical_objects()))
    points = [shp.bbox.volume_cog for shp in result]

    if len(points) < 2:
        logging.error('only a single equipment is set to "auto_pipe"')
        return None

    if len(points) == 2:
        shp1, shp2 = result
        start = points[0]
        end = points[-1]
        p1 = start + shp1.placement.xdir * 1.5
        p2 = p1 + np.array([0, 0, end[2] - start[2]])

        # find the closest direction to pipe going vertically through deck
        p2_2d = p2[:-1]
        p3 = end - shp2.placement.xdir * 1.5
        p32d = p3[:-1]
        end2d = end[:-1]
        closest_dist = abs(vector_length_2d(p2_2d - p32d))
        closest_point_2d = p32d
        for theta in [0, 90, 180, 270]:
            rotated_point = linear_2dtransform_rotate(end2d, p32d, theta)
            curr_dist = vector_length_2d(rotated_point - p2_2d)
            if curr_dist < closest_dist:
                closest_dist = curr_dist
                closest_point_2d = rotated_point
        p3 = [*closest_point_2d, p3[2]]
        piping_points = [start, p1, p2, p3, end]
        p = ada.Part("Piping") / ada.Pipe("Pipe1", piping_points, section)
        a.add_part(p)
    else:
        logging.error("Multiple points This is not yet accounted for")
        return

    new_f = a.to_ifc(return_file_obj=True)

    with open(to_file, "w") as f:
        f.write(new_f.wrapped_data.to_string())

    # Update the Database Model
    # ifc_file = ifcopenshell.file.from_string(new_f_str)
    # with EdgeIO("ifc001", load_env=True) as io:
    #     io.update_db_from_ifc_delta(ifc_file)


def check_for_penetrating_pipes(from_file, to_file):
    a = ada.from_ifc(from_file)

    plates = a.get_all_physical_objects(by_type=ada.Plate)
    pipe_segments = list(a.get_all_physical_objects(by_type=ada.PipeSegStraight))
    penetrations = []
    for seg in pipe_segments:
        if isinstance(seg, ada.PipeSegStraight) is False:
            continue
        p1 = np.array(seg.p1)
        p2 = np.array(seg.p2)
        for p in plates:
            origin = p.placement.origin
            normal = p.placement.zdir

            v1 = (p1 - origin) * normal
            v2 = (p2 - origin) * normal
            is_clashing = np.dot(v1, v2) < 0
            if is_clashing:
                print("adding penetration detail")
                pipe = seg.parent
                pen = p.parent.add_penetration(
                    ada.PrimCyl(f"{p.name}_{pipe.name}_{seg.name}_pen", p1, p2, pipe.section.r + 0.1)
                )
                penetrations.append(pen)

    new_f = a.to_ifc(return_file_obj=True)

    with open(to_file, "w") as f:
        f.write(new_f.wrapped_data.to_string())


if __name__ == "__main__":
    # build_and_upload_first()
    # then_download_as(IFC_FILE_1)
    # add_two_equipments_as_cubes(IFC_FILE_1, IFC_FILE_2)
    # if_two_equipments_make_a_pipe(IFC_FILE_2, IFC_FILE_3)
    check_for_penetrating_pipes(IFC_FILE_3, IFC_FILE_4)
