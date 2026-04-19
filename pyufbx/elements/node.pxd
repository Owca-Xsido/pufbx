# elements/node.pxd
from pyufbx.core.transform cimport Transform
from pyufbx.pyufbx cimport ufbx_baked_node, ufbx_node


cdef class Node:
    cdef ufbx_node *_node
    cdef object __weakref__  # Enable weak references
    cdef Transform _transform_cache
    cdef get_property_by_enum(self, enum)

cdef class BakedNode:
    cdef ufbx_baked_node *_baked_node
    cdef object __weakref__  # Enable weak references
