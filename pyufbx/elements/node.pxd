# elements/node.pxd
from pyufbx.core.transform cimport Transform
from pyufbx.pyufbx cimport ufbx_node

from .element cimport Element


cdef class Node(Element):
    cdef ufbx_node *_node
    cdef object __weakref__  # Enable weak references
    cdef Transform _transform_cache
    cdef get_property_by_enum(self, enum)