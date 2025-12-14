from pyufbx cimport ufbx_mesh


cdef class Mesh:
    cdef ufbx_mesh *_mesh
    

