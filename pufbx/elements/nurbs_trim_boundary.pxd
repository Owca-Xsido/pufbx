# cython: language_level=3
from pufbx.pufbx cimport ufbx_nurbs_trim_boundary


cdef class NurbsTrimBoundary:
    cdef ufbx_nurbs_trim_boundary *_nurbs_trim_boundary

