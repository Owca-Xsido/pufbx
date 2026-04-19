# cython: language_level=3
from pufbx.pufbx cimport ufbx_skin_cluster


cdef class SkinCluster:
    cdef ufbx_skin_cluster *_skin_cluster

