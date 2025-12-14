from src.pyufbx cimport ufbx_scene


cdef class Scene:
    cdef ufbx_scene *_scene