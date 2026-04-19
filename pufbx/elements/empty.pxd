# cython: language_level=3
from pufbx.pufbx cimport ufbx_empty


cdef class Empty:
    cdef ufbx_empty *_empty

