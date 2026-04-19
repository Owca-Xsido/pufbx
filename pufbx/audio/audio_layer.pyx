# cython: language_level=3
from pufbx.pufbx cimport ufbx_audio_layer

from ..props.prop cimport PropsWrapper

include "../core/strings.pxi"


cdef class AudioLayer:
    """Represents an audio layer in the FBX structure."""

    def __cinit__(self):
        self._audio_layer = NULL

    def __repr__(self):
        if self._audio_layer == NULL:
            return "<AudioLayer None>"
        return f"<AudioLayer name='{self.name}'>"

    @property
    def name(self):
        if self._audio_layer == NULL:
            return "None"
        return to_py_string(self._audio_layer.name)

    @property
    def element_id(self):
        return self._audio_layer.element_id

    @property
    def typed_id(self):
        return self._audio_layer.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._audio_layer.props)

    # Complex properties - TODO
    @property
    def clips(self):
        # TODO: clips add implementation
        raise NotImplementedError("clips is not implemented yet.")

