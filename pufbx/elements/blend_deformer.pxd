# cython: language_level=3
from pufbx.pufbx cimport ufbx_blend_deformer


cdef class BlendDeformer:
    cdef ufbx_blend_deformer *_blend_deformer

