# cython: language_level=3
from pufbx.pufbx cimport ufbx_blend_channel


cdef class BlendChannel:
    cdef ufbx_blend_channel *_blend_channel

