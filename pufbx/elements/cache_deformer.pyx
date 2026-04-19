# cython: language_level=3
from pufbx.pufbx cimport ufbx_cache_deformer

from ..props.prop cimport PropsWrapper
from .element cimport Element

include "../core/strings.pxi"


cdef class CacheDeformer:
    """Represents a cache deformer in the FBX structure."""

    def __cinit__(self):
        self._cache_deformer = NULL

    def __repr__(self):
        if self._cache_deformer == NULL:
            return "<CacheDeformer None>"
        return f"<CacheDeformer name='{self.name}'>"

    @property
    def name(self):
        if self._cache_deformer == NULL:
            return "None"
        return to_py_string(self._cache_deformer.name)

    @property
    def element_id(self):
        return self._cache_deformer.element_id

    @property
    def typed_id(self):
        return self._cache_deformer.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._cache_deformer.props)

    # Complex properties - TODO
    @property
    def cache_file(self):
        # TODO: cache_file add implementation
        raise NotImplementedError("cache_file is not implemented yet.")

