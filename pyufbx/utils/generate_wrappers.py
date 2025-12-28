"""Generate wrappers.pyx and wrappers.pxd for wrapper functions."""

import os

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


def generate_wrapper_files():
    """Generate wrappers.pyx and wrappers.pxd files."""
    output_dir = "pyufbx/generated"
    os.makedirs(output_dir, exist_ok=True)
    imported_types = ", ".join([f"{c_type}" for _, c_type, _, parrent in WRAPPER_TYPES])

    # Generate .pxd (declarations)
    pxd_path = os.path.join(output_dir, "wrappers.pxd")
    with open(pxd_path, "w") as f:
        f.write("# cython: language_level=3\n")
        f.write(f"from pyufbx.pyufbx cimport {imported_types}\n")

        # Import the classes we're wrapping
        for class_name, c_type, field_name, parrent in WRAPPER_TYPES:
            f.write(f"from pyufbx.{parrent} cimport {class_name}\n")

        f.write("\n")

        # Declare wrapper functions
        for class_name, c_type, field_name, _ in WRAPPER_TYPES:
            attr_name = field_name.lstrip("_")
            f.write(f"cdef {class_name} wrap_{attr_name}({c_type} *ptr)\n")

    print(f"Generated {pxd_path}")

    # Generate .pyx (implementations)
    pyx_path = os.path.join(output_dir, "wrappers.pyx")
    with open(pyx_path, "w") as f:
        f.write("# cython: language_level=3\n")
        f.write("from weakref import WeakValueDictionary\n")
        f.write("from threading import Lock\n")
        f.write(f"from pyufbx.pyufbx cimport {imported_types}\n")

        # Import the classes we're wrapping
        for class_name, c_type, field_name, parrent in WRAPPER_TYPES:
            f.write(f"from pyufbx.{parrent} cimport {class_name}\n")

        f.write("\n")

        # Write all caches
        for class_name, c_type, field_name, _ in WRAPPER_TYPES:
            attr_name = field_name.lstrip("_")
            f.write(CACHE_TEMPLATE.format(class_name=class_name, attr_name=attr_name))

        f.write("\n")

        # Write all wrapper functions
        for class_name, c_type, field_name, _ in WRAPPER_TYPES:
            attr_name = field_name.lstrip("_")
            f.write(
                WRAPPER_TEMPLATE.format(
                    class_name=class_name,
                    c_type=c_type,
                    attr_name=attr_name,
                    field_name=field_name,
                )
            )

    print(f"Generated {pyx_path}")


if __name__ == "__main__":
    generate_wrapper_files()
