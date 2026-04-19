"""pufbx - Python FBX file parser"""

from importlib.metadata import version as _get_version

try:
    __version__ = _get_version("pufbx")
except Exception:
    __version__ = "0.0.0"

import ctypes as _ctypes
import importlib.util as _importlib_util

# On Linux/macOS: load ufbx_wrapper with RTLD_GLOBAL so its ufbx C symbols
# (string constants, ufbx_free_scene, ufbx_bake_anim, etc.) are visible to
# all other extension modules. ufbx uses pointer identity for interned strings,
# so all ufbx code must share a single compiled copy.
# On Windows: load the shared pufbx._ufbx extension first so ufbx.c exists in
# exactly one DLL; ufbx_wrapper, scene, and bake_anim link against it (setup.py).
import sys as _sys

if _sys.platform == "win32":
    import pufbx._ufbx as _pufbx_ufbx  # noqa: F401

if _sys.platform != "win32":
    _spec = _importlib_util.find_spec("pufbx.ufbx_wrapper")
    if _spec and _spec.origin:
        _ctypes.CDLL(_spec.origin, mode=_ctypes.RTLD_GLOBAL)

# Only import the entry point eagerly
from pufbx.ufbx_wrapper import load_fbx

__all__ = [
    "load_fbx",
    "UFBXError",
    "ErrorType",
    "bake_anim",
    "anim_to_array",
    "Anim",
    "Scene",
    "Bone",
    "Transform",
    "PropsWrapper",
    "Vec2Property",
    "Vec3Property",
    "Vec4Property",
    "QuatProperty",
    "Node",
    "Element",
    "InheritMode",
    "ElementList",
    "NodeList",
    "AnimCurveList",
    "KeyframeList",
    "PropType",
    "Interpolation",
    "RotationOrder",
    "PropFlags",
]

# Lazy import everything else


def __getattr__(name):
    if name == "Anim":
        from pufbx.animation.anim import Anim

        return Anim
    elif name == "Scene":
        from pufbx.scene import Scene

        return Scene
    elif name == "Bone":
        from pufbx.elements.bone import Bone

        return Bone
    elif name == "Transform":
        from pufbx.core.transform import Transform

        return Transform
    elif name == "PropsWrapper":
        from pufbx.props.prop import PropsWrapper

        return PropsWrapper
    elif name in ("Vec2Property", "Vec3Property", "Vec4Property", "QuatProperty"):
        from pufbx.core.math_types import QuatProperty, Vec2Property, Vec3Property, Vec4Property

        return locals()[name]
    elif name == "Node":
        from pufbx.elements.node import Node

        return Node
    elif name == "Element":
        from pufbx.elements.element import Element

        return Element
    elif name == "InheritMode":
        from pufbx.elements.node import InheritMode

        return InheritMode
    elif name == "ElementList":
        from pufbx.generated.lists import ElementList

        return ElementList
    elif name == "NodeList":
        from pufbx.generated.lists import NodeList

        return NodeList
    elif name == "AnimCurveList":
        from pufbx.generated.lists import AnimCurveList

        return AnimCurveList
    elif name == "KeyframeList":
        from pufbx.animation.keyframe import KeyframeList

        return KeyframeList
    elif name == "UFBXError":
        from pufbx.errors import UFBXError

        return UFBXError
    elif name == "ErrorType":
        from pufbx.errors import ErrorType

        return ErrorType
    elif name == "bake_anim":
        from pufbx.animation.bake_anim import bake_anim

        return bake_anim
    elif name == "anim_to_array":
        from pufbx.animation.bake_anim import anim_to_array

        return anim_to_array
    elif name == "PropType":
        from pufbx.enums import PropType

        return PropType

    elif name == "Interpolation":
        from pufbx.enums import Interpolation

        return Interpolation

    elif name == "RotationOrder":
        from pufbx.enums import RotationOrder

        return RotationOrder

    elif name == "PropFlags":
        from pufbx.enums import PropFlags

        return PropFlags

    raise AttributeError(f"module 'pufbx' has no attribute '{name}'")
