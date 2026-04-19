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
