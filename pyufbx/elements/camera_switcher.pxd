# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_camera_switcher


cdef class CameraSwitcher:
    cdef ufbx_camera_switcher *_camera_switcher

