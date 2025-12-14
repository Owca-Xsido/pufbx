
from pyufbx.pyufbx cimport *
include "../core/strings.pxi"


cdef class Mesh:
    cdef ufbx_mesh *_mesh
    cdef object __weakref__
    

