# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_shader


cdef class Shader:
    cdef ufbx_shader *_shader

