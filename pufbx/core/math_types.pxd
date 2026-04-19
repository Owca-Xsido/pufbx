# props.pxd
cimport numpy as cnp


cdef class Vec2Property:
    cdef public double x, y

cdef class Vec3Property:
    cdef public double x, y, z

cdef class Vec4Property:
    cdef public double x, y, z, w

cdef class QuatProperty:
    cdef public double x, y, z, w

cpdef cnp.ndarray fast_baked_quat_copy(size_t list_ptr)
cpdef cnp.ndarray fast_baked_vec3_copy(size_t list_ptr)
