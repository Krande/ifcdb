import logging

import ada
from ada.param_models.basic_module import SimpleStru

from ifcdb import EdgeIO
from ifcdb.utils import top_dir

IFC_FILE_1 = "temp/model_00.ifc"
IFC_FILE_2 = "temp/model_01_w_cubes.ifc"
IFC_FILE_3 = "temp/model_02_w_pipe.ifc"


def create_schema_one_time():
    extra_entities = ["IfcPump", "IfcCompressor", "IfcPipe", "IfcRevolvedAreaSolid"]
    with EdgeIO("ifc001", load_env=True) as io:
        entities = io.get_entities_from_ifc_files([top_dir() / "files/SimpleStru.ifc"])
        if extra_entities is not None:
            entities += extra_entities
        io.create_database()
        io.stepwise_migration(entities=entities, batch_size=50, dry_run=False)


def upload_first():
    a = ada.Assembly("PoC-Stru") / SimpleStru("A Simple Structure")
    with EdgeIO("ifc001", load_env=True) as io:
        io.wipe_database()
        ifc_stringio_obj = a.to_ifc(return_file_obj=True)
        io.insert_ifc(ifc_file_str=ifc_stringio_obj.read())


def then_download_as(to_ifc_file):
    with EdgeIO("ifc001", load_env=True) as io:
        io.to_ifc_file(to_ifc_file)


def add_two_equipments_as_cubes():
    a = ada.from_ifc(IFC_FILE_1)

    fl1 = a.get_by_name("floor1")
    fl2 = a.get_by_name("floor2")

    meta = dict(auto_pipe=True)
    shp1 = fl1.add_shape(ada.PrimBox("Equip1", (1, 1, 0), (2, 2, 1), metadata=meta))
    shp2 = fl2.add_shape(ada.PrimBox("Equip2", (1, 1, 3), (2, 2, 4), metadata=meta))
    shp1.ifc_options.export_props = True
    shp2.ifc_options.export_props = True

    new_f = a.to_ifc(return_file_obj=True)
    new_f_str = new_f.read()

    with open(IFC_FILE_2, "w") as f:
        f.write(new_f_str)
    #
    # ifc_file = ifcopenshell.file.from_string(new_f_str)
    # with EdgeIO("ifc001", load_env=True) as io:
    #     io.update_db_from_ifc_delta(ifc_file)


def if_two_equipments_make_a_pipe():
    a = ada.from_ifc(IFC_FILE_2)

    def filter_equip_for_auto_connecting(x):
        return x.metadata.get("props", dict()).get("Properties", dict()).get("auto_pipe", None) is not None

    result = list(filter(filter_equip_for_auto_connecting, a.get_all_physical_objects()))

    points = [shp.bbox.volume_cog for shp in result]
    if len(points) < 2:
        logging.error('only a single equipment is set to "auto_pipe"')
        return None

    if len(points) == 2:
        start = points[0]
        end = points[-1]
        pipe = ada.Pipe('Pipe1', [start, end], ada.Section('Psec', ada.Section.TYPES.TUBULAR, r=0.2, wt=0.03))
        p = ada.Part('Piping') / pipe
        a.add_part(p)
    else:
        logging.error('Multiple points This is not yet accounted for')

    new_f = a.to_ifc(return_file_obj=True)
    new_f_str = new_f.read()

    with open(IFC_FILE_3, "w") as f:
        f.write(new_f_str)

    print("sd")


if __name__ == "__main__":
    upload_first()
    then_download_as(IFC_FILE_1)
    add_two_equipments_as_cubes()
    if_two_equipments_make_a_pipe()
