
# elements/node.pyx
# cython: language_level=3

from ..core.math_types cimport (QuatProperty, Vec2Property, Vec3Property,
                                Vec4Property)
from ..props.props cimport Prop, PropsWrapper
from .bone cimport Bone
from .element cimport Element

from ..enums.element_types import ElementType
from ..enums.enums import InheritMode, RotationOrder
from ..enums.property_types import PropType

from ..generated.lists cimport ElementList, NodeList
from ..generated.wrappers cimport wrap_node, wrap_transform

include "../core/strings.pxi"


cdef class Node:

   

    def __repr__(self):
        return f"<Node name='{self.name}' id={self.id} type={self.element.element_type.name}>"

    def __str__(self):
        return self.name

    def __len__(self):
        return self.num_children

    def __iter__(self):
        return iter(self.children)

    cdef get_property_by_enum(self, enum):
        """Gets the prop.value without the hassle"""
        for prop in self.properties:
            if prop.prop_type == enum:
                return prop.value
        return None

    @property
    def element(self):
        """Returns the Element wrapper for this node's union element field."""
        if self._node == NULL:
            return None
        element_obj = Element()
        element_obj._element = &self._node.element  # Take address of the union
        return element_obj  # Return the Python wrapper, not the C pointer

    @property
    def name(self):
        return to_py_string(self._node.name)

    @property
    def properties(self):
        return PropsWrapper.create(&self._node.props)

    @property
    def id(self):
        return self._node.element_id

    @property
    def typed_id(self):
        return self._node.typed_id

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
        raise NotImplementedError("mesh is not implemented yet.")

    @property
    def light(self):
        raise NotImplementedError("light is not implemented yet")

    @property
    def camera(self):
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
        raise NotImplementedError(
            "geometry_transform_helper is not implemented yet.")

    @property
    def scale_helper(self):
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
        raise NotImplementedError("materials is not implemented yet.")

    @property
    def bind_pose(self):
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
