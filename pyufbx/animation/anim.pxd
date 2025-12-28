"""
For advanced usage you can use ufbx_create_anim() 
to create animation descriptors
 with custom layers, property overrides, special flags, etc.

double 	time_begin
double 	time_end
Time begin/end for the animation, both may be zero if absent.

ufbx_anim_layer_list 	layers
List of layers in the animation.

ufbx_real_list 	override_layer_weights
Optional overrides for weights for each layer in layers[].

ufbx_prop_override_list 	prop_overrides
Sorted by element_id, prop_name

ufbx_transform_override_list 	transform_overrides
Sorted by node_id

bool 	ignore_connections
Evaluate connected properties as if they would not be connected.

bool 	custom
Custom ufbx_anim created by ufbx_create_anim(). """

from pyufbx.pyufbx cimport ufbx_anim


cdef class Anim:
    cdef ufbx_anim *_anim
    cdef object __weakref__  # Enable weak references

cdef class BakedAnim:
    cdef ufbx_baked_anim *_baked_anim
    cdef object __weakref__  # Enable weak references

cdef class AnimLayer:
    cdef ufbx_anim_layer *_layer
    cdef object __weakref__  # Enable weak references

cdef class AnimValue:
    cdef ufbx_anim_value *_anim_value
    cdef object __weakref__  # Enable weak references