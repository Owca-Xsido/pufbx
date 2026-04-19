# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_video

from ..props.prop cimport PropsWrapper

include "../core/strings.pxi"


cdef class Video:
    """Represents a video in the FBX structure."""

    def __cinit__(self):
        self._video = NULL

    def __repr__(self):
        if self._video == NULL:
            return "<Video None>"
        return f"<Video name='{self.name}'>"

    @property
    def name(self):
        if self._video == NULL:
            return "None"
        return to_py_string(self._video.name)

    @property
    def element_id(self):
        return self._video.element_id

    @property
    def typed_id(self):
        return self._video.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._video.props)

    # Simple properties
    @property
    def filename(self):
        return to_py_string(self._video.filename)

    @property
    def absolute_filename(self):
        return to_py_string(self._video.absolute_filename)

    @property
    def relative_filename(self):
        return to_py_string(self._video.relative_filename)

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

