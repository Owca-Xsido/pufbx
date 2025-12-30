# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_texture


cdef class Texture:
    cdef ufbx_texture *_texture

