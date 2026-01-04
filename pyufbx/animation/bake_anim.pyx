from libc.string cimport memset

from ..animation.anim cimport Anim
from ..generated.lists cimport BakedNodeList
from ..generated.wrappers cimport wrap_baked_anim
from ..pyufbx cimport ufbx_bake_anim  # Or just: from . cimport *
from ..pyufbx cimport ufbx_bake_opts, ufbx_baked_anim, ufbx_error
from ..scene cimport Scene


cdef class BakedAnim:
    """
    Animation descriptor used for evaluating baked animation.
    """

    @property
    def modified_nodes(self):
        return BakedNodeList.create(self._baked_anim.nodes.data, self._baked_anim.nodes.count)

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


def bake_anim(Scene scene, Anim anim=None, *,
              resample_rate=120.0,
              minimum_sample_rate=0.0,
              maximum_sample_rate=0.0,
              trim_start_time=False,
              bake_transform_props=False,
              skip_node_transforms=False,
              no_resample_rotation=False,
              ignore_layer_weight_animation=False,
              max_keyframe_segments=0,
              step_handling=None,  # ufbx_bake_step_handling enum value
              step_custom_duration=0.0,
              step_custom_epsilon=0.0,
              evaluate_flags=0,
              key_reduction_enabled=False,
              key_reduction_rotation=False,
              key_reduction_threshold=0.001,
              key_reduction_passes=2):
    """
    Bake an animation to linearly interpolated keyframes.
    
    Composites the FBX transformation chain into quaternion rotations,
    making the animation easier to use with game engines and other applications.
    
    Args:
        scene: The scene containing the animation
        anim: The animation to bake (if None, bakes the scene's default animation)
        resample_rate: Target sample rate in fps (default: 30.0)
        minimum_sample_rate: Minimum sample rate (default: 0.0)
        maximum_sample_rate: Maximum sample rate (default: 0.0)
        trim_start_time: Trim to start time (default: False)
        bake_transform_props: Bake transform properties (default: False)
        skip_node_transforms: Skip node transforms (default: False)
        no_resample_rotation: Don't resample rotation (default: False)
        ignore_layer_weight_animation: Ignore layer weight animation (default: False)
        max_keyframe_segments: Maximum keyframe segments (default: 0, unlimited)
        step_handling: Step handling mode (ufbx_bake_step_handling enum)
        step_custom_duration: Custom step duration (default: 0.0)
        step_custom_epsilon: Custom step epsilon (default: 0.0)
        evaluate_flags: Evaluation flags (default: 0)
        key_reduction_enabled: Enable key reduction (default: False)
        key_reduction_rotation: Apply key reduction to rotation (default: True)
        key_reduction_threshold: Threshold for key reduction (default: 0.001)
        key_reduction_passes: Number of key reduction passes (default: 2)
    
    Returns:
        BakedAnim: The baked animation
    
    Raises:
        UFBXError: If baking fails
    
    Example:
        >>> baked = bake_anim(scene, anim, resample_rate=60.0, key_reduction_enabled=False)
        >>> print(f"Baked {baked.num_samples} samples at {baked.sample_rate} fps")
    """
    cdef ufbx_bake_opts c_opts
    cdef ufbx_error error
    cdef ufbx_baked_anim* result
    
    # Initialize options - zero out the struct
    memset(&c_opts, 0, sizeof(ufbx_bake_opts))
    
    # Set values from parameters
    c_opts.resample_rate = resample_rate
    c_opts.minimum_sample_rate = minimum_sample_rate
    c_opts.maximum_sample_rate = maximum_sample_rate
    c_opts.trim_start_time = trim_start_time
    c_opts.bake_transform_props = bake_transform_props
    c_opts.skip_node_transforms = skip_node_transforms
    c_opts.no_resample_rotation = no_resample_rotation
    c_opts.ignore_layer_weight_animation = ignore_layer_weight_animation
    c_opts.max_keyframe_segments = max_keyframe_segments
    c_opts.step_custom_duration = step_custom_duration
    c_opts.step_custom_epsilon = step_custom_epsilon
    c_opts.evaluate_flags = evaluate_flags
    c_opts.key_reduction_enabled = key_reduction_enabled
    c_opts.key_reduction_rotation = key_reduction_rotation
    c_opts.key_reduction_threshold = key_reduction_threshold
    c_opts.key_reduction_passes = key_reduction_passes
    
    # Handle step_handling enum if provided
    if step_handling is not None:
        c_opts.step_handling = step_handling

    # Initialize error
    memset(&error, 0, sizeof(ufbx_error))
    
    # Call the C function
    result = ufbx_bake_anim(
        scene._scene,
        anim._anim if anim is not None else NULL,
        &c_opts,
        &error
    )
    
    # Check for errors
    if result == NULL:
        # TODO: Raise a proper UFBXError exception
        raise NotImplementedError(f"ERORR HERE: {error.message.decode('utf-8')}")
    return wrap_baked_anim(result)