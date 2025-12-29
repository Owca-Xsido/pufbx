# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_element, ufbx_node, ufbx_bone, ufbx_anim, ufbx_anim_value, ufbx_anim_curve, ufbx_anim_layer

cdef class ElementList:
    cdef ufbx_element **_data
    cdef size_t _count
    @staticmethod
    cdef ElementList create(ufbx_element **data, size_t count)

cdef class NodeList:
    cdef ufbx_node **_data
    cdef size_t _count
    @staticmethod
    cdef NodeList create(ufbx_node **data, size_t count)

cdef class BoneList:
    cdef ufbx_bone **_data
    cdef size_t _count
    @staticmethod
    cdef BoneList create(ufbx_bone **data, size_t count)

cdef class AnimList:
    cdef ufbx_anim **_data
    cdef size_t _count
    @staticmethod
    cdef AnimList create(ufbx_anim **data, size_t count)

cdef class AnimValueList:
    cdef ufbx_anim_value **_data
    cdef size_t _count
    @staticmethod
    cdef AnimValueList create(ufbx_anim_value **data, size_t count)

cdef class AnimCurveList:
    cdef ufbx_anim_curve **_data
    cdef size_t _count
    @staticmethod
    cdef AnimCurveList create(ufbx_anim_curve **data, size_t count)

cdef class AnimLayerList:
    cdef ufbx_anim_layer **_data
    cdef size_t _count
    @staticmethod
    cdef AnimLayerList create(ufbx_anim_layer **data, size_t count)

