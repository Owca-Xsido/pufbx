# cython: language_level=3
from pufbx.pufbx cimport ufbx_blend_shape

from ..props.prop cimport PropsWrapper
from .element cimport Element

include "../core/strings.pxi"


cdef class BlendShape:
    """Represents a blend shape in the FBX structure."""

    def __cinit__(self):
        self._blend_shape = NULL

    def __repr__(self):
        if self._blend_shape == NULL:
            return "<BlendShape None>"
        return f"<BlendShape name='{self.name}'>"

    @property
    def name(self):
        if self._blend_shape == NULL:
            return "None"
        return to_py_string(self._blend_shape.name)

    @property
    def element_id(self):
        return self._blend_shape.element_id

    @property
    def typed_id(self):
        return self._blend_shape.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._blend_shape.props)

    # Complex properties - TODO
    @property
    def offsets(self):
        # TODO: offsets add implementation
        raise NotImplementedError("offsets is not implemented yet.")

