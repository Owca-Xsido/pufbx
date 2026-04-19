# cython: language_level=3
from pufbx.pufbx cimport ufbx_material


cdef class Material:
    cdef ufbx_material *_material

