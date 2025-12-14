
from pyufbx.pyufbx cimport *
include "../core/strings.pxi"
from pyufbx.enums.enums import InheritMode, RotationOrder, PropType
from pyufbx.enums.element_type import ElementType


cdef class Element:
    def __repr__(self):
        return f"<Name='{self.name}' id={self.id} type={self.element.type.name}>"

    def __str__(self):
        return self.name

    @property
    def name(self):
        if self._element == NULL:
            return ""
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
