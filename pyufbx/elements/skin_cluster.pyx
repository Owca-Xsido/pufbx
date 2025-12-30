# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_skin_cluster

from ..props.prop cimport PropsWrapper
from .element cimport Element

include "../core/strings.pxi"


cdef class SkinCluster:
    """Represents a skin cluster in the FBX structure."""

    def __cinit__(self):
        self._skin_cluster = NULL

    def __repr__(self):
        if self._skin_cluster == NULL:
            return "<SkinCluster None>"
        return f"<SkinCluster name='{self.name}'>"

    @property
    def name(self):
        if self._skin_cluster == NULL:
            return "None"
        return to_py_string(self._skin_cluster.name)

    @property
    def element_id(self):
        return self._skin_cluster.element_id

    @property
    def typed_id(self):
        return self._skin_cluster.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._skin_cluster.props)

    # Complex properties - TODO
    @property
    def bone(self):
        # TODO: bone add implementation
        raise NotImplementedError("bone is not implemented yet.")

    @property
    def weights(self):
        # TODO: weights add implementation
        raise NotImplementedError("weights is not implemented yet.")

