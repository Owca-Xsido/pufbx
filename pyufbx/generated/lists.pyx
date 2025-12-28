# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_element, ufbx_node, ufbx_bone, ufbx_anim, ufbx_anim_value, ufbx_anim_curve
from .wrappers cimport wrap_element, wrap_node, wrap_bone, wrap_anim, wrap_anim_value, wrap_anim_curve

cdef class ElementList:
    """A list-like wrapper for ufbx_element pointers."""

    @staticmethod
    cdef ElementList create(ufbx_element **data, size_t count):
        cdef ElementList obj = ElementList.__new__(ElementList)
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
                result.append(wrap_element(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_element(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_element(self._data[i])

    def __repr__(self):
        return f"<ElementList count={self._count}>"


cdef class NodeList:
    """A list-like wrapper for ufbx_node pointers."""

    @staticmethod
    cdef NodeList create(ufbx_node **data, size_t count):
        cdef NodeList obj = NodeList.__new__(NodeList)
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
                result.append(wrap_node(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_node(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_node(self._data[i])

    def __repr__(self):
        return f"<NodeList count={self._count}>"


cdef class BoneList:
    """A list-like wrapper for ufbx_bone pointers."""

    @staticmethod
    cdef BoneList create(ufbx_bone **data, size_t count):
        cdef BoneList obj = BoneList.__new__(BoneList)
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
                result.append(wrap_bone(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_bone(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_bone(self._data[i])

    def __repr__(self):
        return f"<BoneList count={self._count}>"


cdef class AnimList:
    """A list-like wrapper for ufbx_anim pointers."""

    @staticmethod
    cdef AnimList create(ufbx_anim **data, size_t count):
        cdef AnimList obj = AnimList.__new__(AnimList)
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
                result.append(wrap_anim(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_anim(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_anim(self._data[i])

    def __repr__(self):
        return f"<AnimList count={self._count}>"


cdef class AnimValueList:
    """A list-like wrapper for ufbx_anim_value pointers."""

    @staticmethod
    cdef AnimValueList create(ufbx_anim_value **data, size_t count):
        cdef AnimValueList obj = AnimValueList.__new__(AnimValueList)
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
                result.append(wrap_anim_value(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_anim_value(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_anim_value(self._data[i])

    def __repr__(self):
        return f"<AnimValueList count={self._count}>"


cdef class AnimCurveList:
    """A list-like wrapper for ufbx_anim_curve pointers."""

    @staticmethod
    cdef AnimCurveList create(ufbx_anim_curve **data, size_t count):
        cdef AnimCurveList obj = AnimCurveList.__new__(AnimCurveList)
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
                result.append(wrap_anim_curve(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_anim_curve(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_anim_curve(self._data[i])

    def __repr__(self):
        return f"<AnimCurveList count={self._count}>"


