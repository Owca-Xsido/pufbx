# ufbx_wrapper.pyx
# cython: language_level=3
from src.pyufbx cimport *
from libc.stdlib cimport malloc, free
import numpy as np
from weakref import WeakValueDictionary
from threading import Lock
from cpython.bytes cimport PyBytes_FromStringAndSize

# Global cache for Node objects with thread safety
cdef object _node_cache_lock = Lock()
cdef object __node_cache = WeakValueDictionary()


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
        return to_py_string(self._element.name)

    # @property
    # def properties(self):
    #     return self._element.ufbx_props
    
    @property
    def element_id(self):
        return self._element.element_id
    
    @property
    def typed_id(self):
        return self._element.typed_id
    
    
    @property
    def type(self):
        return self._element.type
    
    @property
    def instance_count(self):
        return self.ptr.instances.count


cdef class Bone:
    cdef ufbx_bone *_bone
    @property
    def radus(self):
        return self._bone.radius
    
    @property
    def relative_length(self):
        return self._bone.relative_length
    @property
    def is_root(self):
        return self._bone.is_root
    



cdef Node wrap_node(ufbx_node *node):
    """
    Helper to safely convert a ufbx_node* pointer into a Python Node object,
    using a global cache to ensure only one Python object exists per C pointer.
    """
    if node == NULL:
        return None

    cdef size_t ptr_key = <size_t>node

    with _node_cache_lock:
        cached = __node_cache.get(ptr_key, None)
        if cached is not None:
            return <Node>cached

        py_node = Node()
        py_node._node = node
        __node_cache[ptr_key] = py_node
        return py_node



# Python wrapper for node
cdef class Node():
    cdef ufbx_node *_node
    cdef object __weakref__  # Enable weak references


    @property
    def name(self):
        return to_py_string(self._node.name)
       
    @property
    def is_root(self):
        return self._node.is_root

    @property
    def num_children(self):
        return self._node.children.count
    
    @property
    def local_transform(self):
        """Returns the local transform matrix as a numpy array."""
        pass

    @property
    def rotation_order(self):
        return self._node.rotation_order
    
    @property
    def is_visible(self):
        return self._node.visible
    
    @property
    def node_depth(self):
        return self._node.node_depth

    @property
    def parent(self):
        """Returns the parent Node, or None if it is the root."""
        if self._node.parent == NULL:
            return None
        return wrap_node(self._node.parent)
    # @property
    # def bone(self):
    #     """Returns the associated Bone object, or None if not a bone."""
    #     if self._node.bone == NULL:
    #         return None
    #     bone_obj = Bone()
    #     bone_obj._bone = self._node.bone
    #     return bone_obj

# Python wrapper for scene

cdef class Scene:
    cdef ufbx_scene *_scene
    
    def __cinit__(self):
        self._scene = NULL
    
    def __dealloc__(self):
        if self._scene != NULL:
            ufbx_free_scene(self._scene)
    
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