"""Generate individual .pxi files for each list type."""

import os
import re

LIST_TYPES = [
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

# Updated Template with {addr} support
TEMPLATE = '''cdef class {class_name}List:
    """A list-like wrapper for {item_type} pointers."""

    @staticmethod
    cdef {class_name}List create({item_type} {pointer_type}data, size_t count):
        cdef {class_name}List obj = {class_name}List.__new__({class_name}List)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap{wrap_func}({addr}self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap{wrap_func}({addr}self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap{wrap_func}({addr}self._data[i])

    def __repr__(self):
        return f"<{class_name}List count={{self._count}}>"
'''


def get_pointer_type(pxd_content, item_type):
    """
    Finds if the list struct uses * or ** by isolating the struct block first.
    """
    list_struct_name = f"{item_type}_list"

    # 1. Isolate the struct definition block
    # Matches from 'cdef struct name:' until the next 'cdef' or empty line
    struct_block_re = rf"cdef struct {list_struct_name}:(.*?)(?=\n\w|\Z)"
    block_match = re.search(struct_block_re, pxd_content, re.DOTALL)

    if block_match:
        block_text = block_match.group(1)
        # 2. Find the 'data' member inside THIS block only
        data_re = rf"{item_type}\s*(?P<stars>\**)\s*data"
        data_match = re.search(data_re, block_text)

        if data_match:
            stars = data_match.group("stars").strip()
            # If stars is empty string, it's a single pointer '*'
            return stars if stars else "*"

    # Fallback logic if struct isn't found
    # ufbx_texture_file is a known 'Data' type (*)
    if "texture_file" in item_type or "prop" in item_type:
        return "*"

    # Default for objects (Nodes, Mesh, Metadata, etc) is **
    return "**"


def generate_list_files():
    output_dir = "pyufbx/generated"
    os.makedirs(output_dir, exist_ok=True)

    pxd_source_path = "pyufbx/pyufbx.pxd"
    try:
        with open(pxd_source_path, "r") as f:
            pxd_content = f.read()
    except FileNotFoundError:
        print(f"Error: {pxd_source_path} not found. Defaulting to '**'.")
        pxd_content = ""

    imported_types = ", ".join([item_type for _, item_type, _, _ in LIST_TYPES])

    # --- 1. Generate .pxd ---
    pxd_path = os.path.join(output_dir, "lists.pxd")
    with open(pxd_path, "w") as f:
        f.write("# cython: language_level=3\n")
        f.write(f"from pyufbx.pyufbx cimport {imported_types}\n\n")

        for class_name, item_type, _, _ in LIST_TYPES:
            ptr = get_pointer_type(pxd_content, item_type)
            f.write(f"cdef class {class_name}List:\n")
            f.write(f"    cdef {item_type} {ptr}_data\n")
            f.write(f"    cdef size_t _count\n")
            f.write(f"    @staticmethod\n")
            f.write(f"    cdef {class_name}List create({item_type} {ptr}data, size_t count)\n\n")

    # --- 2. Generate .pyx ---
    pyx_path = os.path.join(output_dir, "lists.pyx")
    with open(pyx_path, "w") as f:
        wrap_funcs = ", ".join([f"wrap{w}" for _, _, w, _ in LIST_TYPES])
        f.write("# cython: language_level=3\n")
        f.write(f"from pyufbx.pyufbx cimport {imported_types}\n")
        f.write(f"from .wrappers cimport {wrap_funcs}\n\n")

        for class_name, item_type, wrap_func, _ in LIST_TYPES:
            ptr = get_pointer_type(pxd_content, item_type)

            # Logic: If list is ufbx_type*, we need &self._data[i] to get a ufbx_type*
            # If list is ufbx_type**, self._data[i] is already a ufbx_type*
            addr_op = "&" if ptr == "*" else ""

            f.write(
                TEMPLATE.format(
                    class_name=class_name,
                    item_type=item_type,
                    wrap_func=wrap_func,
                    pointer_type=ptr,
                    addr=addr_op,
                )
            )
            f.write("\n\n")

    print(f"Generated {pxd_path} and {pyx_path}")


if __name__ == "__main__":
    generate_list_files()
