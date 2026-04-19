# cython: language_level=3
from pufbx.pufbx cimport ufbx_nurbs_trim_surface

from ..props.prop cimport PropsWrapper
from .element cimport Element

include "../core/strings.pxi"


cdef class NurbsTrimSurface:
    """Represents a NURBS trim surface in the FBX structure."""

    def __cinit__(self):
        self._nurbs_trim_surface = NULL

    def __repr__(self):
        if self._nurbs_trim_surface == NULL:
            return "<NurbsTrimSurface None>"
        return f"<NurbsTrimSurface name='{self.name}'>"

    @property
    def name(self):
        if self._nurbs_trim_surface == NULL:
            return "None"
        return to_py_string(self._nurbs_trim_surface.name)

    @property
    def element_id(self):
        return self._nurbs_trim_surface.element_id

    @property
    def typed_id(self):
        return self._nurbs_trim_surface.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._nurbs_trim_surface.props)

    # Complex properties - TODO
    @property
    def instances(self):
        # TODO: instances add implementation
        raise NotImplementedError("instances is not implemented yet.")

