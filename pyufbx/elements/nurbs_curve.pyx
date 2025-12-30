# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_nurbs_curve

from ..props.prop cimport PropsWrapper
from .element cimport Element

include "../core/strings.pxi"


cdef class NurbsCurve:
    """Represents a NURBS curve in the FBX structure."""

    def __cinit__(self):
        self._nurbs_curve = NULL

    def __repr__(self):
        if self._nurbs_curve == NULL:
            return "<NurbsCurve None>"
        return f"<NurbsCurve name='{self.name}'>"

    @property
    def name(self):
        if self._nurbs_curve == NULL:
            return "None"
        return to_py_string(self._nurbs_curve.name)

    @property
    def element_id(self):
        return self._nurbs_curve.element_id

    @property
    def typed_id(self):
        return self._nurbs_curve.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._nurbs_curve.props)

    # Complex properties - TODO
    @property
    def instances(self):
        # TODO: instances add implementation
        raise NotImplementedError("instances is not implemented yet.")

    @property
    def basis(self):
        # TODO: basis add implementation
        raise NotImplementedError("basis is not implemented yet.")

    @property
    def control_points(self):
        # TODO: control_points add implementation
        raise NotImplementedError("control_points is not implemented yet.")

