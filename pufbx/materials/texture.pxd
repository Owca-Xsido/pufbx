# cython: language_level=3
from pufbx.pufbx cimport ufbx_texture


cdef class Texture:
    cdef ufbx_texture *_texture

