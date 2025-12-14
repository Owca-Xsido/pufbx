import numpy as np


cdef class Vec2Property:
    """Wrapper for 3D vector properties with conversion methods."""
    cdef double x, y

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
    cdef double x, y, z

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

    # def __repr__(self):
    #     return f"Vec3({self.x}, {self.y}, {self.z})"

    def __iter__(self):
        """Allows unpacking: x, y, z = vec"""
        yield self.x
        yield self.y
        yield self.z


cdef class Vec4Property:
    """Wrapper for 4D vector properties with conversion methods."""
    cdef double x, y, z, w

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
    cdef double x, y, z, w

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


