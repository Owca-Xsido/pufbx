# cython: language_level=3
from pufbx.pufbx cimport ufbx_shader_binding

from ..props.prop cimport PropsWrapper

include "../core/strings.pxi"


cdef class ShaderBinding:
    """Represents a shader binding in the FBX structure."""

    def __cinit__(self):
        self._shader_binding = NULL

    def __repr__(self):
        if self._shader_binding == NULL:
            return "<ShaderBinding None>"
        return f"<ShaderBinding name='{self.name}'>"

    @property
    def name(self):
        if self._shader_binding == NULL:
            return "None"
        return to_py_string(self._shader_binding.name)

    @property
    def element_id(self):
        return self._shader_binding.element_id

    @property
    def typed_id(self):
        return self._shader_binding.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._shader_binding.props)

    # Complex properties - TODO
    @property
    def material(self):
        # TODO: material add implementation
        raise NotImplementedError("material is not implemented yet.")

    @property
    def shader(self):
        # TODO: shader add implementation
        raise NotImplementedError("shader is not implemented yet.")

