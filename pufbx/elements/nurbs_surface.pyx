# cython: language_level=3
from pufbx.pufbx cimport ufbx_nurbs_surface

from ..props.prop cimport PropsWrapper
from .element cimport Element

include "../core/strings.pxi"


cdef class NurbsSurface:
    """Represents a NURBS surface in the FBX structure."""

    def __cinit__(self):
        self._nurbs_surface = NULL

    def __repr__(self):
        if self._nurbs_surface == NULL:
            return "<NurbsSurface None>"
        return f"<NurbsSurface name='{self.name}'>"

    @property
    def name(self):
        if self._nurbs_surface == NULL:
            return "None"
        return to_py_string(self._nurbs_surface.name)

    @property
    def element_id(self):
        return self._nurbs_surface.element_id

    @property
    def typed_id(self):
        return self._nurbs_surface.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._nurbs_surface.props)

    # Simple properties
    @property
    def num_control_points_u(self):
        return self._nurbs_surface.num_control_points_u

    @property
    def num_control_points_v(self):
        return self._nurbs_surface.num_control_points_v

    @property
    def span_subdivision_u(self):
        return self._nurbs_surface.span_subdivision_u

    @property
    def span_subdivision_v(self):
        return self._nurbs_surface.span_subdivision_v

    @property
    def flip_normals(self):
        return <bint> self._nurbs_surface.flip_normals

    # Complex properties - TODO
    @property
    def instances(self):
        # TODO: instances add implementation
        raise NotImplementedError("instances is not implemented yet.")

    @property
    def basis_u(self):
        # TODO: basis_u add implementation
        raise NotImplementedError("basis_u is not implemented yet.")

    @property
    def basis_v(self):
        # TODO: basis_v add implementation
        raise NotImplementedError("basis_v is not implemented yet.")

    @property
    def control_points(self):
        # TODO: control_points add implementation
        raise NotImplementedError("control_points is not implemented yet.")

    @property
    def material(self):
        # TODO: material add implementation
        raise NotImplementedError("material is not implemented yet.")

