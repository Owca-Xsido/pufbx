# setup.py
from setuptools import setup, Extension
from Cython.Build import cythonize
import numpy as np

extensions = [
    Extension(
        "pyufbx",
        sources=[
            "src/pyufbx.pyx",
            "ufbx/ufbx.c"
        ],
        include_dirs=[
            ".",
            "src",
            np.get_include()
        ],
        extra_compile_args=["-std=c99"],
        language="c"
    )
]

setup(
    name="pyufbx",
    ext_modules=cythonize(extensions, compiler_directives={
                          'language_level': 3}),
    zip_safe=False,
)
