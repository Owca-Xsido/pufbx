"""Generate individual .pxi files for each list type."""

LIST_TYPES = [
    ("Element", "ufbx_element", "_element"),
    ("Node", "ufbx_node", "_node"),
    ("Bone", "ufbx_bone", "_bone"),
    # ("Property", "ufbx_property", "_property"),
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

TEMPLATE = '''cdef class {class_name}List:
    """A list-like wrapper for {item_type} pointers."""
    cdef {item_type} **_data
    cdef size_t _count

    @staticmethod
    cdef {class_name}List create({item_type} **data, size_t count):
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
                result.append(wrap{wrap_func}(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap{wrap_func}(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap{wrap_func}(self._data[i])

    def __repr__(self):
        return f"<{class_name}List count={{self._count}}>"
'''

import os

def generate_list_files():
    """Generate individual .pxi files for each list type."""
    output_dir = "pyufbx/generated/lists"
    os.makedirs(output_dir, exist_ok=True)
    
    for class_name, item_type, wrap_func in LIST_TYPES:
        filename = f"{class_name.lower()}_list.pxi"
        filepath = os.path.join(output_dir, filename)
        
        with open(filepath, "w") as f:
            f.write(
                TEMPLATE.format(
                    class_name=class_name,
                    item_type=item_type,
                    wrap_func=wrap_func
                )
            )
        
        print(f"Generated {filepath}")

if __name__ == "__main__":
    generate_list_files()