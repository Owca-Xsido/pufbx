# cython: language_level=3
from pufbx.pufbx cimport ufbx_constraint


cdef class Constraint:
    cdef ufbx_constraint *_constraint

