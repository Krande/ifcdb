from dotenv import load_dotenv


from ifcdb import EdgeIO
from ifcdb.utils import top_dir

load_dotenv()  # take environment variables from .env.


def main(database: str, ifc_schema: str, batch_size: int, ifc_files: list[str], extra_entities: list[str]):
    ifc_paths = [top_dir() / "files" / f for f in ifc_files]
    with EdgeIO(database) as io:
        io.setup_database(delete_existing_migrations=True)
        entities = io.get_entities_from_ifc_files(ifc_paths)
        entities += extra_entities
        io.stepwise_migration(ifc_schema_ver=ifc_schema, entities=entities, batch_size=batch_size)


if __name__ == "__main__":
    main(
        "mixed",
        "IFC4x1",
        50,
        ["MyCube.ifc", "cube-advanced-brep.ifc", "tessellated-item.ifc", "MyBeamWithHoles.ifc"],
        ["IfcTelecomAddress", "IfcMember", "IfcColumn", "IfcPerson"],
    )
