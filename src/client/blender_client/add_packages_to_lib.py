import os
import pathlib
import subprocess

blender_python_prefix = os.environ.get("PY_ENV", r"C:\Program Files\Blender Foundation\Blender 3.2\3.2\python")
target = pathlib.Path(__file__).parent / "addons/bl_ifc_db/libs/site/packages"

python_exe = os.path.join(blender_python_prefix, "bin", "python.exe")
subprocess.call([python_exe, "-m", "ensurepip"])
subprocess.call([python_exe, "-m", "pip", "install", "--upgrade", "pip"])

packages = ["azure.identity", "azure-storage-queue"]
subprocess.call([python_exe, "-m", "pip", "install", "-U", *packages, "-t", target])

print("FINISHED")
