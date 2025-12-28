from pyufbx cimport ufbx_mesh

from .element cimport Element


cdef class Mesh(Element):
    cdef ufbx_mesh *_mesh
    cdef object __weakref__
    

