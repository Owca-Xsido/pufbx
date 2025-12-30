"""Generate wrappers.pyx and wrappers.pxd for wrapper functions."""

import os
import re

WRAPPER_TYPES = [
    ("Element", "ufbx_element", "_element", "elements.element"),
    ("Node", "ufbx_node", "_node", "elements.node"),
    ("Prop", "ufbx_prop", "_prop", "props.prop"),
    ("Transform", "ufbx_transform", "_transform", "core.transform"),
    ("Bone", "ufbx_bone", "_bone", "elements.bone"),
    ("Anim", "ufbx_anim", "_anim", "animation.anim"),
    ("AnimValue", "ufbx_anim_value", "_anim_value", "animation.anim"),
    ("AnimCurve", "ufbx_anim_curve", "_anim_curve", "animation.anim_curve"),
    ("Keyframe", "ufbx_keyframe", "_keyframe", "animation.keyframe"),
    ("AnimProp", "ufbx_anim_prop", "_anim_prop", "animation.anim"),
    ("AnimLayer", "ufbx_anim_layer", "_anim_layer", "animation.anim"),
    ("BakedAnim", "ufbx_baked_anim", "_baked_anim", "animation.bake_anim"),
    ("BakedNode", "ufbx_baked_node", "_baked_node", "elements.node"),
    # Node Attributes (Common)
    ("Mesh", "ufbx_mesh", "_mesh", "elements.mesh"),
    ("Light", "ufbx_light", "_light", "elements.light"),
    ("Camera", "ufbx_camera", "_camera", "elements.camera"),
    ("Empty", "ufbx_empty", "_empty", "elements.empty"),
    # Node Attributes (Curves/Surfaces)
    ("LineCurve", "ufbx_line_curve", "_line_curve", "elements.line_curve"),
    ("NurbsCurve", "ufbx_nurbs_curve", "_nurbs_curve", "elements.nurbs_curve"),
    ("NurbsSurface", "ufbx_nurbs_surface", "_nurbs_surface", "elements.nurbs_surface"),
    (
        "NurbsTrimSurface",
        "ufbx_nurbs_trim_surface",
        "_nurbs_trim_surface",
        "elements.nurbs_trim_surface",
    ),
    (
        "NurbsTrimBoundary",
        "ufbx_nurbs_trim_boundary",
        "_nurbs_trim_boundary",
        "elements.nurbs_trim_boundary",
    ),
    # Node Attributes (Advanced)
    (
        "ProceduralGeometry",
        "ufbx_procedural_geometry",
        "_procedural_geometry",
        "elements.procedural_geometry",
    ),
    ("StereoCamera", "ufbx_stereo_camera", "_stereo_camera", "elements.stereo_camera"),
    (
        "CameraSwitcher",
        "ufbx_camera_switcher",
        "_camera_switcher",
        "elements.camera_switcher",
    ),
    ("Marker", "ufbx_marker", "_marker", "elements.marker"),
    ("LodGroup", "ufbx_lod_group", "_lod_group", "elements.lod_group"),
    # Deformers
    ("SkinDeformer", "ufbx_skin_deformer", "_skin_deformer", "elements.skin_deformer"),
    ("SkinCluster", "ufbx_skin_cluster", "_skin_cluster", "elements.skin_cluster"),
    (
        "BlendDeformer",
        "ufbx_blend_deformer",
        "_blend_deformer",
        "elements.blend_deformer",
    ),
    ("BlendChannel", "ufbx_blend_channel", "_blend_channel", "elements.blend_channel"),
    ("BlendShape", "ufbx_blend_shape", "_blend_shape", "elements.blend_shape"),
    (
        "CacheDeformer",
        "ufbx_cache_deformer",
        "_cache_deformer",
        "elements.cache_deformer",
    ),
    ("CacheFile", "ufbx_cache_file", "_cache_file", "elements.cache_file"),
    # Materials
    ("Material", "ufbx_material", "_material", "materials.material"),
    ("Texture", "ufbx_texture", "_texture", "materials.texture"),
    ("Video", "ufbx_video", "_video", "materials.video"),
    ("Shader", "ufbx_shader", "_shader", "materials.shader"),
    (
        "ShaderBinding",
        "ufbx_shader_binding",
        "_shader_binding",
        "materials.shader_binding",
    ),
    # Animation
    ("AnimStack", "ufbx_anim_stack", "_anim_stack", "animation.anim_stack"),
    # Collections
    ("DisplayLayer", "ufbx_display_layer", "_display_layer", "elements.display_layer"),
    ("SelectionSet", "ufbx_selection_set", "_selection_set", "elements.selection_set"),
    (
        "SelectionNode",
        "ufbx_selection_node",
        "_selection_node",
        "elements.selection_node",
    ),
    # Constraints
    ("Character", "ufbx_character", "_character", "elements.character"),
    ("Constraint", "ufbx_constraint", "_constraint", "elements.constraint"),
    # Audio
    ("AudioLayer", "ufbx_audio_layer", "_audio_layer", "audio.audio_layer"),
    ("AudioClip", "ufbx_audio_clip", "_audio_clip", "audio.audio_clip"),
    # Miscellaneous
    ("Pose", "ufbx_pose", "_pose", "elements.pose"),
    (
        "MetadataObject",
        "ufbx_metadata_object",
        "_metadata_object",
        "elements.metadata_object",
    ),
    ("TextureFile", "ufbx_texture_file", "_texture_file", "materials.texture_file"),
]

CACHE_TEMPLATE = """# Cache for {class_name}
cdef object _{attr_name}_cache_lock = Lock()
cdef object _{attr_name}_cache = WeakValueDictionary()
"""

WRAPPER_TEMPLATE = """
cdef {class_name} wrap_{attr_name}({c_type} *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _{attr_name}_cache_lock:
        cached = _{attr_name}_cache.get(ptr_key, None)
        if cached is not None:
            return <{class_name}>cached
        
        obj = {class_name}()
        obj.{field_name} = ptr
        _{attr_name}_cache[ptr_key] = obj
        return obj
"""


def get_pointer_type(pxd_content, item_type):
    """
    Finds if the list struct uses * or **.
    Example: searches for 'cdef struct ufbx_texture_file_list'
    """
    list_struct_name = f"{item_type}_list"
    # Matches: cdef struct ufbx_something_list: ... ufbx_something **data
    pattern = rf"cdef struct {list_struct_name}:.*?{item_type}\s+(?P<stars>\**)\s*data"
    match = re.search(pattern, pxd_content, re.DOTALL)

    if match:
        return match.group("stars")
    return "**"  # Fallback to double pointer for safety


def generate_wrapper_files():
    output_dir = "pyufbx/generated"
    os.makedirs(output_dir, exist_ok=True)

    # Load pxd to check pointer depth
    pxd_source_path = "pyufbx/pyufbx.pxd"
    with open(pxd_source_path, "r") as f:
        pxd_content = f.read()

    imported_types = ", ".join([f"{c_type}" for _, c_type, _, _ in WRAPPER_TYPES])

    # 1. Generate .pxd (declarations)
    pxd_path = os.path.join(output_dir, "wrappers.pxd")
    with open(pxd_path, "w") as f:
        f.write("# cython: language_level=3\n")
        f.write(f"from pyufbx.pyufbx cimport {imported_types}\n")
        for class_name, _, _, parent in WRAPPER_TYPES:
            f.write(f"from pyufbx.{parent} cimport {class_name}\n")
        f.write("\n")

        for class_name, c_type, field_name, _ in WRAPPER_TYPES:
            attr_name = field_name.lstrip("_")
            # All wrappers accept a SINGLE pointer to the struct
            f.write(f"cdef {class_name} wrap_{attr_name}({c_type} *ptr)\n")

    # 2. Generate .pyx (implementations)
    pyx_path = os.path.join(output_dir, "wrappers.pyx")
    with open(pyx_path, "w") as f:
        f.write("# cython: language_level=3\n")
        f.write("from weakref import WeakValueDictionary\n")
        f.write("from threading import Lock\n")
        f.write(f"from pyufbx.pyufbx cimport {imported_types}\n")
        for class_name, _, _, parent in WRAPPER_TYPES:
            f.write(f"from pyufbx.{parent} cimport {class_name}\n")
        f.write("\n")

        # Write Caches and Wrapper Functions
        for class_name, c_type, field_name, _ in WRAPPER_TYPES:
            attr_name = field_name.lstrip("_")
            f.write(CACHE_TEMPLATE.format(class_name=class_name, attr_name=attr_name))
            f.write(
                WRAPPER_TEMPLATE.format(
                    class_name=class_name,
                    c_type=c_type,
                    attr_name=attr_name,
                    field_name=field_name,
                )
            )

    print(f"Generated wrappers for {len(WRAPPER_TYPES)} types.")


if __name__ == "__main__":
    generate_wrapper_files()
