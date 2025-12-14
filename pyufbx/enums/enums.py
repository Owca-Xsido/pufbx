from enum import IntEnum, IntFlag




class InheritMode(IntEnum):
    """Enum representing ufbx node transform inheritance modes."""
    
    def __str__(self):
        return self.name
    
    def __repr__(self):
        return f"InheritMode.{self.name}"
    
    NORMAL = 0
    IGNORE_PARENT_SCALE = 1
    COMPONENTWISE_SCALE = 2


# enum for rotation Order
class RotationOrder(IntEnum):
    """Enum representing ufbx node rotation order modes."""

    def __str__(self):
        return self.name
    
    def __repr__(self):
        return f"InheritMode.{self.name}"
    UFBX_ROTATION_ORDER_XYZ	= 0
    UFBX_ROTATION_ORDER_XZY	= 1
    UFBX_ROTATION_ORDER_YZX	= 2
    UFBX_ROTATION_ORDER_YXZ	= 3
    UFBX_ROTATION_ORDER_ZXY	= 4
    UFBX_ROTATION_ORDER_ZYX	= 5
    UFBX_ROTATION_ORDER_SPHERIC	= 6
    UFBX_ROTATION_ORDER_COUNT = 7