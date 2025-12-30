# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_nurbs_surface


cdef class NurbsSurface:
    cdef ufbx_nurbs_surface *_nurbs_surface

