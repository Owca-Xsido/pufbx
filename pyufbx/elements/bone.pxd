from pyufbx.pyufbx cimport ufbx_bone


cdef class Bone:
    cdef ufbx_bone *_bone