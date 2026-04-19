from pufbx.pufbx cimport ufbx_prop, ufbx_props


cdef class PropsWrapper:
    cdef ufbx_props *_props
    cdef object __weakref__
    @staticmethod
    cdef PropsWrapper create(ufbx_props *props) 
cdef class Prop:
    cdef ufbx_prop *_prop
    cdef object __weakref__