from setuptools import setup, Extension, find_packages
from Cython.Build import cythonize
import numpy as np
import os

ROOT = os.path.abspath(os.path.dirname(__file__))

COMMON_INCLUDE_DIRS = [
    np.get_include(),
    ROOT,               # allows "ufbx/ufbx.h"
]
extensions = [
    Extension(
        "pyufbx.ufbx_wrapper",
        sources=[
            "pyufbx/ufbx_wrapper.pyx",
            "ufbx/ufbx.c",
        ],
        include_dirs=COMMON_INCLUDE_DIRS,
    ),
    Extension(
        "pyufbx.elements.element",
        ["pyufbx/elements/element.pyx"],
        include_dirs=COMMON_INCLUDE_DIRS,
    ),
    Extension(
        "pyufbx.elements.bone",
        ["pyufbx/elements/bone.pyx"],
        include_dirs=COMMON_INCLUDE_DIRS,
    ),
    Extension(
        "pyufbx.elements.node",
        ["pyufbx/elements/node.pyx"],
        include_dirs=COMMON_INCLUDE_DIRS,
    ),
    Extension(
        "pyufbx.core.transform",
        ["pyufbx/core/transform.pyx"],
        include_dirs=COMMON_INCLUDE_DIRS,
    ),
    Extension(
        "pyufbx.props.props",
        ["pyufbx/props/props.pyx"],
        include_dirs=COMMON_INCLUDE_DIRS,
    ),
    Extension(
        "pyufbx.scene",
        ["pyufbx/scene.pyx"],
        include_dirs=COMMON_INCLUDE_DIRS,
    )

]


setup(
    name="pyufbx",
    packages=find_packages(),
    ext_modules=cythonize(
        extensions,
        compiler_directives={"language_level": "3"},
    ),
)
