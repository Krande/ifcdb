import logging
import os
import pathlib
import time

import ada
import numpy as np
from ada.core.clash_check import PipeClash
from ada.core.vector_utils import linear_2dtransform_rotate, vector_length_2d
from ada.param_models.basic_module import SimpleStru

from ifcdb import EdgeIO

DB_NAME = "ifc001"

SCRATCH_DIR = "temp/scratch"
IFC_FILE_0 = "temp/model_00.ifc"
IFC_FILE_1 = "temp/model_01_from_db.ifc"
IFC_FILE_2 = "temp/model_02_w_cubes.ifc"
IFC_FILE_3 = "temp/model_03_w_pipe.ifc"
IFC_FILE_4 = "temp/model_04_w_pen_detail.ifc"
IFC_FILE_5 = "temp/model_05_cleaned_file.ifc"

# TODO: New models and modifications should be assigned to a separate modelling layer


def create_schema_one_time():
    with open("all_classes.txt", "r") as f:
        entities = [x.strip() for x in f.readlines()]

    extra_entities = []

    with EdgeIO(DB_NAME, load_env=True) as io:
        if extra_entities is not None:
            entities += extra_entities
        io.create_database()
        io.stepwise_migration(entities=entities, batch_size=50, dry_run=False)


def build_and_upload_first(to_file, db_upload=True):
    os.makedirs("temp", exist_ok=True)
    a = ada.Assembly("PoC-Stru") / SimpleStru("A Simple Structure")
    ifc_obj = a.to_ifc(to_file)
    print(80 * "-")
    if db_upload:
        with EdgeIO(DB_NAME, load_env=True) as io:
            io.wipe_database()
            io.insert_ifc(ifc_obj=ifc_obj, silent=True)
        print(80 * "-")


def download(filepath):
    with EdgeIO(DB_NAME, load_env=True) as io:
        io.to_ifc_file(filepath)


def upload_delta(filepath, diff_name: str):
    with EdgeIO(DB_NAME, load_env=True) as io:
        io.wipe_database()
        io.insert_ifc(ifc_file_path=filepath, silent=True)
        # io.update_db_from_ifc_delta(filepath, save_diff_as=f"temp/{diff_name}.json")


def then_download_and_add_two_equipments_as_cubes(from_file, to_file, db_download=True, db_upload=True):
    if db_download:
        download(from_file)

    a = ada.from_ifc(from_file)

    fl1 = a.get_by_name("floor1")
    fl2 = a.get_by_name("floor2")

    meta = dict(auto_pipe=True)
    fl1.add_shape(ada.PrimBox("Equip1", (1, 1, 0), (2, 2, 1), metadata=meta))
    fl2.add_shape(ada.PrimBox("Equip2", (3, 3, 3), (4, 4, 4), metadata=meta))

    _ = a.to_ifc(to_file)

    if db_upload:
        upload_delta(to_file, "diff_add_two_cube")

    print(80 * "-")


def if_two_equipments_make_a_pipe(from_file, to_file, db_download=True, db_upload=True):
    if db_download:
        download(from_file)

    a = ada.from_ifc(from_file)
    section = ada.Section("Psec", ada.Section.TYPES.TUBULAR, r=0.07, wt=0.01)

    def filter_equip_for_auto_connecting(x):
        return x.metadata.get("Properties", dict()).get("auto_pipe", False) is True

    result: list[ada.Shape] = list(filter(filter_equip_for_auto_connecting, a.get_all_physical_objects()))
    points = [shp.bbox.volume_cog for shp in result]

    if len(points) < 2:
        logging.error('only a single equipment is set to "auto_pipe"')
        a.to_ifc(to_file)
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
        a.add_part(p, add_to_layer="PipeBot")
    else:
        logging.error("Multiple points This is not yet accounted for")
        return

    a.to_ifc(to_file)

    # Update the Database Model
    if db_upload:
        upload_delta(to_file, "diff_add_pipe")

    print(80 * "-")


def check_for_penetrating_pipes(from_file, to_file, use_db=True):
    if use_db:
        download(from_file)

    a = ada.from_ifc(from_file)

    clashes = PipeClash.pipe_penetration_check(a)
    for clash in clashes:
        clash.reinforce_plate_pipe_pen(add_to_layer="ReinforcementBot")

    a.to_ifc(to_file, validate=True)
    a.to_vis_mesh(cpus=1).to_gltf("temp/model_w_pen_detail.glb")

    if use_db:
        upload_delta(to_file, "add_pen_detail")

    print(80 * "-")


def do_structural_eigenvalue_analysis(from_file, db_download=True):
    if db_download:
        download(from_file)

    a = ada.from_ifc(from_file)

    fem = a.to_fem_obj(0.1, interactive=False, use_quads=True)
    fem.add_step(ada.fem.StepEigen("EigEn", 20))

    # step = fem.add_step(ada.fem.steps.StepImplicit("Static"))
    # step.add_load(ada.fem.LoadGravity("Gravity", -2000))

    fs = fem.add_set(
        ada.fem.FemSet("Bcs", None, set_type=ada.fem.FemSet.TYPES.NSET),
        p=(-0.1, -0.1, -0.6),
        vol_box=(5.1, 5.1, -0.45),
    )
    fem.add_bc(ada.fem.Bc("Bc", fs, dofs=[1, 2, 3, 4, 5, 6]))

    a.fem = fem
    # a.to_fem("stru_model_calculix", "calculix", scratch_dir=SCRATCH_DIR, execute=True, overwrite=True)
    a.to_fem("stru_model_code_aster", "code_aster", scratch_dir=SCRATCH_DIR, execute=True, overwrite=True)


def postprocess_structural_analysis():
    rmed = pathlib.Path(SCRATCH_DIR) / "stru_model_code_aster/stru_model_code_aster.rmed"
    res = ada.from_fem_res(rmed, "code_aster", import_mesh=True)
    vm = res.to_vis_mesh()
    vm.to_gltf(f"temp/stru_model_code_aster.glb")
    for pd in res.result_mesh.point_data:
        vm = res.to_vis_mesh(data_type=pd)
        if vm is None:
            continue
        name = pd.replace('__DEPL', '')
        # vm.to_binary_and_json('temp/stru_model_code_aster', export_dir='temp/vertex_coloring')
        vm.to_gltf(f"temp/stru_model_code_aster_{name}.glb")


def remove_auto_layers(from_file, to_file, use_db=False):
    if use_db:
        download(from_file)

    a = ada.from_ifc(from_file)
    layers = [x for x in a.presentation_layers.layers]
    for layer in layers:
        a.presentation_layers.remove_layer_and_delete_objects(layer)

    a.to_ifc(to_file)


if __name__ == "__main__":

    t_start = time.time()
    # create_schema_one_time()

    using_db = False
    # build_and_upload_first(IFC_FILE_0, db_upload=True)
    # do_structural_eigenvalue_analysis(IFC_FILE_0, db_download=using_db)
    postprocess_structural_analysis()
    # then_download_and_add_two_equipments_as_cubes(IFC_FILE_1, IFC_FILE_2, db_download=True)
    # if_two_equipments_make_a_pipe(IFC_FILE_2, IFC_FILE_3, db_download=False, db_upload=True)
    # check_for_penetrating_pipes(IFC_FILE_3, IFC_FILE_4, use_db=using_db)
    # remove_auto_layers(IFC_FILE_4, IFC_FILE_5, use_db=using_db)

    t_end = time.time()
    print(f"Demo time -> {t_end-t_start:.2f} seconds")
