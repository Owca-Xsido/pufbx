# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_video


cdef class Video:
    cdef ufbx_video *_video

