# cython: language_level=3
from pufbx.pufbx cimport ufbx_anim_stack


cdef class AnimStack:
    cdef ufbx_anim_stack *_anim_stack
    cdef object __weakref__

