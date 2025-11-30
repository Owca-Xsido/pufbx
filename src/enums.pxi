from enum import IntEnum, IntFlag


class ElementType(IntEnum):
    """Enum representing ufbx element types."""

    def __str__(self):
        return self.name

    def __repr__(self):
        return f"ElementType.{self.name}"
    UNKNOWN = 0
    NODE = 1
    MESH = 2
    LIGHT = 3
    CAMERA = 4
    BONE = 5
    EMPTY = 6
    LINE_CURVE = 7
    NURBS_CURVE = 8
    NURBS_SURFACE = 9
    NURBS_TRIM_SURFACE = 10
    NURBS_TRIM_BOUNDARY = 11
    PROCEDURAL_GEOMETRY = 12
    STEREO_CAMERA = 13
    CAMERA_SWITCHER = 14
    MARKER = 15
    LOD_GROUP = 16
    SKIN_DEFORMER = 17
    SKIN_CLUSTER = 18
    BLEND_DEFORMER = 19
    BLEND_CHANNEL = 20
    BLEND_SHAPE = 21
    CACHE_DEFORMER = 22
    CACHE_FILE = 23
    MATERIAL = 24
    TEXTURE = 25
    VIDEO = 26
    SHADER = 27
    SHADER_BINDING = 28
    ANIM_STACK = 29
    ANIM_LAYER = 30
    ANIM_VALUE = 31
    ANIM_CURVE = 32
    DISPLAY_LAYER = 33
    SELECTION_SET = 34
    SELECTION_NODE = 35
    CHARACTER = 36
    CONSTRAINT = 37
    AUDIO_LAYER = 38
    AUDIO_CLIP = 39
    POSE = 40
    METADATA_OBJECT = 41

class PropType(IntEnum):
    """Enum representing ufbx property types."""

    def __str__(self):
        return self.name

    def __repr__(self):
        return f"PropType.{self.name}"
    UNKNOWN = 0
    BOOLEAN = 1
    INTEGER = 2
    NUMBER = 3
    VECTOR = 4
    COLOR = 5
    COLOR_WITH_ALPHA = 6
    STRING = 7
    DATE_TIME = 8
    TRANSLATION = 9
    ROTATION = 10
    SCALING = 11
    DISTANCE = 12
    COMPOUND = 13
    BLOB = 14
    REFERENCE = 15
    TYPE_COUNT = 16


class PropFlags(IntFlag):
    """
    Property flags: Advanced information about properties, not usually needed.
    
    These flags can be combined using bitwise operations.
    """

    def __str__(self):
        return self.name
    def __repr__(self):
        return self.__str__()
    # Supports animation.
    # NOTE: ufbx ignores this and allows animations on non-animatable properties.
    ANIMATABLE = 0x1
    
    # User defined (custom) property.
    USER_DEFINED = 0x2
    
    # Hidden in UI.
    HIDDEN = 0x4
    
    # Disallow modification from UI for components.
    LOCK_X = 0x10
    LOCK_Y = 0x20
    LOCK_Z = 0x40
    LOCK_W = 0x80
    
    # Disable animation from components.
    MUTE_X = 0x100
    MUTE_Y = 0x200
    MUTE_Z = 0x400
    MUTE_W = 0x800
    
    # Property created by ufbx when an element has a connected `ufbx_anim_prop`
    # but doesn't contain the `ufbx_prop` it's referring to.
    # NOTE: The property may have been found in the templated defaults.
    SYNTHETIC = 0x1000
    
    # The property has at least one `ufbx_anim_prop` in some layer.
    ANIMATED = 0x2000
    
    # Used by `ufbx_evaluate_prop()` to indicate the property was not found.
    NOT_FOUND = 0x4000
    
    # The property is connected to another one.
    # This use case is relatively rare so `ufbx_prop` does not track connections
    # directly. You can find connections from `ufbx_element.connections_dst` where
    # `ufbx_connection.dst_prop` is this property and `ufbx_connection.src_prop` is defined.
    CONNECTED = 0x8000
    
    # The value of this property is undefined (represented as zero).
    NO_VALUE = 0x10000
    
    # This property has been overridden by the user.
    # See `ufbx_anim.prop_overrides` for more information.
    OVERRIDDEN = 0x20000
    
    # Value type.
    # `REAL/VEC2/VEC3/VEC4` are mutually exclusive but may coexist with eg. `STRING`
    # in some rare cases where the string defines the unit for the vector.
    VALUE_REAL = 0x100000
    VALUE_VEC2 = 0x200000
    VALUE_VEC3 = 0x400000
    VALUE_VEC4 = 0x800000
    VALUE_INT  = 0x1000000
    VALUE_STR  = 0x2000000
    VALUE_BLOB = 0x4000000

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