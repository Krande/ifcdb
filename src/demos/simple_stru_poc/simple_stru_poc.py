import logging
import time

import ada
import numpy as np
from ada.core.clash_check import pipe_penetration_check
from ada.core.vector_utils import linear_2dtransform_rotate, vector_length_2d
from ada.param_models.basic_module import SimpleStru

from ifcdb import EdgeIO
from ifcdb.utils import top_dir

IFC_FILE_0 = "temp/model_00.ifc"
IFC_FILE_1 = "temp/model_01_w_cubes.ifc"
IFC_FILE_2 = "temp/model_02_w_pipe.ifc"
IFC_FILE_3 = "temp/model_03_w_pen_detail.ifc"

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
        print(80 * "-")
        ifc_obj = a.to_ifc(return_file_obj=True)
        print(80 * "-")
        io.insert_ifc(ifc_obj=ifc_obj, silent=True)
    print(80 * "-")


def then_download_and_add_two_equipments_as_cubes(from_file, to_file):
    with EdgeIO("ifc001", load_env=True) as io:
        io.to_ifc_file(from_file)

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
    print(80 * "-")


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
    print(80 * "-")


def check_for_penetrating_pipes(from_file, to_file):
    a = ada.from_ifc(from_file)

    pipe_penetration_check(a)

    new_f = a.to_ifc(return_file_obj=True)

    with open(to_file, "w") as f:
        f.write(new_f.wrapped_data.to_string())

    print(80 * "-")


if __name__ == "__main__":
    start = time.time()

    build_and_upload_first()
    then_download_and_add_two_equipments_as_cubes(IFC_FILE_0, IFC_FILE_1)
    if_two_equipments_make_a_pipe(IFC_FILE_1, IFC_FILE_2)
    check_for_penetrating_pipes(IFC_FILE_2, IFC_FILE_3)

    end = time.time()
    print(f"Demo time -> {end-start:.2f} seconds")
