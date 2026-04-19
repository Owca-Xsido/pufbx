# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_skin_deformer


cdef class SkinDeformer:
    cdef ufbx_skin_deformer *_skin_deformer

