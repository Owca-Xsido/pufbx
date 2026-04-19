# cython: language_level=3
from pufbx.pufbx cimport ufbx_display_layer


cdef class DisplayLayer:
    cdef ufbx_display_layer *_display_layer

