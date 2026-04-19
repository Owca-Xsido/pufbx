# cython: language_level=3
from pufbx.pufbx cimport ufbx_camera_switcher


cdef class CameraSwitcher:
    cdef ufbx_camera_switcher *_camera_switcher

