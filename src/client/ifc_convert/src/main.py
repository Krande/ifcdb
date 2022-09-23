from __future__ import annotations

from dataclasses import dataclass
import logging
import ifcopenshell.geom
import multiprocessing
import ada


@dataclass
class Colour:
    rgb: tuple | None
    opacity: float


def get_colour(product, geo, f: ifcopenshell.file) -> None | Colour:
    if len(geo.StyledByItem) == 0:
        return None

    styles = []
    cstyle = geo.StyledByItem[0].Styles[0]
    if cstyle not in styles:
        styles.append(cstyle)

    if len(styles) == 0:
        logging.warning(f'No style associated with IFC element "{product}"')
        return Colour(None, 1.0)

    if len(styles) > 1:
        logging.warning(f"Multiple styles associated to element {product}. Choosing arbitrarily style @ index=0")

    style = styles[0]
    colour_rgb = list(filter(lambda x: x.is_a("IfcColourRgb"), f.traverse(style)))
    transparency = list(filter(lambda x: x.is_a("IfcSurfaceStyleRendering"), f.traverse(style)))

    if len(colour_rgb) == 0:
        logging.warning(f'ColourRGB not found for IFC product "{product}"')
        return Colour(None, 1.0)

    opacity = 1.0 if len(transparency) == 0 else transparency[0].Transparency
    rgb = colour_rgb[0].Red, colour_rgb[0].Green, colour_rgb[0].Blue

    return Colour(rgb, opacity)


def get_geom(product, shape, f):
    if hasattr(shape, "geometry"):
        geometry = shape.geometry
    else:
        geometry = shape

    verts = geometry.verts
    faces = geometry.faces
    num_vertices = len(verts) // 3
    total_faces = len(geometry.faces)
    loop_start = range(0, total_faces, 3)
    num_loops = total_faces // 3
    loop_total = [3] * num_loops
    num_vertex_indices = len(geometry.faces)

    color = get_colour(product, geometry, f)


def convert_ifc_file_to_viz_mesh(ifc_path):
    f = ifcopenshell.open(ifc_path)
    geom_settings = ifcopenshell.geom.settings()
    it = ifcopenshell.geom.iterator(geom_settings, f, multiprocessing.cpu_count())
    it.initialize()
    while True:
        shape = it.get()
        product = f.by_id(shape.guid)
        print(f'converting "{product}"')
        if shape:
            get_geom(product, shape, f)
        if not it.next():
            break


def convert_using_adapy(ifc_path, destination):
    ada.from_ifc(ifc_path).to_vis_mesh().to_binary_and_json(destination)


if __name__ == "__main__":
    from ifcdb.utils import top_dir

    convert_using_adapy(top_dir() / "files/MyCube/MyCube.ifc", "temp/output")
