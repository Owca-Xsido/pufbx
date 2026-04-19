
from pufbx.pufbx cimport ufbx_baked_anim


cdef class BakedAnim:
    cdef ufbx_baked_anim *_baked_anim
    cdef object __weakref__  # Enable weak references
    # cdef get_property_by_enum(self, enum)