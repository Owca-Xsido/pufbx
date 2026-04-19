# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_lod_group

from ..props.prop cimport PropsWrapper
from .element cimport Element

include "../core/strings.pxi"


cdef class LodGroup:
    """Represents an LOD group in the FBX structure."""

    def __cinit__(self):
        self._lod_group = NULL

    def __repr__(self):
        if self._lod_group == NULL:
            return "<LodGroup None>"
        return f"<LodGroup name='{self.name}'>"

    @property
    def name(self):
        if self._lod_group == NULL:
            return "None"
        return to_py_string(self._lod_group.name)

    @property
    def element_id(self):
        return self._lod_group.element_id

    @property
    def typed_id(self):
        return self._lod_group.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._lod_group.props)

    # Complex properties - TODO
    @property
    def instances(self):
        # TODO: instances add implementation
        raise NotImplementedError("instances is not implemented yet.")

    @property
    def levels(self):
        # TODO: levels add implementation
        raise NotImplementedError("levels is not implemented yet.")

