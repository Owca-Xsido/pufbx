# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_nurbs_curve


cdef class NurbsCurve:
    cdef ufbx_nurbs_curve *_nurbs_curve

