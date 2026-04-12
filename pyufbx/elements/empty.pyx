# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_empty

from ..generated.lists cimport NodeList
from ..props.prop cimport PropsWrapper
from .element cimport Element

include "../core/strings.pxi"


cdef class Empty:
    """Represents an empty/null object in the FBX structure."""

    def __cinit__(self):
        self._empty = NULL

    def __repr__(self):
        if self._empty == NULL:
            return "<Empty None>"
        return f"<Empty name='{self.name}'>"

    @property
    def name(self):
        if self._empty == NULL:
            return "None"
        return to_py_string(self._empty.name)

    @property
    def element_id(self):
        return self._empty.element_id

    @property
    def typed_id(self):
        return self._empty.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._empty.props)

    @property
    def instances(self):
        return NodeList.create(self._empty.instances.data, self._empty.instances.count)

