# cython: language_level=3
from pufbx.pufbx cimport ufbx_marker


cdef class Marker:
    cdef ufbx_marker *_marker

