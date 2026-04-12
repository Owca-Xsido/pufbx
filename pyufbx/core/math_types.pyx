import numpy as np

cimport numpy as cnp
from libc.string cimport memcpy

from ..pyufbx cimport ufbx_baked_quat, ufbx_baked_quat_list, ufbx_baked_vec3, ufbx_baked_vec3_list

# Define numpy dtype
quat_dtype = np.dtype([
    ('x', np.float64),
    ('y', np.float64),
    ('z', np.float64),
    ('w', np.float64)
], align=True)

baked_quat_dtype = np.dtype([
    ('time', np.float64),
    ('value', quat_dtype),
    ('flags', np.uint32)
], align=True)

vec3_dtype = np.dtype([
    ('x', np.float64),
    ('y', np.float64),
    ('z', np.float64)
], align=True)

baked_vec3_dtype = np.dtype([
    ('time', np.float64),
    ('value', vec3_dtype),
    ('flags', np.uint32)
], align=True)



cdef class Vec2Property:
    """Wrapper for 3D vector properties with conversion methods."""


    def __init__(self, double x, double y):
        self.x = x
        self.y = y

    def as_list(self):
        """Returns as plain Python list."""
        return [self.x, self.y]

    def as_tuple(self):
        """Returns as tuple."""
        return (self.x, self.y)

    def as_array(self):
        """Returns as numpy array."""
        return np.array([self.x, self.y], dtype=np.float64)

    def __repr__(self):
        return f"Vec2({self.x}, {self.y})"

    def __iter__(self):
        """Allows unpacking: x, y = vec"""
        yield self.x
        yield self.y


cdef class Vec3Property:
    """Wrapper for 3D vector properties with conversion methods."""


    def __init__(self, double x, double y, double z):
        self.x = x
        self.y = y
        self.z = z

    def as_list(self):
        """Returns as plain Python list."""
        return [self.x, self.y, self.z]

    def as_tuple(self):
        """Returns as tuple."""
        return (self.x, self.y, self.z)

    def as_array(self):
        """Returns as numpy array."""
        return np.array([self.x, self.y, self.z], dtype=np.float64)

    def __repr__(self):
        return f"Vec3({self.x}, {self.y}, {self.z})"

    def __iter__(self):
        """Allows unpacking: x, y, z = vec"""
        yield self.x
        yield self.y
        yield self.z


cdef class Vec4Property:
    """Wrapper for 4D vector properties with conversion methods."""


    def __init__(self, double x, double y, double z, double w):
        self.x = x
        self.y = y
        self.z = z
        self.w = w

    def as_list(self):
        """Returns as plain Python list."""
        return [self.x, self.y, self.z, self.w]

    def as_tuple(self):
        """Returns as tuple."""
        return (self.x, self.y, self.z, self.w)

    def as_array(self):
        """Returns as numpy array."""
        return np.array([self.x, self.y, self.z, self.w], dtype=np.float64)

    def __repr__(self):
        return f"Vec4({self.x}, {self.y}, {self.z}, {self.w})"

    def __iter__(self):
        """Allows unpacking: x, y, z, w = vec"""
        yield self.x
        yield self.y
        yield self.z
        yield self.w


cdef class QuatProperty:
    """Wrapper for quaternion with conversion methods."""
    def __init__(self, double x, double y, double z, double w):
        self.x = x
        self.y = y
        self.z = z
        self.w = w

    def as_list(self):
        """Returns as plain Python list [x, y, z, w]."""
        return [self.x, self.y, self.z, self.w]

    def as_tuple(self):
        """Returns as tuple (x, y, z, w)."""
        return (self.x, self.y, self.z, self.w)

    def as_array(self):
        """Returns as numpy array."""
        return np.array([self.x, self.y, self.z, self.w], dtype=np.float64)

    def __repr__(self):
        return f"Quat({self.x}, {self.y}, {self.z}, {self.w})"

    def __iter__(self):
        yield self.x
        yield self.y
        yield self.z
        yield self.w


cpdef cnp.ndarray fast_baked_quat_copy(size_t list_ptr):
    cdef ufbx_baked_quat_list* quat_list = <ufbx_baked_quat_list*>list_ptr
    cdef size_t count = quat_list.count
    if count == 0:
        return np.empty(0, dtype=baked_quat_dtype)
    cdef cnp.ndarray result = np.empty(count, dtype=baked_quat_dtype)
    memcpy(<void*>result.data, <void*>quat_list.data, count * sizeof(ufbx_baked_quat))
    return result


cpdef cnp.ndarray fast_baked_vec3_copy(size_t list_ptr):
    cdef ufbx_baked_vec3_list* vec3_list = <ufbx_baked_vec3_list*>list_ptr
    cdef size_t count = vec3_list.count
    if count == 0:
        return np.empty(0, dtype=baked_vec3_dtype)
    cdef cnp.ndarray result = np.empty(count, dtype=baked_vec3_dtype)
    memcpy(<void*>result.data, <void*>vec3_list.data, count * sizeof(ufbx_baked_vec3))
    return result
