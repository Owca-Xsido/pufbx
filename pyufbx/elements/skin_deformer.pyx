# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_skin_deformer

from ..generated.lists cimport SkinClusterList
from ..props.prop cimport PropsWrapper
from .element cimport Element

include "../core/strings.pxi"


cdef class SkinDeformer:
    """Represents a skin deformer in the FBX structure."""

    def __cinit__(self):
        self._skin_deformer = NULL

    def __repr__(self):
        if self._skin_deformer == NULL:
            return "<SkinDeformer None>"
        return f"<SkinDeformer name='{self.name}'>"

    @property
    def name(self):
        if self._skin_deformer == NULL:
            return "None"
        return to_py_string(self._skin_deformer.name)

    @property
    def element_id(self):
        return self._skin_deformer.element_id

    @property
    def typed_id(self):
        return self._skin_deformer.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._skin_deformer.props)

    @property
    def clusters(self):
        return SkinClusterList.create(self._skin_deformer.clusters.data, self._skin_deformer.clusters.count)

