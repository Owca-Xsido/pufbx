# ufbx_wrapper.pyx
# cython: language_level=3
from libc.stdlib cimport free, malloc

from src.pyufbx cimport *

import numpy as np

from cpython.bytes cimport PyBytes_FromStringAndSize

# Include the generated list and wrappers
include "generated_lists.pxi"
include "generated_wrappers.pxi"
include "enums.pxi"

# Python wrapper for strings


cdef str to_py_string(ufbx_string s):
    """
    Converts a ufbx_string (pointer + length) to a Python string.
    Handles NULL pointers and zero-length strings safely.
    """
    if s.data == NULL or s.length == 0:
        return ""
    # Create a Python bytes object from char* + length, then decode to str
    return PyBytes_FromStringAndSize(s.data, s.length).decode('utf-8')


cdef inline object blob_to_bytes(ufbx_blob blob):
    """Convert a ufbx_blob to Python bytes."""
    if blob.data == NULL or blob.size == 0:
        return b""
    return PyBytes_FromStringAndSize(<const char*>blob.data, blob.size)


cdef class Vec2Property:
    """Wrapper for 3D vector properties with conversion methods."""
    cdef double x, y

    def __init__(self, double x, double y):
        self.x = x
        self.y = y

    def as_list(self):
        """Returns as plain Python list."""
        return [self.x, self.y]

    def as_tuple(self):
        """Returns as tuple."""
        return (self.x, self.y)

    def as_array(self):
        """Returns as numpy array."""
        return np.array([self.x, self.y], dtype=np.float64)

    def __repr__(self):
        return f"Vec3({self.x}, {self.y})"

    def __iter__(self):
        """Allows unpacking: x, y = vec"""
        yield self.x
        yield self.y


cdef class Vec3Property:
    """Wrapper for 3D vector properties with conversion methods."""
    cdef double x, y, z

    def __init__(self, double x, double y, double z):
        self.x = x
        self.y = y
        self.z = z

    def as_list(self):
        """Returns as plain Python list."""
        return [self.x, self.y, self.z]

    def as_tuple(self):
        """Returns as tuple."""
        return (self.x, self.y, self.z)

    def as_array(self):
        """Returns as numpy array."""
        return np.array([self.x, self.y, self.z], dtype=np.float64)

    def __repr__(self):
        return f"Vec3({self.x}, {self.y}, {self.z})"

    def __iter__(self):
        """Allows unpacking: x, y, z = vec"""
        yield self.x
        yield self.y
        yield self.z


cdef class Vec4Property:
    """Wrapper for 4D vector properties with conversion methods."""
    cdef double x, y, z, w

    def __init__(self, double x, double y, double z, double w):
        self.x = x
        self.y = y
        self.z = z
        self.w = w

    def as_list(self):
        """Returns as plain Python list."""
        return [self.x, self.y, self.z, self.w]

    def as_tuple(self):
        """Returns as tuple."""
        return (self.x, self.y, self.z, self.w)

    def as_array(self):
        """Returns as numpy array."""
        return np.array([self.x, self.y, self.z, self.w], dtype=np.float64)

    def __repr__(self):
        return f"Vec4({self.x}, {self.y}, {self.z}, {self.w})"

    def __iter__(self):
        """Allows unpacking: x, y, z, w = vec"""
        yield self.x
        yield self.y
        yield self.z
        yield self.w


cdef class QuatProperty:
    """Wrapper for quaternion with conversion methods."""
    cdef double x, y, z, w

    def __init__(self, double x, double y, double z, double w):
        self.x = x
        self.y = y
        self.z = z
        self.w = w

    def as_list(self):
        """Returns as plain Python list [x, y, z, w]."""
        return [self.x, self.y, self.z, self.w]

    def as_tuple(self):
        """Returns as tuple (x, y, z, w)."""
        return (self.x, self.y, self.z, self.w)

    def as_array(self):
        """Returns as numpy array."""
        return np.array([self.x, self.y, self.z, self.w], dtype=np.float64)

    def __repr__(self):
        return f"Quat({self.x}, {self.y}, {self.z}, {self.w})"

    def __iter__(self):
        yield self.x
        yield self.y
        yield self.z
        yield self.w


cdef class TransformWrapper:
    cdef ufbx_transform *_transform

    @property
    def translation(self):
        return Vec3Property(
            self._transform.translation.x,
            self._transform.translation.y,
            self._transform.translation.z
        )

    @property
    def rotation(self):
        return QuatProperty(
            self._transform.rotation.x,
            self._transform.rotation.y,
            self._transform.rotation.z,
            self._transform.rotation.w
        )

    @property
    def scale(self):
        return Vec3Property(
            self._transform.scale.x,
            self._transform.scale.y,
            self._transform.scale.z
        )

cdef class Mesh:
    cdef ufbx_mesh *_mesh
    cdef object __weakref__
    
cdef class PropsWrapper:
    cdef ufbx_props *_props

    @staticmethod
    cdef PropsWrapper create(ufbx_props *props):
        cdef PropsWrapper obj = PropsWrapper.__new__(PropsWrapper)
        obj._props = props
        return obj

    def __len__(self):
        return self._props.props.count

    @property
    def num_animated(self):
        return self._props.num_animated

    @property
    def defaults(self):
        if self._props.defaults != NULL:
            return PropsWrapper.create(self._props.defaults)
        return None

    def __getitem__(self, idx):
        if idx < 0:
            idx += self._props.props.count
        if idx < 0 or idx >= self._props.props.count:
            raise IndexError("Index out of range")
        return wrap_prop(&self._props.props.data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._props.props.count):
            yield wrap_prop(&self._props.props.data[i])


cdef class Prop:
    cdef ufbx_prop *_prop
    cdef object __weakref__

    def __str__(self):
        return self.name

    def __repr__(self):
        return f"<Name='{self.name}'>"

    @property
    def name(self):

        return to_py_string(self._prop.name)

    @property
    def prop_type(self):
        """Returns prop type Class"""
        return PropType(<int>self._prop.type)

    @property
    def flags(self):
        return PropFlags(<int>self._prop.flags)

    @property
    def value_as_float(self):
        """Always get numeric value as float (works for int, bool, number types)."""
        return <double> self._prop.value_real

    @property
    def value_as_int(self):
        """Always get numeric value as int (works for int, bool, number types)."""
        return <int> self._prop.value_int

    @property
    def value(self):
        """Return the property value in the appropriate Python type."""
        ptype = self.prop_type

        # String types
        if ptype == PropType.UFBX_PROP_STRING:
            return to_py_string(self._prop.value_str)

        # Numeric types
        elif ptype == PropType.UFBX_PROP_BOOLEAN:
            return <bint> self._prop.value_int

        elif ptype == PropType.UFBX_PROP_INTEGER:
            return <int> self._prop.value_int

        elif ptype == PropType.UFBX_PROP_NUMBER:
            return <double> self._prop.value_real

        # Vector types
        elif ptype == PropType.UFBX_PROP_VECTOR:
            return Vec3Property(
                self._prop.value_vec3.x,
                self._prop.value_vec3.y,
                self._prop.value_vec3.z
            )

        elif ptype == PropType.UFBX_PROP_COLOR:
            return Vec3Property(
                self._prop.value_vec3.x,
                self._prop.value_vec3.y,
                self._prop.value_vec3.z)

        elif ptype == PropType.UFBX_PROP_COLOR_WITH_ALPHA:
            return Vec4Property(self._prop.value_vec4.x,
                                self._prop.value_vec4.y,
                                self._prop.value_vec4.z,
                                self._prop.value_vec4.w)

        elif ptype == PropType.UFBX_PROP_TRANSLATION:
            return Vec3Property(
                self._prop.value_vec3.x,
                self._prop.value_vec3.y,
                self._prop.value_vec3.z
            )

        elif ptype == PropType.UFBX_PROP_ROTATION:
            return Vec3Property(
                self._prop.value_vec3.x,
                self._prop.value_vec3.y,
                self._prop.value_vec3.z
            )

        elif ptype == PropType.UFBX_PROP_SCALING:
            return Vec3Property(
                self._prop.value_vec3.x,
                self._prop.value_vec3.y,
                self._prop.value_vec3.z
            )
        # # Blob/binary data
        elif ptype == PropType.UFBX_PROP_BLOB:
            return blob_to_bytes(self._prop.value_blob)

        # Fallback for unknown types
        else:
            return None


cdef class Element:
    cdef ufbx_element *_element
    cdef object __weakref__

    def __repr__(self):
        return f"<Name='{self.name}' id={self.id} type={self.element.type.name}>"

    def __str__(self):
        return self.name

    @property
    def name(self):
        if self._element == NULL:
            return ""
        return to_py_string(self._element.name)

    @property
    def element_id(self):
        return self._element.element_id

    @property
    def typed_id(self):
        return self._element.typed_id

    @property
    def element_type(self):
        return ElementType(<int>self._element.type)

    @property
    def instance_count(self):
        return self._element.instances.count


cdef class Bone:
    cdef ufbx_bone *_bone

    @property
    def element(self):
        """Returns the Element wrapper for this bone's element field."""
        if self._bone == NULL:
            return None
        element_obj = Element()
        element_obj._element = &self._bone.element  # Take address of the union
        return element_obj  # Return the Python wrapper, not the C pointer

    @property
    def name(self):
        return to_py_string(self._bone.element.name)

    @property
    def instance(self):
        return NodeList.create(self._bone.element.instances.data, self._bone.element.instances.count)

    @property
    def radius(self):
        return self._bone.radius

    @property
    def relative_length(self):
        return self._bone.relative_length

    @property
    def is_root(self):
        return self._bone.is_root


cdef class Node:
    cdef ufbx_node *_node
    cdef object __weakref__  # Enable weak references

    cdef TransformWrapper _local_transform_cache

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
        raise NotImplementedError("all_attribs is not implemented yet.")

    @property
    def inherit_mode(self):
        return self._node.inherit_mode

    @property
    def original_inherit_mode(self):
        return self._node.original_inherit_mode

    @property
    def rotation_order(self):
        return self._node.rotation_order

    @property
    def local_transform(self):
        # Only create wrapper once per node
        if self._local_transform_cache is None:
            wrapper = TransformWrapper()
            wrapper._transform = &self._node.local_transform
            self._local_transform_cache = wrapper
        return self._local_transform_cache

    @property
    def geometry_transform(self):
        return self._node.geometry_transform

    @property
    def inherit_scale(self):
        raise NotImplementedError("inherit_scale is not implemented yet.")
        # return self._node.inherit_scale

    @property
    def inherit_scale_node(self):
        raise NotImplementedError("inherit_scale_node is not implemented yet.")
        # return self._node.inherit_scale_node

    @property
    def rotation_order(self):
        return self._node.rotation_order

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
        return self.get_property_by_enum(PropType.UFBX_PROP_TRANSLATION)

    @property
    def lcl_rotation(self):
        """Property wrapper."""
        return self.get_property_by_enum(PropType.UFBX_PROP_ROTATION)

    @property
    def lcl_scale(self):
        """Property wrapper."""
        return self.get_property_by_enum(PropType.UFBX_PROP_SCALING)


# Python wrapper for scene

cdef class Scene:
    cdef ufbx_scene *_scene

    def __cinit__(self):
        self._scene = NULL

    def __dealloc__(self):
        if self._scene != NULL:
            ufbx_free_scene(self._scene)

    @property
    def root_node(self):
        """Returns the root node of the scene."""
        if self._scene.root_node == NULL:
            return None
        return wrap_node(self._scene.root_node)

    @property
    def nodes(self):
        """Get list of all nodes in the scene, wrapped as Node objects."""

        # 1. DECLARE ALL C-LEVEL VARIABLES AT THE TOP using 'cdef'
        cdef list result = []
        cdef size_t i
        cdef ufbx_node *node
        cdef ufbx_node **nodes_data = <ufbx_node**>self._scene.nodes.data
        cdef Node node_obj

        for i in range(self._scene.nodes.count):
            node = nodes_data[i]
            node_obj = wrap_node(node)
            result.append(node_obj)

        return result

    @property
    def num_nodes(self):
        return self._scene.nodes.count

    @property
    def num_meshes(self):
        return self._scene.meshes.count

    def get_node_names(self):
        """Returns a list of all node names in the scene."""
        cdef list names = []
        cdef size_t i
        cdef ufbx_node *node
        cdef ufbx_node **nodes_data = <ufbx_node**>self._scene.nodes.data

        for i in range(self._scene.nodes.count):
            node = nodes_data[i]
            names.append(to_py_string(node.name))

        return names


# Main loading function
def load_fbx(filename: str):
    """
    Loads an FBX file using the ufbx C library.
    Returns a pointer to the ufbx_scene (which you would typically wrap 
    in a Python class for safe memory management).
    """

    # Declare C-level variables
    cdef ufbx_load_opts opts
    cdef ufbx_error error
    cdef ufbx_scene *scene = NULL

    # Convert Python string to C string (bytes)
    cdef bytes filename_bytes = filename.encode('utf-8')
    cdef const char *c_filename = filename_bytes

    # Call the imported C function
    scene = ufbx_load_file(c_filename, NULL, &error)

    # Simple error check (assuming you have error handling logic)
    if scene is NULL:
        # In a real library, you'd raise a proper exception here
        # based on the content of the 'error' struct.
        error_msg = to_py_string(error.description)

        raise FileNotFoundError(
            f"Could not load FBX file: {filename} {error_msg}")

    scene_obj = Scene()
    scene_obj._scene = scene
    return scene_obj  # Return the Scene object wrapping the ufbx_scene pointer