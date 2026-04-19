# cython: language_level=3
from pufbx.pufbx cimport ufbx_pose


cdef class Pose:
    cdef ufbx_pose *_pose

