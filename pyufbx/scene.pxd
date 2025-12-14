from pyufbx.pyufbx cimport ufbx_scene


cdef class Scene:
    cdef ufbx_scene *_scene
    cdef void _set_scene(self, ufbx_scene* scene) noexcept