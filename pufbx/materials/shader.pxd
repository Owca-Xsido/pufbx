# cython: language_level=3
from pufbx.pufbx cimport ufbx_shader


cdef class Shader:
    cdef ufbx_shader *_shader

