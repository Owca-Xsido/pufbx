# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_material


cdef class Material:
    cdef ufbx_material *_material

