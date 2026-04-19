import glob
import os
import sys
from pathlib import Path

import numpy as np
from Cython.Build import cythonize
from setuptools import Extension, setup
from setuptools.command.build_ext import build_ext as _build_ext

ROOT = Path(__file__).parent.absolute()

COMMON_INCLUDE_DIRS = [
    np.get_include(),
    str(ROOT),
]

_UFBX_WIN_EXPORT_DEFS = [
    ("ufbx_abi", "__declspec(dllexport)"),
    ("ufbx_abi_data", "__declspec(dllexport)"),
    ("ufbx_abi_data_def", "__declspec(dllexport)"),
]

_UFBX_WIN_IMPORT_DEFS = [
    ("ufbx_abi", "__declspec(dllimport)"),
    ("ufbx_abi_data", "__declspec(dllimport)"),
]

_UFBX_WIN_LINK = frozenset(
    {
        "pyufbx.ufbx_wrapper",
        "pyufbx.scene",
        "pyufbx.animation.bake_anim",
    }
)


class build_ext(_build_ext):
    _ufbx_import_lib: str | None = None

    def run(self) -> None:
        if sys.platform == "win32":
            self.parallel = False
        super().run()

    def build_extension(self, ext) -> None:
        if sys.platform != "win32":
            super().build_extension(ext)
            return
        if ext.name == "pyufbx._ufbx":
            super().build_extension(ext)
            self._ufbx_import_lib = self._find_newest_ufbx_import_lib()
            if not self._ufbx_import_lib:
                raise RuntimeError(
                    "Built pyufbx._ufbx but could not find the MSVC import library (.lib). "
                    "If you use a non-MSVC toolchain on Windows, report this as a build issue."
                )
            return
        if ext.name in _UFBX_WIN_LINK:
            ext.extra_link_args = list(ext.extra_link_args or [])
            ext.extra_link_args.append(self._require_ufbx_import_lib())
        super().build_extension(ext)

    def _require_ufbx_import_lib(self) -> str:
        if not self._ufbx_import_lib:
            raise RuntimeError("pyufbx._ufbx must be built before other native modules on Windows")
        return self._ufbx_import_lib

    def _find_newest_ufbx_import_lib(self) -> str | None:
        if not self.build_temp:
            return None
        patterns = (
            os.path.join(self.build_temp, "**", "pyufbx._ufbx*.lib"),
            os.path.join(self.build_temp, "**", "_ufbx*.lib"),
        )
        candidates: list[str] = []
        for pattern in patterns:
            candidates.extend(glob.glob(pattern, recursive=True))
        candidates = list(dict.fromkeys(candidates))
        if not candidates:
            return None
        candidates.sort(key=lambda p: os.path.getmtime(p), reverse=True)
        return candidates[0]


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
extensions: list[Extension] = []

if sys.platform == "win32":
    extensions.append(
        Extension(
            "pyufbx._ufbx",
            sources=["pyufbx/_ufbx.c", "ufbx/ufbx.c"],
            include_dirs=COMMON_INCLUDE_DIRS,
            define_macros=_UFBX_WIN_EXPORT_DEFS,
        )
    )

for module_name in all_modules:
    pyx_path = module_name.replace(".", "/") + ".pyx"

    if sys.platform == "win32":
        if module_name in _UFBX_WIN_LINK:
            sources = [pyx_path]
            macros = list(_UFBX_WIN_IMPORT_DEFS)
        else:
            sources = [pyx_path]
            macros = []
    else:
        if module_name in ("pyufbx.ufbx_wrapper",):
            sources = [pyx_path, "ufbx/ufbx.c"]
            macros = []
        else:
            sources = [pyx_path]
            macros = []

    extensions.append(
        Extension(
            module_name,
            sources=sources,
            include_dirs=COMMON_INCLUDE_DIRS,
            define_macros=macros,
        )
    )

setup(
    ext_modules=cythonize(
        extensions,
        compiler_directives={"language_level": "3"},
    ),
    cmdclass={"build_ext": build_ext},
)
