# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_pose


cdef class Pose:
    cdef ufbx_pose *_pose

