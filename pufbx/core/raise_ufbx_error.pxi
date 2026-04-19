from cpython.bytes cimport PyBytes_FromStringAndSize

from pufbx.errors import UFBXError
from pufbx.pufbx cimport ufbx_error, ufbx_format_error


cdef void raise_ufbx_error(const ufbx_error *error) except *:
    cdef char buf[2048]
    cdef size_t n
    cdef int t
    cdef str msg
    cdef bytes info_b
    cdef str desc
    cdef str info_str

    n = ufbx_format_error(buf, sizeof(buf), error)
    if n > 0:
        msg = PyBytes_FromStringAndSize(buf, <Py_ssize_t>n).decode("utf-8", errors="replace")
    else:
        desc = to_py_string(error.description)
        msg = desc
        if error.info_length > 0:
            info_b = error.info[:error.info_length]
            info_str = info_b.decode("utf-8", errors="replace")
            if msg:
                msg = f"{msg}: {info_str}"
            else:
                msg = info_str
    if not msg:
        msg = "ufbx operation failed"
    t = <int>error.type
    raise UFBXError(msg, error_type=t)
