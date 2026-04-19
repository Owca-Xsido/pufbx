""" FROM ufbx reference:
Single real value at a specified time, interpolation between two keyframes is determined by the interpolation field of the previous key. If interpolation == UFBX_INTERPOLATION_CUBIC the span is evaluated as a cubic bezier curve through the following points:

(prev->time, prev->value)
(prev->time + prev->right.dx, prev->value + prev->right.dy)
(next->time - next->left.dx, next->value - next->left.dy)
(next->time, next->value)"""
from ..enums import Interpolation
from ..generated.wrappers cimport wrap_keyframe


cdef class KeyframeList:
    """A list-like wrapper for ufbx_keyframe pointers."""

    @staticmethod
    cdef KeyframeList create(ufbx_keyframe *data, size_t count):
        cdef KeyframeList obj = KeyframeList.__new__(KeyframeList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_keyframe(&self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_keyframe(&self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_keyframe(&self._data[i])

    def __repr__(self):
        return f"<KeyframeList count={self._count}>"


cdef class Keyframe:
    """ Keyframe representation. """

    @property
    def time(self):
        """ Time of the keyframe. """
        return self._keyframe.time
    
    @property
    def value(self):
        """ Value of the keyframe. """
        return self._keyframe.value

    @property
    def interpolation(self):
        """ Interpolation type of the keyframe. """
        return Interpolation(<int>self._keyframe.interpolation)

    @property
    def left(self):
        """ Left tangent of the keyframe. """
        return (self._keyframe.left.dx, self._keyframe.left.dy)
    
    @property
    def right(self):
        """ Right tangent of the keyframe. """
        return (self._keyframe.right.dx, self._keyframe.right.dy)
    
