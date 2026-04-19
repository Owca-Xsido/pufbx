# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_selection_node


cdef class SelectionNode:
    cdef ufbx_selection_node *_selection_node

