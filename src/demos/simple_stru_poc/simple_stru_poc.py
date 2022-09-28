import ada
from ada.param_models.basic_module import SimpleStru

from ifcdb import EdgeIO


def upload_first():
    a = ada.Assembly("PoC-Stru") / SimpleStru("A Simple Structure")
    ifc_stringio_obj = a.to_ifc(return_file_obj=True)
    with EdgeIO("ifc001", load_env=True) as io:
        # io.wipe_database()
        io.insert_ifc(ifc_file_str=ifc_stringio_obj.read())


def then_download():
    with EdgeIO("ifc001", load_env=True) as io:
        io.to_ifc_file("temp/first_model.ifc")


if __name__ == "__main__":
    # upload_first()
    then_download()
