# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_texture

from ..props.prop cimport PropsWrapper

include "../core/strings.pxi"


cdef class Texture:
    """Represents a texture in the FBX structure."""

    def __cinit__(self):
        self._texture = NULL

    def __repr__(self):
        if self._texture == NULL:
            return "<Texture None>"
        return f"<Texture name='{self.name}'>"

    @property
    def name(self):
        if self._texture == NULL:
            return "None"
        return to_py_string(self._texture.name)

    @property
    def element_id(self):
        return self._texture.element_id

    @property
    def typed_id(self):
        return self._texture.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._texture.props)

    # Simple properties
    @property
    def texture_type(self):
        # TODO: Create TextureType enum if needed
        return <int> self._texture.type

    @property
    def filename(self):
        return to_py_string(self._texture.filename)

    @property
    def absolute_filename(self):
        return to_py_string(self._texture.absolute_filename)

    @property
    def relative_filename(self):
        return to_py_string(self._texture.relative_filename)

    @property
    def file_index(self):
        return self._texture.file_index

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
    def video(self):
        # TODO: video add implementation
        raise NotImplementedError("video is not implemented yet.")

