# cython: language_level=3
from pufbx.pufbx cimport ufbx_metadata_object


cdef class MetadataObject:
    cdef ufbx_metadata_object *_metadata_object

