from setuptools import setup, Extension, find_packages
from Cython.Build import cythonize
import numpy as np
import os
from pathlib import Path

ROOT = Path(__file__).parent.absolute()
print("Project root:", ROOT)

COMMON_INCLUDE_DIRS = [
    np.get_include(),
    str(ROOT),  # allows "ufbx/ufbx.h"
]

# IMPORTANT: ufbx.c must be compiled into exactly ONE extension module.
# ufbx interns strings and compares them by pointer identity. If ufbx.c is
# compiled into multiple .so files, each gets its own string constants at
# different addresses, and cross-module comparisons silently fail (e.g.
# bake_anim produces 2 identity keyframes instead of real animation data).
# pyufbx/__init__.py loads ufbx_wrapper with RTLD_GLOBAL so its symbols are
# shared with all other extensions. See tests/test_bake_anim.py for the
# regression test that catches this.
NEEDS_UFBX_C = {
    "pyufbx.ufbx_wrapper",
}

def find_pyx_files(base_dir="pyufbx"):
    """Recursively find all .pyx files and convert to module names."""
    base_path = ROOT / base_dir
    pyx_files = base_path.rglob("*.pyx")
    modules = []
    
    for pyx_path in pyx_files:
        # Convert path to module name: pyufbx/elements/node.pyx -> pyufbx.elements.node
        relative = pyx_path.relative_to(ROOT)
        module_name = str(relative.with_suffix("")).replace(os.sep, ".")
        modules.append(module_name)
    
    return modules

# Auto-discover all .pyx files
all_modules = find_pyx_files("pyufbx")
extensions = []

for module_name in all_modules:
    pyx_path = module_name.replace(".", "/") + ".pyx"
    
    # Check if this module needs ufbx.c
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

print(f"Found {len(extensions)} Cython modules to build")

setup(
    name="pyufbx",
    packages=find_packages(),
    version="0.1.0",
    description="Python FBX file parser using the UFBX library",
    author="Andrzej Weremczuk",
    author_email="and.weremczuk@gmail.com",
    ext_modules=cythonize(
        extensions,
        compiler_directives={"language_level": "3"},
    ),
)