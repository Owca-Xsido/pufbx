# cython: language_level=3
from pufbx.pufbx cimport ufbx_camera_switcher

from ..props.prop cimport PropsWrapper
from .element cimport Element

include "../core/strings.pxi"


cdef class CameraSwitcher:
    """Represents a camera switcher in the FBX structure."""

    def __cinit__(self):
        self._camera_switcher = NULL

    def __repr__(self):
        if self._camera_switcher == NULL:
            return "<CameraSwitcher None>"
        return f"<CameraSwitcher name='{self.name}'>"

    @property
    def name(self):
        if self._camera_switcher == NULL:
            return "None"
        return to_py_string(self._camera_switcher.name)

    @property
    def element_id(self):
        return self._camera_switcher.element_id

    @property
    def typed_id(self):
        return self._camera_switcher.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._camera_switcher.props)

    # Complex properties - TODO
    @property
    def instances(self):
        # TODO: instances add implementation
        raise NotImplementedError("instances is not implemented yet.")

