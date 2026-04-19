# cython: language_level=3
from pufbx.pufbx cimport ufbx_marker

from ..props.prop cimport PropsWrapper
from .element cimport Element

include "../core/strings.pxi"


cdef class Marker:
    """Represents a marker in the FBX structure."""

    def __cinit__(self):
        self._marker = NULL

    def __repr__(self):
        if self._marker == NULL:
            return "<Marker None>"
        return f"<Marker name='{self.name}'>"

    @property
    def name(self):
        if self._marker == NULL:
            return "None"
        return to_py_string(self._marker.name)

    @property
    def element_id(self):
        return self._marker.element_id

    @property
    def typed_id(self):
        return self._marker.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._marker.props)

    # Simple properties
    @property
    def marker_type(self):
        # TODO: Create MarkerType enum if needed
        return <int> self._marker.type

    # Complex properties - TODO
    @property
    def instances(self):
        # TODO: instances add implementation
        raise NotImplementedError("instances is not implemented yet.")

