WRAPPER_TYPES = [
    ("Element", "ufbx_element", "_element"),
    ("Node", "ufbx_node", "_node"),
    ("Prop", "ufbx_prop", "_prop"),
    ("Transform", "ufbx_transform", "_transform"),
    # ("AnimValue", "ufbx_anim_value", "_anim_value"),
    # ("AnimCurve", "ufbx_anim_curve", "_anim_curve"),
    # ("DisplayLayer", "ufbx_display_layer", "_display_layer"),
    # ("SelectionSet", "ufbx_selection_set", "_selection_set"),
    # ("SelectionNode", "ufbx_selection_node", "_selection_node"),
    # ("Character", "ufbx_character", "_character"),
    # ("Constraint", "ufbx_constraint", "_constraint"),
    # ("AudioLayer", "ufbx_audio_layer", "_audio_layer"),
    # ("AudioClip", "ufbx_audio_clip", "_audio_clip"),
    # ("Pose", "ufbx_pose", "_pose"),
]

# Generate cache declarations
cache_template = """
cdef object _{name_lower}_cache_lock = Lock()
cdef object _{name_lower}_cache = WeakValueDictionary()
"""

# Generate wrapper functions
wrapper_template = """
cdef {class_name} wrap_{name_lower}({c_type} *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _{name_lower}_cache_lock:
        cached = _{name_lower}_cache.get(ptr_key, None)
        if cached is not None:
            return <{class_name}>cached
        
        obj = {class_name}()
        obj.{attr_name} = ptr
        _{name_lower}_cache[ptr_key] = obj
        return obj
"""

with open("src/generated/generated_wrappers.pxi", "w") as f:
    f.write("# Auto-generated wrapper functions\n")
    f.write("from weakref import WeakValueDictionary\n")
    f.write("from threading import Lock\n\n")

    # Generate caches
    for class_name, c_type, attr_name in WRAPPER_TYPES:
        name_lower = class_name.lower()
        f.write(cache_template.format(name_lower=name_lower))

    f.write("\n")

    # Generate wrappers
    for class_name, c_type, attr_name in WRAPPER_TYPES:
        name_lower = class_name.lower()
        f.write(
            wrapper_template.format(
                class_name=class_name,
                c_type=c_type,
                attr_name=attr_name,
                name_lower=name_lower,
            )
        )
        f.write("\n")
