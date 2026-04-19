# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_stereo_camera


cdef class StereoCamera:
    cdef ufbx_stereo_camera *_stereo_camera

