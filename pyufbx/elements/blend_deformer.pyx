# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_blend_deformer

from ..props.prop cimport PropsWrapper
from .element cimport Element

include "../core/strings.pxi"


cdef class BlendDeformer:
    """Represents a blend deformer in the FBX structure."""

    def __cinit__(self):
        self._blend_deformer = NULL

    def __repr__(self):
        if self._blend_deformer == NULL:
            return "<BlendDeformer None>"
        return f"<BlendDeformer name='{self.name}'>"

    @property
    def name(self):
        if self._blend_deformer == NULL:
            return "None"
        return to_py_string(self._blend_deformer.name)

    @property
    def element_id(self):
        return self._blend_deformer.element_id

    @property
    def typed_id(self):
        return self._blend_deformer.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._blend_deformer.props)

    # Complex properties - TODO
    @property
    def channels(self):
        # TODO: channels add implementation
        raise NotImplementedError("channels is not implemented yet.")

