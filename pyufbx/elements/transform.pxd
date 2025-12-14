from pyufbx cimport ufbx_transform


cdef class Transform:
    """Wrapper for ufbx_transform with conversion methods."""
    cdef ufbx_transform *_transform