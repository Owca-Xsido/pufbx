# cython: language_level=3
from pufbx.pufbx cimport ufbx_texture_file

include "../core/strings.pxi"


cdef class TextureFile:
    """Represents a texture file in the FBX structure (not an Element)."""

    def __cinit__(self):
        self._texture_file = NULL

    def __repr__(self):
        if self._texture_file == NULL:
            return "<TextureFile None>"
        return f"<TextureFile filename='{self.filename}'>"

    # Simple properties
    @property
    def filename(self):
        if self._texture_file == NULL:
            return "None"
        return to_py_string(self._texture_file.filename)

    @property
    def absolute_filename(self):
        if self._texture_file == NULL:
            return "None"
        return to_py_string(self._texture_file.absolute_filename)

    @property
    def relative_filename(self):
        if self._texture_file == NULL:
            return "None"
        return to_py_string(self._texture_file.relative_filename)


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

