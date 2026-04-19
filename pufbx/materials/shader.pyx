# cython: language_level=3
from pufbx.pufbx cimport ufbx_shader

from ..props.prop cimport PropsWrapper

include "../core/strings.pxi"


cdef class Shader:
    """Represents a shader in the FBX structure."""

    def __cinit__(self):
        self._shader = NULL

    def __repr__(self):
        if self._shader == NULL:
            return "<Shader None>"
        return f"<Shader name='{self.name}'>"

    @property
    def name(self):
        if self._shader == NULL:
            return "None"
        return to_py_string(self._shader.name)

    @property
    def element_id(self):
        return self._shader.element_id

    @property
    def typed_id(self):
        return self._shader.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._shader.props)

    # Complex properties - TODO
    @property
    def bindings(self):
        # TODO: bindings add implementation
        raise NotImplementedError("bindings is not implemented yet.")

