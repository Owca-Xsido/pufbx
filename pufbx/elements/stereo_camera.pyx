# cython: language_level=3
from pufbx.pufbx cimport ufbx_stereo_camera

from ..props.prop cimport PropsWrapper
from .element cimport Element

include "../core/strings.pxi"


cdef class StereoCamera:
    """Represents a stereo camera in the FBX structure."""

    def __cinit__(self):
        self._stereo_camera = NULL

    def __repr__(self):
        if self._stereo_camera == NULL:
            return "<StereoCamera None>"
        return f"<StereoCamera name='{self.name}'>"

    @property
    def name(self):
        if self._stereo_camera == NULL:
            return "None"
        return to_py_string(self._stereo_camera.name)

    @property
    def element_id(self):
        return self._stereo_camera.element_id

    @property
    def typed_id(self):
        return self._stereo_camera.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._stereo_camera.props)

    # Complex properties - TODO
    @property
    def instances(self):
        # TODO: instances add implementation
        raise NotImplementedError("instances is not implemented yet.")

