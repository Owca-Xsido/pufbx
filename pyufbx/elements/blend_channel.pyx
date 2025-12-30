# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_blend_channel

from ..props.prop cimport PropsWrapper
from .element cimport Element

include "../core/strings.pxi"


cdef class BlendChannel:
    """Represents a blend channel in the FBX structure."""

    def __cinit__(self):
        self._blend_channel = NULL

    def __repr__(self):
        if self._blend_channel == NULL:
            return "<BlendChannel None>"
        return f"<BlendChannel name='{self.name}'>"

    @property
    def name(self):
        if self._blend_channel == NULL:
            return "None"
        return to_py_string(self._blend_channel.name)

    @property
    def element_id(self):
        return self._blend_channel.element_id

    @property
    def typed_id(self):
        return self._blend_channel.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._blend_channel.props)

    # Simple properties
    @property
    def weight(self):
        return self._blend_channel.weight

    # Complex properties - TODO
    @property
    def shapes(self):
        # TODO: shapes add implementation
        raise NotImplementedError("shapes is not implemented yet.")

