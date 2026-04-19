# cython: language_level=3
from pufbx.pufbx cimport ufbx_material

from ..props.prop cimport PropsWrapper

include "../core/strings.pxi"


cdef class Material:
    """Represents a material in the FBX structure."""

    def __cinit__(self):
        self._material = NULL

    def __repr__(self):
        if self._material == NULL:
            return "<Material None>"
        return f"<Material name='{self.name}'>"

    @property
    def name(self):
        if self._material == NULL:
            return "None"
        return to_py_string(self._material.name)

    @property
    def element_id(self):
        return self._material.element_id

    @property
    def typed_id(self):
        return self._material.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._material.props)

    # Simple properties
    @property
    def shader_type(self):
        # TODO: Create ShaderType enum if needed
        return <int> self._material.shader_type

    @property
    def shading_model_name(self):
        return to_py_string(self._material.shading_model_name)

    @property
    def shader_prop_prefix(self):
        return to_py_string(self._material.shader_prop_prefix)

    # Complex properties - TODO
    @property
    def fbx(self):
        # TODO: fbx add implementation
        raise NotImplementedError("fbx is not implemented yet.")

    @property
    def pbr(self):
        # TODO: pbr add implementation
        raise NotImplementedError("pbr is not implemented yet.")

    @property
    def features(self):
        # TODO: features add implementation
        raise NotImplementedError("features is not implemented yet.")

    @property
    def shader(self):
        # TODO: shader add implementation
        raise NotImplementedError("shader is not implemented yet.")

    @property
    def textures(self):
        # TODO: textures add implementation
        raise NotImplementedError("textures is not implemented yet.")

