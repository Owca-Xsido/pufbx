# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_anim_stack

from ..generated.wrappers cimport wrap_anim
from ..props.prop cimport PropsWrapper

include "../core/strings.pxi"


cdef class AnimStack:
    """Represents an animation stack in the FBX structure."""

    def __cinit__(self):
        self._anim_stack = NULL

    def __repr__(self):
        if self._anim_stack == NULL:
            return "<AnimStack None>"
        return f"<AnimStack name='{self.name}'>"

    @property
    def name(self):
        if self._anim_stack == NULL:
            return "None"
        return to_py_string(self._anim_stack.name)

    @property
    def element_id(self):
        return self._anim_stack.element_id

    @property
    def typed_id(self):
        return self._anim_stack.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._anim_stack.props)

    # Complex properties - TODO
    @property
    def layers(self):
        # TODO: layers add implementation
        raise NotImplementedError("layers is not implemented yet.")

    @property
    def anim(self):
        return wrap_anim(self._anim_stack.anim)
