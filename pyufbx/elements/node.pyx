
# elements/node.pyx
# cython: language_level=3

from ..core.math_types cimport (QuatProperty, Vec2Property, Vec3Property,
                                Vec4Property, fast_baked_quat_copy)
from ..props.prop cimport Prop, PropsWrapper
from .bone cimport Bone
from .element cimport Element

from ..enums.element_types import ElementType
from ..enums.enums import InheritMode, RotationOrder
from ..enums.property_types import PropType

from ..generated.lists cimport ElementList, NodeList
from ..generated.wrappers cimport wrap_node, wrap_transform

include "../core/strings.pxi"


cdef class Node:
    """Represents a node in the FBX scene graph."""


    # Common
    def __repr__(self):
        return f"<Node Name='{self.name}' element_id={self.element_id} typed_id={self.typed_id}>"
    @property
    def name(self):
        return to_py_string(self._node.name)

    @property
    def element_id(self):
        return self._node.element_id
    @property
    def typed_id(self):
        return self._node.typed_id
    
    @property
    def properties(self):
        return PropsWrapper.create(&self._node.props)
    
    cdef get_property_by_enum(self, enum):
        """Gets the prop.value without the hassle"""
        for prop in self.properties:
            if prop.prop_type == enum:
                return prop.value
        return None


    def __len__(self):
        return self.num_children

    def __iter__(self):
        return iter(self.children)
    @property
    def parent(self):
        """Returns the parent Node, or None if it is the root."""
        if self._node.parent == NULL:
            return None
        return wrap_node(self._node.parent)

    @property
    def children(self):
        return NodeList.create(self._node.children.data, self._node.children.count)

    @property
    def is_root(self):
        return <bint> self._node.is_root

    @property
    def num_children(self):
        return self._node.children.count

    @property
    def mesh(self):
        # TODO: mesh add implementation
        raise NotImplementedError("mesh is not implemented yet.")

    @property
    def light(self):
        # TODO: light add implementation
        raise NotImplementedError("light is not implemented yet")

    @property
    def camera(self):
        # TODO: camera add implementation
        raise NotImplementedError("camera is not implemented yet")

    @property
    def bone(self):
        """Returns the associated Bone object, or None if not a bone."""
        if self._node.bone == NULL:
            return None
        bone_obj = Bone()
        bone_obj._bone = self._node.bone
        return bone_obj

    @property
    def attrib(self):
        """Returns the generic attached element (for less common types)."""
        if self._node.attrib == NULL:
            return None
        element_obj = Element()
        element_obj._element = self._node.attrib
        return element_obj

    @property
    def geometry_transform_helper(self):
        # TODO: geometry_transform_helper add implementation
        raise NotImplementedError(
            "geometry_transform_helper is not implemented yet.")

    @property
    def scale_helper(self):
        # TODO: scale_helper add implementation
        raise NotImplementedError("scale_helper is not implemented yet.")

    @property
    def attrib_type(self):
        """Returns the type of the attached element."""
        return ElementType(<int>self._node.attrib_type)

    @property
    def all_attribs(self):
        return ElementList.create(self._node.all_attribs.data, self._node.all_attribs.count)

    @property
    def inherit_mode(self):
        return InheritMode(<int>self._node.inherit_mode)

    @property
    def original_inherit_mode(self):
        return InheritMode(<int>self._node.original_inherit_mode)

    @property
    def rotation_order(self):
        return RotationOrder(<int>self._node.rotation_order)

    @property
    def local_transform(self):
        # Only create wrapper once per node
        return wrap_transform(&self._node.local_transform)

    @property
    def geometry_transform(self):
        return  wrap_transform(&self._node.geometry_transform)

    @property
    def inherit_scale(self):
        return Vec3Property(
            self._node.inherit_scale.x,
            self._node.inherit_scale.y,
            self._node.inherit_scale.z
            )

    @property
    def inherit_scale_node(self):
        """Node where scale is inherited from for UFBX_INHERIT_MODE_COMPONENTWISE_SCALE 
        and even for UFBX_INHERIT_MODE_IGNORE_PARENT_SCALE.
         For componentwise-scale nodes, this will point to parent, 
         for scale ignoring nodes this will point to the parent of the nearest componentwise-scaled 
         node in the parent chain."""


        return wrap_node(self._node.inherit_scale_node)
        # return self._node.inherit_scale_node

    @property
    def rotation_order(self):
        return RotationOrder(self._node.rotation_order)

    @property
    def euler_rotation(self):
        return self._node.euler_rotation

    @property
    def node_to_parent(self):
        return self._node.node_to_parent

    @property
    def node_to_world(self):
        return self._node.node_to_world

    @property
    def geometry_to_node(self):
        return self._node.geometry_to_node

    @property
    def geometry_to_world(self):
        return self._node.geometry_to_world

    @property
    def unscaled_node_to_world(self):
        return self._node.unscaled_node_to_world

    @property
    def adjust_pre_translation(self):
        return self._node.adjust_pre_translation

    @property
    def adjust_pre_rotation(self):
        return self._node.adjust_pre_rotation

    @property
    def adjust_pre_scale(self):
        return self._node.adjust_pre_scale

    @property
    def adjust_post_rotation(self):
        return self._node.adjust_post_rotation

    @property
    def adjust_post_scale(self):
        return self._node.adjust_post_scale

    @property
    def adjust_translation_scale(self):
        return self._node.adjust_translation_scale

    @property
    def adjust_mirror_axis(self):
        return self._node.adjust_mirror_axis

    @property
    def materials(self):
        # TODO: materials add implementation
        raise NotImplementedError("materials is not implemented yet.")

    @property
    def bind_pose(self):
        # TODO: bind_pose add implementation
        raise NotImplementedError("bind_pose is not implemented yet.")

    @property
    def is_visible(self):
        return <bint> self._node.visible

    @property
    def has_geometry_transform(self):
        return <bint> self._node.has_geometry_transform

    @property
    def has_adjust_transform(self):
        return <bint> self._node.has_adjust_transform

    @property
    def has_root_adjust_transform(self):
        return <bint> self._node.has_root_adjust_transform

    @property
    def is_geometry_transform_helper(self):
        return <bint> self._node.is_geometry_transform_helper

    @property
    def is_scale_helper(self):
        return <bint> self._node.is_scale_helper

    @property
    def is_scale_compensate_parent(self):
        return <bint> self._node.is_scale_compensate_parent

    @property
    def node_depth(self):
        return self._node.node_depth

    @property
    def lcl_translation(self):
        """Property wrapper."""
        return self.get_property_by_enum(PropType.TRANSLATION)

    @property
    def lcl_rotation(self):
        """Property wrapper."""
        return self.get_property_by_enum(PropType.ROTATION)

    @property
    def lcl_scale(self):
        """Property wrapper."""
        return self.get_property_by_enum(PropType.SCALING)
        """Property wrapper."""
        return self.get_property_by_enum(PropType.ROTATION)

    @property
    def lcl_scale(self):
        """Property wrapper."""
        return self.get_property_by_enum(PropType.SCALING)


class BakedNode:
    """Baked transform animation for a single node. From used in Bake Anim func"""

    def __init__(self, baked_node):
        """Initialize with a baked node data structure"""
        self._baked_node = baked_node
    
    @property
    def element_id(self):
        """Return the element ID of the baked node"""
        return self._baked_node.element_id
        
    @property
    def typed_id(self):
        """Return the typed ID of the baked node"""
        return self._baked_node.typed_id

    @property
    def name(self):
        """Return the name of the baked node (accessible via the underlying element)"""
        return self._baked_node.name

    @property
    def constant_translation(self): 
        """True if translation doesn't change over the animation"""
        return self._baked_node.constant_translation

    @property
    def constant_rotation(self):
        """True if rotation doesn't change over the animation"""
        return self._baked_node.constant_rotation

    @property
    def constant_scale(self):
        """True if scale doesn't change over the animation"""
        return self._baked_node.constant_scale


    @property
    def translation_keys(self):
        """Returns the list of baked translation vectors"""
        return self._baked_node.translation_keys

    @property
    def rotation_keys(self):
        """Returns the list of baked rotation quaternions"""
        return fast_baked_quat_copy(self._baked_node.rotation_keys)
        
    @property
    def scale_keys(self):
        """Returns the list of baked scale vectors"""
        return self._baked_node.scale_keys