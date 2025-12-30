# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_audio_clip


cdef class AudioClip:
    cdef ufbx_audio_clip *_audio_clip
    cdef object __weakref__  # Enable weak references

