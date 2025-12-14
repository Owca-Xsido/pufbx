# elements/node.pxd
from pyufbx cimport ufbx_node


cdef class Node:
    cdef ufbx_node *_node
