from src.pyufbx cimport ufbx_prop


cdef class Prop:
    cdef ufbx_prop *_prop