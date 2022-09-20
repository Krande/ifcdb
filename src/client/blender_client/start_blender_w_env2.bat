@echo off

if exist blender_client.env for /f "delims=" %%i in (blender_client.env) do set %%i

"C:\Program Files\Blender Foundation\Blender 3.3\blender-launcher.exe"

exit