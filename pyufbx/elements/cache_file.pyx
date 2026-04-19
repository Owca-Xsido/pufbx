# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_cache_file

from ..props.prop cimport PropsWrapper
from .element cimport Element

include "../core/strings.pxi"


cdef class CacheFile:
    """Represents a cache file in the FBX structure."""

    def __cinit__(self):
        self._cache_file = NULL

    def __repr__(self):
        if self._cache_file == NULL:
            return "<CacheFile None>"
        return f"<CacheFile name='{self.name}'>"

    @property
    def name(self):
        if self._cache_file == NULL:
            return "None"
        return to_py_string(self._cache_file.name)

    @property
    def element_id(self):
        return self._cache_file.element_id

    @property
    def typed_id(self):
        return self._cache_file.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._cache_file.props)

    # Simple properties
    @property
    def filename(self):
        return to_py_string(self._cache_file.filename)

    @property
    def absolute_filename(self):
        return to_py_string(self._cache_file.absolute_filename)

    @property
    def relative_filename(self):
        return to_py_string(self._cache_file.relative_filename)

    # Complex properties - TODO
    @property
    def content(self):
        # TODO: content add implementation
        raise NotImplementedError("content is not implemented yet.")

