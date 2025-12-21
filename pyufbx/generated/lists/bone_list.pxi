cdef class BoneList:
    """A list-like wrapper for ufbx_bone pointers."""
    cdef ufbx_bone **_data
    cdef size_t _count

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
