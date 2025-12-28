from setuptools import setup, Extension, find_packages
from Cython.Build import cythonize
import numpy as np
import os

ROOT = os.path.abspath(os.path.dirname(__file__)) 
print("Project root:", ROOT)
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
        "pyufbx.core.math_types",
        ["pyufbx/core/math_types.pyx"],
        include_dirs=COMMON_INCLUDE_DIRS,
    ),
    Extension(
        "pyufbx.props.prop",
        ["pyufbx/props/prop.pyx"],
        include_dirs=COMMON_INCLUDE_DIRS,
    ),
    Extension(
        "pyufbx.scene",
        ["pyufbx/scene.pyx", "ufbx/ufbx.c"],
        include_dirs=COMMON_INCLUDE_DIRS,
    ),
    Extension(
        "pyufbx.generated.lists",
        ["pyufbx/generated/lists.pyx"],
        include_dirs=COMMON_INCLUDE_DIRS,
    ),
    Extension(
        "pyufbx.generated.wrappers",
        ["pyufbx/generated/wrappers.pyx"],
        include_dirs=COMMON_INCLUDE_DIRS,
    ),
    Extension(
        "pyufbx.animation.anim",
        ["pyufbx/animation/anim.pyx"],
        include_dirs=COMMON_INCLUDE_DIRS,
    
    ),
    Extension("pyufbx.animation.anim_curve",
        ["pyufbx/animation/anim_curve.pyx"],
        include_dirs=COMMON_INCLUDE_DIRS,
    ),
    Extension('pyufbx.animation.keyframe',
        ['pyufbx/animation/keyframe.pyx'],
        include_dirs=COMMON_INCLUDE_DIRS,
    ),
]


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
