# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_bone, ufbx_element, ufbx_node


cdef class ElementList:
    cdef ufbx_element **_data
    cdef size_t _count
    @staticmethod
    cdef ElementList create(ufbx_element **data, size_t count)

cdef class NodeList:
    cdef ufbx_node **_data
    cdef size_t _count
    @staticmethod
    cdef NodeList create(ufbx_node **data, size_t count)

cdef class BoneList:
    cdef ufbx_bone **_data
    cdef size_t _count
    @staticmethod
    cdef BoneList create(ufbx_bone **data, size_t count)

