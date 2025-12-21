# pyufbx/ufbx_wrapper.pyx
# cython: language_level=3
from libc.stdlib cimport free, malloc

from pyufbx.pyufbx cimport *  # Or just: from . cimport *

import numpy as np

from cpython.bytes cimport PyBytes_FromStringAndSize

from pyufbx.scene cimport Scene

# Include files (relative paths work here)s

include "core/strings.pxi"



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

    cdef Scene scene_obj = Scene()
    scene_obj._set_scene(scene)
    return scene_obj # Return the Scene object wrapping the ufbx_scene pointer


