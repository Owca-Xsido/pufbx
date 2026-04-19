# cython: language_level=3
from pufbx.pufbx cimport ufbx_pose

from ..props.prop cimport PropsWrapper
from .element cimport Element

include "../core/strings.pxi"


cdef class Pose:
    """Represents a pose in the FBX structure."""

    def __cinit__(self):
        self._pose = NULL

    def __repr__(self):
        if self._pose == NULL:
            return "<Pose None>"
        return f"<Pose name='{self.name}'>"

    @property
    def name(self):
        if self._pose == NULL:
            return "None"
        return to_py_string(self._pose.name)

    @property
    def element_id(self):
        return self._pose.element_id

    @property
    def typed_id(self):
        return self._pose.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._pose.props)

    # Complex properties - TODO
    @property
    def bones(self):
        # TODO: bones add implementation
        raise NotImplementedError("bones is not implemented yet.")

