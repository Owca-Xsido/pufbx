# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_marker


cdef class Marker:
    cdef ufbx_marker *_marker

