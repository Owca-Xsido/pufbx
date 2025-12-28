
from pyufbx.pyufbx cimport ufbx_mesh

from .element cimport Element

include "../core/strings.pxi"



cdef class Mesh(Element):
    # TODO: Implement Mesh class
    raise NotImplementedError("Mesh class is not yet implemented.")
    
    

        return wrap_element(&self._mesh.element)

