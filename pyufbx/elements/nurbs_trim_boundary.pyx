# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_nurbs_trim_boundary

from ..props.prop cimport PropsWrapper
from .element cimport Element

include "../core/strings.pxi"


cdef class NurbsTrimBoundary:
    """Represents a NURBS trim boundary in the FBX structure."""

    def __cinit__(self):
        self._nurbs_trim_boundary = NULL

    def __repr__(self):
        if self._nurbs_trim_boundary == NULL:
            return "<NurbsTrimBoundary None>"
        return f"<NurbsTrimBoundary name='{self.name}'>"

    @property
    def name(self):
        if self._nurbs_trim_boundary == NULL:
            return "None"
        return to_py_string(self._nurbs_trim_boundary.name)

    @property
    def element_id(self):
        return self._nurbs_trim_boundary.element_id

    @property
    def typed_id(self):
        return self._nurbs_trim_boundary.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._nurbs_trim_boundary.props)

    # Complex properties - TODO
    @property
    def instances(self):
        # TODO: instances add implementation
        raise NotImplementedError("instances is not implemented yet.")

