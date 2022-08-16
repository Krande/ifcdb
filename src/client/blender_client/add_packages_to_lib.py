import sys
import os
import pathlib
import subprocess


blender_python = os.environ.get("BLENDER_PY", r"C:\Program Files\Blender Foundation\Blender 3.2\3.2\python")
python_prefix = os.environ.get("pythonLocation", blender_python)

target = pathlib.Path(__file__).parent / "addons/bl_ifc_db/libs/site/packages"
platform = sys.platform
if platform == "win32":
    python_exe = os.path.join(python_prefix, "bin", "python.exe")
# elif sys.platform in ["linux", "linux2"]:
else:
    python_exe = os.path.join(python_prefix, "bin", "python")

subprocess.call([python_exe, "-m", "ensurepip"])
subprocess.call([python_exe, "-m", "pip", "install", "--upgrade", "pip"])

packages = ["azure.identity", "azure-storage-queue"]
subprocess.call([python_exe, "-m", "pip", "install", "-U", *packages, "-t", target])

print("FINISHED")
