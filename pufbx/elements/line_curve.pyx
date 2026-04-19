# cython: language_level=3
from pufbx.pufbx cimport ufbx_line_curve

from ..core.math_types cimport Vec3Property
from ..generated.lists cimport NodeList
from ..props.prop cimport PropsWrapper
from .element cimport Element

include "../core/strings.pxi"


cdef class LineCurve:
    """Represents a line curve in the FBX structure."""

    def __cinit__(self):
        self._line_curve = NULL

    def __repr__(self):
        if self._line_curve == NULL:
            return "<LineCurve None>"
        return f"<LineCurve name='{self.name}'>"

    @property
    def name(self):
        if self._line_curve == NULL:
            return "None"
        return to_py_string(self._line_curve.name)

    @property
    def element_id(self):
        return self._line_curve.element_id

    @property
    def typed_id(self):
        return self._line_curve.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._line_curve.props)

    # Simple properties
    @property
    def color(self):
        return Vec3Property(
            self._line_curve.color.x,
            self._line_curve.color.y,
            self._line_curve.color.z
        )

    @property
    def from_tessellated_nurbs(self):
        return <bint> self._line_curve.from_tessellated_nurbs

    @property
    def instances(self):
        return NodeList.create(self._line_curve.instances.data, self._line_curve.instances.count)

    @property
    def num_control_points(self):
        return self._line_curve.control_points.count

    @property
    def num_segments(self):
        return self._line_curve.segments.count

