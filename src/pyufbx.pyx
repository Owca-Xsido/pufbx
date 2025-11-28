# ufbx_wrapper.pyx
# cython: language_level=3
from libc.stdlib cimport free, malloc

from src.pyufbx cimport *

import numpy as np

from cpython.bytes cimport PyBytes_FromStringAndSize

from enum import IntEnum

# Include the generated list and wrappers
include "generated_lists.pxi"
include "generated_wrappers.pxi"

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


cdef class TransformWrapper:
    cdef ufbx_transform *_transform
    
    @property
    def translation(self):
        return (self._transform.translation.x,
                self._transform.translation.y,
                self._transform.translation.z)
    
    @property
    def rotation(self):
        return (self._transform.rotation.x,
                self._transform.rotation.y,
                self._transform.rotation.z,
                self._transform.rotation.w)
    
    @property
    def scale(self):
        return (self._transform.scale.x,
                self._transform.scale.y,
                self._transform.scale.z)

    
        
cdef class Property:
    cdef ufbx_prop *_prop

    @property
    def name(self):
        return to_py_string(self._prop.name)
    
    @property
    def type(self):
        return self._prop.type
    
    

cdef class Element:
    cdef ufbx_element *_element

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
    def type(self):
        return ElementType(self._element.type)
    
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

    
    def __repr__(self):
        return f"<Node name='{self.name}' id={self.id} type={self.element.type.name}>"

    def __str__(self):
        return self.__repr__()

    def __len__(self):
        return self.num_children

    def __iter__(self):
        return iter(self.children)


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
        raise NotImplementedError("properties is not implemented yet.")
        # return PropertyList.create(self._node.props.data, self._node.props.count)

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
        return <bint>self._node.is_root


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
       raise NotImplementedError("geometry_transform_helper is not implemented yet.")

    @property
    def scale_helper(self):
        raise NotImplementedError("scale_helper is not implemented yet.")

    @property
    def attrib_type(self):
        """Returns the type of the attached element."""
        return ElementType(self._node.attrib_type)
    @property
    def all_attribs(self):
        raise NotImplementedError("all_attribs is not implemented yet.")

    @property
    def local_transform(self):
        """Returns the local transform matrix as a numpy array."""
        pass

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
        cdef TransformWrapper wrapper = TransformWrapper()
        wrapper._transform = &self._node.local_transform
        return wrapper
        
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
        return <bint>self._node.visible
    
    @property
    def has_geometry_transform(self):
        return <bint>self._node.has_geometry_transform
    
    @property
    def	has_adjust_transform(self):
        return <bint>self._node.has_adjust_transform

    @property
    def has_root_adjust_transform(self):
        return <bint>self._node.has_root_adjust_transform

    @property
    def is_geometry_transform_helper(self):
        return <bint>self._node.is_geometry_transform_helper

    @property
    def is_scale_helper(self):
        return <bint>self._node.is_scale_helper

    @property
    def is_scale_compensate_parent(self):
        return <bint>self._node.is_scale_compensate_parent


    @property
    def node_depth(self):
        return self._node.node_depth





    

    
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

        raise FileNotFoundError(f"Could not load FBX file: {filename} {error_msg}")
    
    scene_obj = Scene()
    scene_obj._scene = scene
    return scene_obj # Return the Scene object wrapping the ufbx_scene pointer





class ElementType(IntEnum):
    """Enum representing ufbx element types."""
    def __str__(self):
        return self.name
    def __repr__(self):
        return f"ElementType.{self.name}"
    UNKNOWN = 0
    NODE = 1
    MESH = 2
    LIGHT = 3
    CAMERA = 4
    BONE = 5
    EMPTY = 6
    LINE_CURVE = 7
    NURBS_CURVE = 8
    NURBS_SURFACE = 9
    NURBS_TRIM_SURFACE = 10
    NURBS_TRIM_BOUNDARY = 11
    PROCEDURAL_GEOMETRY = 12
    STEREO_CAMERA = 13
    CAMERA_SWITCHER = 14
    MARKER = 15
    LOD_GROUP = 16
    SKIN_DEFORMER = 17
    SKIN_CLUSTER = 18
    BLEND_DEFORMER = 19
    BLEND_CHANNEL = 20
    BLEND_SHAPE = 21
    CACHE_DEFORMER = 22
    CACHE_FILE = 23
    MATERIAL = 24
    TEXTURE = 25
    VIDEO = 26
    SHADER = 27
    SHADER_BINDING = 28
    ANIM_STACK = 29
    ANIM_LAYER = 30
    ANIM_VALUE = 31
    ANIM_CURVE = 32
    DISPLAY_LAYER = 33
    SELECTION_SET = 34
    SELECTION_NODE = 35
    CHARACTER = 36
    CONSTRAINT = 37
    AUDIO_LAYER = 38
    AUDIO_CLIP = 39
    POSE = 40
    METADATA_OBJECT = 41