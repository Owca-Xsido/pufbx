from ..elements.element cimport Element
from .keyframe cimport KeyframeList


cdef class AnimCurve(Element):
    """ Animation curve representation. """

    @property
    def keyframes(self):
        """List of keyframes that define the curve."""
        return KeyframeList.create(self._anim_curve.keyframes.data, self._anim_curve.keyframes.count)
        
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

