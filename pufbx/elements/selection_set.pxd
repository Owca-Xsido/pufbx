# cython: language_level=3
from pufbx.pufbx cimport ufbx_selection_set


cdef class SelectionSet:
    cdef ufbx_selection_set *_selection_set

