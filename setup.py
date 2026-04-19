import sys
import os
from pathlib import Path

from setuptools import setup, Extension, find_packages
from Cython.Build import cythonize
import numpy as np

ROOT = Path(__file__).parent.absolute()

COMMON_INCLUDE_DIRS = [
    np.get_include(),
    str(ROOT),
]

# ufbx uses pointer identity for interned strings, so ideally all code shares
# a single compiled copy of ufbx.c.
#
# On Linux/macOS: compile ufbx.c only into ufbx_wrapper, then load it with
# RTLD_GLOBAL in __init__.py so all other extensions share its symbols.
#
# On Windows: RTLD_GLOBAL is a no-op and DLLs cannot share symbols without
# explicit import libraries. We compile ufbx.c into every module that calls
# ufbx functions directly (scene, bake_anim). This means bake_anim string
# interning is broken on Windows until a proper shared DLL approach is added.
if sys.platform == "win32":
    NEEDS_UFBX_C = {
        "pyufbx.ufbx_wrapper",
        "pyufbx.scene",
        "pyufbx.animation.bake_anim",
    }
else:
    NEEDS_UFBX_C = {
        "pyufbx.ufbx_wrapper",
    }


def find_pyx_files(base_dir="pyufbx"):
    base_path = ROOT / base_dir
    pyx_files = base_path.rglob("*.pyx")
    modules = []

    for pyx_path in pyx_files:
        relative = pyx_path.relative_to(ROOT)
        module_name = str(relative.with_suffix("")).replace(os.sep, ".")
        modules.append(module_name)

    return modules


all_modules = find_pyx_files("pyufbx")
extensions = []

for module_name in all_modules:
    pyx_path = module_name.replace(".", "/") + ".pyx"

    if module_name in NEEDS_UFBX_C:
        sources = [pyx_path, "ufbx/ufbx.c"]
    else:
        sources = [pyx_path]

    extensions.append(
        Extension(
            module_name,
            sources=sources,
            include_dirs=COMMON_INCLUDE_DIRS,
        )
    )

setup(
    ext_modules=cythonize(
        extensions,
        compiler_directives={"language_level": "3"},
    ),
)
