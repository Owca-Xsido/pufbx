# props.pxd

cdef class Vec2Property:
    cdef public double x, y

cdef class Vec3Property:
    cdef public double x, y, z

cdef class Vec4Property:
    cdef public double x, y, z, w

cdef class QuatProperty:
    cdef public double x, y, z, w