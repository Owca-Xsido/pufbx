# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_character

from ..props.prop cimport PropsWrapper
from .element cimport Element

include "../core/strings.pxi"


cdef class Character:
    """Represents a character in the FBX structure."""

    def __cinit__(self):
        self._character = NULL

    def __repr__(self):
        if self._character == NULL:
            return "<Character None>"
        return f"<Character name='{self.name}'>"

    @property
    def name(self):
        if self._character == NULL:
            return "None"
        return to_py_string(self._character.name)

    @property
    def element_id(self):
        return self._character.element_id

    @property
    def typed_id(self):
        return self._character.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._character.props)

    # Complex properties - TODO
    @property
    def limbs(self):
        # TODO: limbs add implementation
        raise NotImplementedError("limbs is not implemented yet.")

