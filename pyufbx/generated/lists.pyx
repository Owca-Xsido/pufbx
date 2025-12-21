# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_element, ufbx_node, ufbx_bone
from .wrappers cimport wrap_node, wrap_element, wrap_bone

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


