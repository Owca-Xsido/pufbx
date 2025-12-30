# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_metadata_object

from ..props.prop cimport PropsWrapper
from .element cimport Element

include "../core/strings.pxi"


cdef class MetadataObject:
    """Represents a metadata object in the FBX structure."""

    def __cinit__(self):
        self._metadata_object = NULL

    def __repr__(self):
        if self._metadata_object == NULL:
            return "<MetadataObject None>"
        return f"<MetadataObject name='{self.name}'>"

    @property
    def name(self):
        if self._metadata_object == NULL:
            return "None"
        return to_py_string(self._metadata_object.name)

    @property
    def element_id(self):
        return self._metadata_object.element_id

    @property
    def typed_id(self):
        return self._metadata_object.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._metadata_object.props)

    # Complex properties - TODO
    @property
    def metadata(self):
        # TODO: metadata add implementation
        raise NotImplementedError("metadata is not implemented yet.")

