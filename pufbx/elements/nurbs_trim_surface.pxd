# cython: language_level=3
from pufbx.pufbx cimport ufbx_nurbs_trim_surface


cdef class NurbsTrimSurface:
    cdef ufbx_nurbs_trim_surface *_nurbs_trim_surface

