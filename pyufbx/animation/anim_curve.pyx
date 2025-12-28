from .keyframe cimport KeyframeList

import numpy as np

cimport numpy as np
from libc.string cimport memcpy

from pyufbx.pyufbx cimport ufbx_keyframe

from ..props.prop cimport PropsWrapper

include "../core/strings.pxi"

vec2_dtype = np.dtype([
    ('dx', np.float32), 
    ('dy', np.float32)
])

# Define the dtype for keyframes
keyframe_dtype = np.dtype([
    ('time', np.float64),
    ('value', np.float64),       # ufbx_real is usually double, not float32
    ('interpolation', np.int32), # ufbx_interpolation
    ('left', vec2_dtype),        # Struct mapping for prev->right logic
    ('right', vec2_dtype)        # Struct mapping for next->left logic
], align=True) # align=True ensures C-struct-like padding

cdef class AnimCurve:
    """ Animation curve representation. """

    def __repr__(self):
        return f"<AnimCurve Name='{self.name}' element_id={self.element_id} typed_id={self.typed_id}>"
    @property
    def name(self):
        cdef ufbx_string name_str = self._anim_curve.name
        print(f"Debug: data={<size_t>name_str.data}, length={name_str.length}")
        return to_py_string(name_str)

    @property
    def element_id(self):
        return self._anim_curve.element_id
    @property
    def typed_id(self):
        return self._anim_curve.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._anim_curve.props)

    @property
    def keyframes(self):
        """List of keyframes that define the curve. as a Property use get_keyframe to axess array"""
        return KeyframeList.create(self._anim_curve.keyframes.data, self._anim_curve.keyframes.count)
    
    def get_keyframes(self):
        """
        Get keyframes as a structured NumPy array.
        This uses a direct memory copy for high performance.
        """
        cdef size_t count = self._anim_curve.keyframes.count
        
        if count == 0:
            return np.empty(0, dtype=keyframe_dtype)

        # SECURITY CHECK: 
        # Verify that our NumPy dtype is the exact same size as the C struct.
        # If this fails, the data will be corrupted/misaligned.
        if keyframe_dtype.itemsize != sizeof(ufbx_keyframe):
            raise RuntimeError(
                f"Size mismatch: NumPy dtype is {keyframe_dtype.itemsize} bytes, "
                f"but C ufbx_keyframe is {sizeof(ufbx_keyframe)} bytes. "
                "Please check float32 vs float64 definitions."
            )

        # 1. Allocate the NumPy array
        cdef np.ndarray[np.uint8_t, ndim=1, mode="c"] arr_buffer = \
            np.empty(count * sizeof(ufbx_keyframe), dtype=np.uint8)

        # 2. Perform the fast copy
        # We cast the ufbx pointer to void* and the numpy data to void*
        memcpy(
            <void*> arr_buffer.data, 
            <void*> self._anim_curve.keyframes.data, 
            count * sizeof(ufbx_keyframe)
        )

        # 3. View as the structured type
        return arr_buffer.view(dtype=keyframe_dtype)

    @property
    def pre_extrapolation(self):
        # TODO: pre_extrapolation add implementation
        raise NotImplementedError("AnimCurve pre_extrapolation is not yet implemented.")
    
    @property
    def post_extrapolation(self):
        # TODO: post_extrapolation add implementation
        raise NotImplementedError("AnimCurve post_extrapolation is not yet implemented.")

    @property
    def min_value(self):
        """Get the minimum value for all the keyframes in animation curve."""
        return self._anim_curve.min_value

    @property
    def max_value(self):
        """Get the maximum for all the keyframes in animation curve."""
        return self._anim_curve.max_value
    
    @property
    def min_time(self):
        """Get the minimum time of the animation curve."""
        return self._anim_curve.min_time

    @property
    def max_time(self):
        """Get the maximum time of the animation curve."""
        return self._anim_curve.max_time

