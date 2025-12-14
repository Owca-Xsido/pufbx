from src.pyufbx cimport ufbx_bone


cdef class Bone:
    cdef ufbx_bone *_bone