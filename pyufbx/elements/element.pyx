
from pyufbx.pyufbx cimport *
from pyufbx.enums.element_types import ElementType

include "../core/strings.pxi"


cdef class Element:
    """Base class for all elements in the FBX structure."""
    
    def __repr__(self):
        return f"<Name='{self.name}' id={self.element_id} type={self.element.type.name}>"

    def __str__(self):
        return self.name

    @property
    def name(self):
        if self._element == NULL:
            return "None"
        return to_py_string(self._element.name)

    @property
    def element_id(self):
        return self._element.element_id

    @property
    def typed_id(self):
        return self._element.typed_id
    
    @property
    def element_type(self):
        return ElementType(<int>self._element.type)

    @property
    def instance_count(self):
        return self._element.instances.count
