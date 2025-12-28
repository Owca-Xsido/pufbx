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
    # Add others as needed

    raise AttributeError(f"module 'pyufbx' has no attribute '{name}'")
