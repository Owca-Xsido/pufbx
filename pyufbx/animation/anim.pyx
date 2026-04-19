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

from ..core.math_types cimport Vec3Property
from ..generated.lists cimport AnimCurveList, AnimLayerList, AnimValueList, BakedNodeList, ElementList, NodeList
from ..generated.wrappers cimport wrap_anim, wrap_anim_prop, wrap_anim_value
from ..props.prop cimport PropsWrapper

include "../core/strings.pxi"

cdef class AnimValue:
    """ Animation value descriptor used for evaluating animated properties.
    """
    def __repr__(self):
        return f"<AnimValue Name='{self.name}' element_id={self.element_id} typed_id={self.typed_id}>"
    @property
    def name(self):
        cdef ufbx_string name_str = self._anim_value.name
        return to_py_string(name_str)

    @property
    def element_id(self):
        return self._anim_value.element_id
    @property
    def typed_id(self):
        return self._anim_value.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._anim_value.props)
        
    @property
    def default_value(self):
        return Vec3Property(self._anim_value.default_value.x,
                            self._anim_value.default_value.y,
                            self._anim_value.default_value.z)

    @property
    def curves(self):
        """Tuple of 3 animation curves for the value (X, Y, Z components)."""
        return AnimCurveList.create(self._anim_value.curves, 3)



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
        return AnimLayerList.create(self._anim.layers.data, self._anim.layers.count)

    @property
    def ignore_connections(self):
        return bool(self._anim.ignore_connections)
    
    @property
    def custom(self):
        return bool(self._anim.custom)

    

cdef class AnimLayer:
    """ Animation layer descriptor used for layering multiple animations.
    """
    # Common
    def __repr__(self):
        return f"<AnimLayer Name='{self.name}' element_id={self.element_id} typed_id={self.typed_id}>"
    @property
    def name(self):
        return to_py_string(self._anim_layer.name)

    @property
    def element_id(self):
        return self._anim_layer.element_id
    @property
    def typed_id(self):
        return self._anim_layer.typed_id
    
    @property
    def properties(self):
        return PropsWrapper.create(&self._anim_layer.props)
    
    cdef get_property_by_enum(self, enum):
        """Gets the prop.value without the hassle"""
        for prop in self.properties:
            if prop.prop_type == enum:
                return prop.value
        return None

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
    def compose_rotation(self):
        return self._layer.compose_rotation

    @property
    def compose_scale(self):
        return self._layer.compose_scale

    @property
    def anim_values(self):
        return AnimValueList.create(self._anim_layer.anim_values.data, 
                                    self._anim_layer.anim_values.count)
    
    @property
    def anim_props(self):
        return AnimPropList.create(self._anim_layer.anim_props.data,
                                    self._anim_layer.anim_props.count)
    
    @property
    def anim(self):
        return wrap_anim(self._anim_layer.anim)   

cdef class AnimProp:
        # Common
    def __repr__(self):
        return f"<AnimProp Name='{self.name}' element_id={self.element_id} typed_id={self.typed_id}>"
    @property
    def name(self):
        return to_py_string(self._anim_prop.prop_name)

    # @property
    # def element_id(self):
    #     return self._anim_prop.element_id
    # @property
    # def typed_id(self):
    #     return self._anim_prop.typed_id
        
    # @property
    # def properties(self):
    #     return PropsWrapper.create(&self._anim_prop.props)
   
    @property
    def anim_value(self):
        return wrap_anim_value(self._anim_prop.anim_value)

from pyufbx.pyufbx cimport ufbx_anim_prop


cdef class AnimPropList:
    """A list-like wrapper for ufbx_anim_prop pointers."""

    @staticmethod
    cdef AnimPropList create(ufbx_anim_prop *data, size_t count):
        cdef AnimPropList obj = AnimPropList.__new__(AnimPropList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count



    def __repr__(self):
        return f"<AnimPropList count={self._count}>"


