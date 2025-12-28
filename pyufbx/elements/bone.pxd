from pyufbx.pyufbx cimport ufbx_bone, ufbx_node

from .element cimport Element


cdef class Bone(Element):
    cdef ufbx_bone *_bone
    cdef object __weakref__  # Enable weak references
