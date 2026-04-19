# cython: language_level=3
from pufbx.pufbx cimport ufbx_selection_set

from ..props.prop cimport PropsWrapper
from .element cimport Element

include "../core/strings.pxi"


cdef class SelectionSet:
    """Represents a selection set in the FBX structure."""

    def __cinit__(self):
        self._selection_set = NULL

    def __repr__(self):
        if self._selection_set == NULL:
            return "<SelectionSet None>"
        return f"<SelectionSet name='{self.name}'>"

    @property
    def name(self):
        if self._selection_set == NULL:
            return "None"
        return to_py_string(self._selection_set.name)

    @property
    def element_id(self):
        return self._selection_set.element_id

    @property
    def typed_id(self):
        return self._selection_set.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._selection_set.props)

    # Complex properties - TODO
    @property
    def nodes(self):
        # TODO: nodes add implementation
        raise NotImplementedError("nodes is not implemented yet.")

