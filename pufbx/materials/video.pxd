# cython: language_level=3
from pufbx.pufbx cimport ufbx_video


cdef class Video:
    cdef ufbx_video *_video

