from pufbx.pufbx cimport ufbx_anim_curve


cdef class AnimCurve:
    """ Animation curve representation. """
    cdef ufbx_anim_curve *_anim_curve
    cdef object __weakref__  # Enable weak references