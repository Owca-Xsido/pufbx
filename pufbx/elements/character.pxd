# cython: language_level=3
from pufbx.pufbx cimport ufbx_character


cdef class Character:
    cdef ufbx_character *_character

