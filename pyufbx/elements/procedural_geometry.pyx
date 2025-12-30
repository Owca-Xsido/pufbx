# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_procedural_geometry

from ..props.prop cimport PropsWrapper
from .element cimport Element

include "../core/strings.pxi"


cdef class ProceduralGeometry:
    """Represents a procedural geometry in the FBX structure."""

    def __cinit__(self):
        self._procedural_geometry = NULL

    def __repr__(self):
        if self._procedural_geometry == NULL:
            return "<ProceduralGeometry None>"
        return f"<ProceduralGeometry name='{self.name}'>"

    @property
    def name(self):
        if self._procedural_geometry == NULL:
            return "None"
        return to_py_string(self._procedural_geometry.name)

    @property
    def element_id(self):
        return self._procedural_geometry.element_id

    @property
    def typed_id(self):
        return self._procedural_geometry.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._procedural_geometry.props)

    # Complex properties - TODO
    @property
    def instances(self):
        # TODO: instances add implementation
        raise NotImplementedError("instances is not implemented yet.")

