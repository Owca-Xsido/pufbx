from libc.string cimport memset

from ..animation.anim cimport Anim
from ..generated.wrappers cimport wrap_baked_anim
from ..pyufbx cimport ufbx_bake_anim  # Or just: from . cimport *
from ..pyufbx cimport ufbx_bake_opts, ufbx_baked_anim, ufbx_error
from ..scene cimport Scene


cdef class BakedAnim:
    """
    Animation descriptor used for evaluating baked animation.
    """

    # @property
    # def modified_nodes(self):
        # return NodeList.create(self._baked_anim.nodes.data, self._baked_anim.nodes.count)

    # @property
    # def modified_elements(self):
    #     return ElementList.create(self._baked_anim.elements.data, self._baked_anim.elements.count)

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


def bake_anim(Scene scene, Anim anim=None, dict opts=None):
    """
    Bake an animation to linearly interpolated keyframes.
    
    Composites the FBX transformation chain into quaternion rotations,
    making the animation easier to use with game engines and other applications.
    
    Args:
        scene: The scene containing the animation
        anim: The animation to bake (if None, bakes the scene's default animation)
        opts: Optional baking options dictionary with keys:
            - 'resample_rate': float - Target sample rate in fps (default: 30.0)
            - 'minimum_sample_rate': float - Minimum sample rate (default: 0.0)
            - 'maximum_sample_rate': float - Maximum sample rate (default: 0.0)
            - 'key_reduction_enabled': bool - Enable key reduction (default: True)
            - 'key_reduction_threshold': float - Threshold for key reduction (default: 0.001)
            - 'trim_start_time': float - Start time to trim (default: 0.0)
            - 'trim_end_time': float - End time to trim (default: 0.0)
    
    Returns:
        BakedAnim: The baked animation
    
    Raises:
        UFBXError: If baking fails
    
    Example:
        >>> baked = bake_anim(scene, anim, {'resample_rate': 60.0})
        >>> print(f"Baked {baked.num_samples} samples at {baked.sample_rate} fps")
    """
    cdef ufbx_bake_opts c_opts
    cdef ufbx_error error
    cdef ufbx_baked_anim* result
    
    # Initialize options with defaults
    # Note: You may need to call an init function if ufbx provides one
    # e.g., c_opts = ufbx_bake_opts_default() or memset(&c_opts, 0, sizeof(c_opts))
    memset(&c_opts, 0, sizeof(ufbx_bake_opts))
    
    # Set default values
    c_opts.resample_rate = 30.0
    c_opts.key_reduction_enabled = True
    c_opts.key_reduction_threshold = 0.001
    if opts is not None:
        if 'resample_rate' in opts:
            c_opts.resample_rate = opts['resample_rate']

    print('resample_rate',c_opts.resample_rate)

    # Initialize error
    memset(&error, 0, sizeof(ufbx_error))
    
    # Call the C function
    result = ufbx_bake_anim(
        scene._scene,
        anim._anim if anim is not None else NULL,
        &c_opts,
        &error
    )

   
    return wrap_baked_anim(result)