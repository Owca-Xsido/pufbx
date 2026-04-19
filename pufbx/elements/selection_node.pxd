# cython: language_level=3
from pufbx.pufbx cimport ufbx_selection_node


cdef class SelectionNode:
    cdef ufbx_selection_node *_selection_node

