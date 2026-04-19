
from .math_types cimport QuatProperty, Vec3Property


cdef class Transform:
    """Wrapper for ufbx_transform with conversion methods."""
    
    @property
    def translation(self):
        return Vec3Property(
            self._transform.translation.x,
            self._transform.translation.y,
            self._transform.translation.z
        )

    @property
    def rotation(self):
        return QuatProperty(
            self._transform.rotation.x,
            self._transform.rotation.y,
            self._transform.rotation.z,
            self._transform.rotation.w
        )

    @property
    def scale(self):
        return Vec3Property(
            self._transform.scale.x,
            self._transform.scale.y,
            self._transform.scale.z
        )