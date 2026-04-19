# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_character


cdef class Character:
    cdef ufbx_character *_character

