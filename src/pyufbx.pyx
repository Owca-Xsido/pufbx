# ufbx_wrapper.pyx
# cython: language_level=3
from src.pyufbx cimport *
from libc.stdlib cimport malloc, free
import numpy as np


# Python wrapper for strings
cdef str to_py_string(ufbx_string s):
    if s.data == NULL:
        return ""
    return s.data[:s.length].decode('utf-8')

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
        """Get list of all nodes in the scene"""
        cdef list result = []
        cdef size_t i
        cdef ufbx_node *node
        cdef ufbx_node **nodes_data = <ufbx_node**>self._scene.nodes.data
        
        for i in range(self._scene.nodes.count):
            node = nodes_data[i]
            result.append({
                'name': to_py_string(node.name),
                'is_root': node.is_root,
                'has_mesh': node.mesh != NULL
            })
        
        return result
    
    @property
    def num_nodes(self):
        return self._scene.nodes.count
    
    @property
    def num_meshes(self):
        return self._scene.meshes.count

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
    
    scene
    return <long>scene # Return the pointer address for simplicity