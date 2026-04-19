# cython: language_level=3
from pufbx.pufbx cimport ufbx_display_layer

from ..props.prop cimport PropsWrapper
from .element cimport Element

include "../core/strings.pxi"


cdef class DisplayLayer:
    """Represents a display layer in the FBX structure."""

    def __cinit__(self):
        self._display_layer = NULL

    def __repr__(self):
        if self._display_layer == NULL:
            return "<DisplayLayer None>"
        return f"<DisplayLayer name='{self.name}'>"

    @property
    def name(self):
        if self._display_layer == NULL:
            return "None"
        return to_py_string(self._display_layer.name)

    @property
    def element_id(self):
        return self._display_layer.element_id

    @property
    def typed_id(self):
        return self._display_layer.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._display_layer.props)

    # Simple properties
    @property
    def visible(self):
        return <bint> self._display_layer.visible

    @property
    def frozen(self):
        return <bint> self._display_layer.frozen

    # Complex properties - TODO
    @property
    def nodes(self):
        # TODO: nodes add implementation
        raise NotImplementedError("nodes is not implemented yet.")

