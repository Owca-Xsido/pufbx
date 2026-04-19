# cython: language_level=3
from pufbx.pufbx cimport ufbx_nurbs_surface


cdef class NurbsSurface:
    cdef ufbx_nurbs_surface *_nurbs_surface

