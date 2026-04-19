from pufbx.pufbx cimport ufbx_keyframe

""" FROM ufbx reference:
Single real value at a specified time, interpolation between two keyframes is determined by the interpolation field of the previous key. If interpolation == UFBX_INTERPOLATION_CUBIC the span is evaluated as a cubic bezier curve through the following points:

(prev->time, prev->value)
(prev->time + prev->right.dx, prev->value + prev->right.dy)
(next->time - next->left.dx, next->value - next->left.dy)
(next->time, next->value)"""

cdef class Keyframe:
    cdef ufbx_keyframe *_keyframe
    cdef object __weakref__  # Enable weak references

cdef class KeyframeList:
    cdef ufbx_keyframe *_data
    cdef size_t _count
    @staticmethod
    cdef KeyframeList create(ufbx_keyframe *data, size_t count)
