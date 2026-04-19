# cython: language_level=3
from pufbx.pufbx cimport ufbx_texture_file


cdef class TextureFile:
    cdef ufbx_texture_file *_texture_file

