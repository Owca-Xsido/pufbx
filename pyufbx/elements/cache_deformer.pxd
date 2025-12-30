# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_cache_deformer


cdef class CacheDeformer:
    cdef ufbx_cache_deformer *_cache_deformer

