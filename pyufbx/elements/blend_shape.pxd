# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_blend_shape


cdef class BlendShape:
    cdef ufbx_blend_shape *_blend_shape

