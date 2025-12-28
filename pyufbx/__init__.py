"""PyUFBX - Python FBX file parser"""

__version__ = "0.1.0"

# Only import the entry point eagerly
from pyufbx.ufbx_wrapper import load_fbx

__all__ = ["load_fbx"]

# Lazy import everything else


def __getattr__(name):
    if name == "Anim":
        from pyufbx.animation.anim import Anim

        return Anim
    elif name == "Scene":
        from pyufbx.scene import Scene

        return Scene
    elif name == "Bone":
        from pyufbx.elements.bone import Bone

        return Bone
    elif name == "Transform":
        from pyufbx.core.transform import Transform

        return Transform
    elif name == "PropsWrapper":
        from pyufbx.props.prop import PropsWrapper

        return PropsWrapper
    elif name in ("Vec2Property", "Vec3Property", "Vec4Property", "QuatProperty"):
        from pyufbx.core.math_types import (QuatProperty, Vec2Property,
                                            Vec3Property, Vec4Property)

        return locals()[name]
    elif name == "Node":
        from pyufbx.elements.node import Node

        return Node
    elif name == "Element":
        from pyufbx.elements.element import Element

        return Element
    elif name == "InheritMode":
        from pyufbx.elements.node import InheritMode

        return InheritMode
    elif name == "ElementList":
        from pyufbx.generated.lists import ElementList

        return ElementList
    elif name == "NodeList":
        from pyufbx.generated.lists import NodeList

        return NodeList

    elif name == "PropType":
        from pyufbx.enums import PropType

        return PropType

    elif name == "Interpolation":
        from pyufbx.enums import Interpolation

        return Interpolation

    elif name == "RotationOrder":
        from pyufbx.enums import RotationOrder

        return RotationOrder

    elif name == "PropFlags":
        from pyufbx.enums import PropFlags

        return PropFlags

    raise AttributeError(f"module 'pyufbx' has no attribute '{name}'")
