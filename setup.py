from setuptools import setup, Extension
from Cython.Build import cythonize
import sys
from pathlib import Path



extra_compile_args = []
if sys.platform == "win32":
    extra_compile_args = ["/std:c11"]
else:
    extra_compile_args = ["-std=c99"]


pyx_file =  Path("src/pyufbx.pyx")
pxd_file =  Path("src/pyufbx.pxd")
ufbx_dir =  Path("ufbx")
ufbx_c = ufbx_dir / "ufbx.c"
ufbx_h = ufbx_dir / "ufbx.h"


missing_files = []
for file_path in [
    pyx_file,
    pxd_file,
    ufbx_c,
    ufbx_h
]:
    if not file_path.exists():
        missing_files.append(str(file_path))

if missing_files:
    raise FileNotFoundError(
        f"Missing required files: {', '.join(missing_files)}\n"
        f"Please ensure all files are in place."
    )

extensions = [
    Extension(
        name="pyufbx",
        sources=[
            str(pyx_file),
            str(ufbx_c),
        ],
        include_dirs=[str(ufbx_dir)],
        extra_compile_args=extra_compile_args,
        language="c"
    )
]

setup(
    ext_modules=cythonize(
        extensions,
        compiler_directives={
            'language_level': "3",
            'embedsignature': True,
        }
    )
)