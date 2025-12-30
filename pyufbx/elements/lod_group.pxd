# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_lod_group


cdef class LodGroup:
    cdef ufbx_lod_group *_lod_group

