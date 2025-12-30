


from ..generated.lists cimport BoneList, NodeList
from .element cimport Element
from .node cimport Node

include "../core/strings.pxi"

cdef class Bone:
    """Represents a bone in the FBX structure."""

    @property
    def radius(self):
        return self._bone.radius

    @property
    def relative_length(self):
        return self._bone.relative_length

    @property
    def is_root(self):
        return self._bone.is_root
    def is_root(self):
        return self._bone.is_root
