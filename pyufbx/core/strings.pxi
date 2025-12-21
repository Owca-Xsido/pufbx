from cpython.bytes cimport PyBytes_FromStringAndSize
from pyufbx.pyufbx cimport ufbx_string, ufbx_blob
cdef str to_py_string(ufbx_string s):
    """
    Converts a ufbx_string (pointer + length) to a Python string.
    Handles NULL pointers and zero-length strings safely.
    """
    if s.data == NULL or s.length == 0:
        return ""
    # Create a Python bytes object from char* + length, then decode to str
    return PyBytes_FromStringAndSize(s.data, s.length).decode('utf-8')


cdef inline object blob_to_bytes(ufbx_blob blob):
    """Convert a ufbx_blob to Python bytes."""
    if blob.data == NULL or blob.size == 0:
        return b""
    return PyBytes_FromStringAndSize(<const char*>blob.data, blob.size)
