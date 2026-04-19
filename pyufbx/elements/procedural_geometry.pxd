# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_procedural_geometry


cdef class ProceduralGeometry:
    cdef ufbx_procedural_geometry *_procedural_geometry

