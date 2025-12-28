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

from ..generated.lists cimport ElementList, NodeList


cdef class AnimValue:
    """ Animation value descriptor used for evaluating animated properties.
    """
    def __repr__(self):
        return f"<AnimValue name='{self.name}'>"
    def __str__(self):
        return self.name

    @property
    def name(self):
        return to_py_string(self._anim_value.name)
    
    @property
    def element_id(self):
        return self._anim_value.element_id
    
    @property
    def typed_id(self):
        return self._anim_value.typed_id
    
    @property
    def properties(self):
        return self._anim_value.prop_type


cdef class Anim:
    """"
    Animation descriptor used for evaluating animation.
    """

    @property
    def time_begin(self):
        """ Time begin for the animation. TODO: Find out what numbers represent."""
        return self._anim.time_begin

    @property
    def time_end(self):
        """ Time end for the animation. TODO: Find out what numbers represent."""
        return self._anim.time_end

    @property
    def layers(self):
        # TODO: layers add implementation
        raise NotImplementedError("Animation layers are not yet implemented.")
    
    @property
    def override_layer_weights(self):
        # TODO: override_layer_weights add implementation
        raise NotImplementedError("Override layer weights are not yet implemented.")

    @property
    def prop_overrides(self):
        # TODO: prop_overrides add implementation
        raise NotImplementedError("Property overrides are not yet implemented.")

    @property
    def transform_overrides(self):
        # TODO: transform_overrides add implementation
        raise NotImplementedError("Transform overrides are not yet implemented.")

    @property
    def ignore_connections(self):
        return self._anim.ignore_connections
    
    @property
    def custom(self):
        return self._anim.custom

    
def class BakedAnim:
    """
    Animation descriptor used for evaluating baked animation.
    """

    @property
    def modified_nodes(self):
        return NodeList.create(self._baked_anim.nodes)

    @property
    def modified_elements(self):
        return ElementList.create(self._baked_anim.elements)

    @property
    def playback_time_begin(self):
        return self._baked_anim.playback_time_begin

    @property
    def playback_time_end(self):
        return self._baked_anim.playback_time_end

    @property
    def playback_duration(self):
        return self._baked_anim.playback_duration

    @property
    def key_time_min(self):
        return self._baked_anim.key_time_min
    @property
    def key_time_max(self):
        return self._baked_anim.key_time_max
    @property
    def metadata(self):
        return self._baked_anim.metadata


cdef class AnimLayer:

    def __repr__(self):
    return f"<AnimLayer name='{self.name}' weight={self.weight}>"
    
    def __cinit__(self, ufbx_anim_layer* layer not None):
        self._layer = layer

    @property
    def name(self):
        return to_py_string(self._layer.name)
    
    @property
    def element_id(self):
        return self._layer.element_id
    
    @property
    def typed_id(self):
        return self._layer.typed_id
    
    @property
    def weight(self):
        return self._layer.weight
    
    @property
    def blended(self):
        return self._layer.blended

    @property
    def additive(self):
        return self._layer.additive

    @property
    def compose_rotations(self):
        return self._layer.compose_rotations

    @property
    def compose_scales(self):
        return self._layer.compose_scales

    @property
    def anim_values(self):
        # TODO: anim_values add implementation
        raise NotImplementedError("AnimLayer anim_values are not yet implemented.")
    
    @property
    def anim_props(self):
        # TODO: anim_props add implementation
        raise NotImplementedError("AnimLayer anim_props are not yet implemented.")
    

