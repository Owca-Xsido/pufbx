# cython: language_level=3
from pufbx.pufbx cimport ufbx_selection_node

from ..props.prop cimport PropsWrapper
from .element cimport Element

include "../core/strings.pxi"


cdef class SelectionNode:
    """Represents a selection node in the FBX structure."""

    def __cinit__(self):
        self._selection_node = NULL

    def __repr__(self):
        if self._selection_node == NULL:
            return "<SelectionNode None>"
        return f"<SelectionNode name='{self.name}'>"

    @property
    def name(self):
        if self._selection_node == NULL:
            return "None"
        return to_py_string(self._selection_node.name)

    @property
    def element_id(self):
        return self._selection_node.element_id

    @property
    def typed_id(self):
        return self._selection_node.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._selection_node.props)

    # Complex properties - TODO
    @property
    def node(self):
        # TODO: node add implementation
        raise NotImplementedError("node is not implemented yet.")

    @property
    def selection_set(self):
        # TODO: selection_set add implementation
        raise NotImplementedError("selection_set is not implemented yet.")

