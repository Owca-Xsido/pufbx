# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_element, ufbx_node, ufbx_prop, ufbx_transform, ufbx_bone, ufbx_anim, ufbx_anim_value, ufbx_anim_curve
from pyufbx.elements cimport Element
from pyufbx.elements cimport Node
from pyufbx.props cimport Prop
from pyufbx.core cimport Transform
from pyufbx.elements cimport Bone
from pyufbx.animation cimport Anim
from pyufbx.animation cimport AnimValue
from pyufbx.animation cimport AnimCurve

cdef Element wrap_element(ufbx_element *ptr)
cdef Node wrap_node(ufbx_node *ptr)
cdef Prop wrap_prop(ufbx_prop *ptr)
cdef Transform wrap_transform(ufbx_transform *ptr)
cdef Bone wrap_bone(ufbx_bone *ptr)
cdef Anim wrap_anim(ufbx_anim *ptr)
cdef AnimValue wrap_anim_value(ufbx_anim_value *ptr)
cdef AnimCurve wrap_anim_curve(ufbx_anim_curve *ptr)
