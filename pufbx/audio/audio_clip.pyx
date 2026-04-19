# cython: language_level=3

from ..props.prop cimport PropsWrapper

include "../core/strings.pxi"


cdef class AudioClip:
    """Represents an audio clip in the FBX structure."""

    def __repr__(self):
 
        return f"<AudioClip name='{self.name}'>"

    @property
    def name(self):

        return to_py_string(self._audio_clip.name)

    @property
    def element_id(self):
        return self._audio_clip.element_id

    @property
    def typed_id(self):
        return self._audio_clip.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._audio_clip.props)

    # Simple properties
    @property
    def filename(self):
        return to_py_string(self._audio_clip.filename)

    @property
    def absolute_filename(self):
        return to_py_string(self._audio_clip.absolute_filename)

    @property
    def relative_filename(self):
        return to_py_string(self._audio_clip.relative_filename)

    # Complex properties - TODO
    @property
    def raw_filename(self):
        # TODO: raw_filename add implementation
        raise NotImplementedError("raw_filename is not implemented yet.")

    @property
    def raw_absolute_filename(self):
        # TODO: raw_absolute_filename add implementation
        raise NotImplementedError("raw_absolute_filename is not implemented yet.")

    @property
    def raw_relative_filename(self):
        # TODO: raw_relative_filename add implementation
        raise NotImplementedError("raw_relative_filename is not implemented yet.")

    @property
    def content(self):
        # TODO: content add implementation
        raise NotImplementedError("content is not implemented yet.")

    @property
    def layer(self):
        # TODO: layer add implementation
        raise NotImplementedError("layer is not implemented yet.")

