# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_empty


cdef class Empty:
    cdef ufbx_empty *_empty

