from pyufbx.pyufbx cimport ufbx_anim_curve

from ..elements.element cimport Element


cdef class AnimCurve(Element):
    """ Animation curve representation. """
    cdef ufbx_anim_curve *_anim_curve
    cdef object __weakref__  # Enable weak references