# cython: language_level=3
from pufbx.pufbx cimport ufbx_blend_shape


cdef class BlendShape:
    cdef ufbx_blend_shape *_blend_shape

