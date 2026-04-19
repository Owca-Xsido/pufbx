# cython: language_level=3
from pufbx.pufbx cimport ufbx_light


cdef class Light:
    cdef ufbx_light *_light

