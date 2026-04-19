# cython: language_level=3
from pufbx.pufbx cimport ufbx_cache_file


cdef class CacheFile:
    cdef ufbx_cache_file *_cache_file

