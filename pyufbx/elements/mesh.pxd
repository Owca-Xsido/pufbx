# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_mesh


cdef class Mesh:
    cdef ufbx_mesh *_mesh
    cdef object __weakref__
    

