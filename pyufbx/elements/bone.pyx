

from .element cimport Element
from .node cimport Node

include "../core/strings.pxi"
include "../generated/lists/bone_list.pxi"
include "../generated/generated_wrappers.pxi"

cdef class Bone:

    @property
    def element(self):
        """Returns the Element wrapper for this bone's element field."""
        if self._bone == NULL:
            return None
        element_obj = Element()
        element_obj._element = &self._bone.element  # Take address of the union
        return element_obj  # Return the Python wrapper, not the C pointer

    @property
    def name(self):
        return to_py_string(self._bone.element.name)

    @property
    def instance(self):
        return NodeList.create(self._bone.element.instances.data, self._bone.element.instances.count)

    @property
    def radius(self):
        return self._bone.radius

    @property
    def relative_length(self):
        return self._bone.relative_length

    @property
    def is_root(self):
        return self._bone.is_root
