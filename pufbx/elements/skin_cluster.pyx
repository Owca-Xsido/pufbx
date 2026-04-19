# cython: language_level=3
from pufbx.pufbx cimport ufbx_skin_cluster

from ..generated.wrappers cimport wrap_node
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

    @property
    def bone_node(self):
        if self._skin_cluster.bone_node == NULL:
            return None
        return wrap_node(self._skin_cluster.bone_node)

    @property
    def num_weights(self):
        return self._skin_cluster.num_weights

