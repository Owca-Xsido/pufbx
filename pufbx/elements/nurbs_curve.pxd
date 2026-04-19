# cython: language_level=3
from pufbx.pufbx cimport ufbx_nurbs_curve


cdef class NurbsCurve:
    cdef ufbx_nurbs_curve *_nurbs_curve

