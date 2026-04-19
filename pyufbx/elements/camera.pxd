# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_camera


cdef class Camera:
    cdef ufbx_camera *_camera

