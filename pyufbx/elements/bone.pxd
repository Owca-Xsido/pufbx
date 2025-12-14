from pyufbx.pyufbx cimport ufbx_bone, ufbx_node


cdef class Bone:
    cdef ufbx_bone *_bone
    cdef object __weakref__  # Enable weak references
