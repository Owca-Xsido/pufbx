# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_constraint


cdef class Constraint:
    cdef ufbx_constraint *_constraint

