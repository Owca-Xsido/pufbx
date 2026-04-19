from pufbx.pufbx cimport ufbx_element


cdef class Element:
    cdef ufbx_element *_element
    cdef object __weakref__
