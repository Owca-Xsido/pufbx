# cython: language_level=3
from pufbx.pufbx cimport ufbx_line_curve


cdef class LineCurve:
    cdef ufbx_line_curve *_line_curve

