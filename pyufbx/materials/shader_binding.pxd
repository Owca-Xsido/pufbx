# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_shader_binding


cdef class ShaderBinding:
    cdef ufbx_shader_binding *_shader_binding

