from setuptools import setup, Extension, find_packages
from Cython.Build import cythonize
import numpy as np

extensions = [
    Extension("pyufbx.ufbx_wrapper", ["pyufbx/ufbx_wrapper.pyx"]),
    Extension("pyufbx.elements.element", ["pyufbx/elements/element.pyx"]),
    Extension("pyufbx.elements.node", ["pyufbx/elements/node.pyx"]),
    Extension("pyufbx.elements.transform", ["pyufbx/elements/transform.pyx"]),
    Extension("pyufbx.props.props", ["pyufbx/props/props.pyx"]),
    Extension("pyufbx.scene", ["pyufbx/scene.pyx"]),
]

setup(
    name="pyufbx",
    packages=find_packages(),
    ext_modules=cythonize(
        extensions,
        compiler_directives={'language_level': "3"}
    ),
    include_dirs=[np.get_include()],
)