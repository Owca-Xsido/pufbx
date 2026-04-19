# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_audio_layer


cdef class AudioLayer:
    cdef ufbx_audio_layer *_audio_layer

