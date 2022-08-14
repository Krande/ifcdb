bl_info = {
    "name": "IFC DB",
    "description": "Client for connecting with IFC DB",
    "author": "Kristoffer H. Andersen",
    "blender": (3, 2, 2),
    "version": (0, 0, 99),
    "location": "View3D",
    "category": "Development",
}

import os
import site

from .ui import register, unregister

cwd = os.path.dirname(os.path.realpath(__file__))
site.addsitedir(os.path.join(cwd, "libs", "site", "packages"))

if __name__ == "__main__":
    register()
