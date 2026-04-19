# cython: language_level=3
from pufbx.pufbx cimport ufbx_mesh

from ..props.prop cimport PropsWrapper
from .element cimport Element

include "../core/strings.pxi"


cdef class Mesh:
    """Represents a mesh in the FBX structure."""

    def __cinit__(self):
        self._mesh = NULL

    def __repr__(self):
        if self._mesh == NULL:
            return "<Mesh None>"
        return f"<Mesh name='{self.name}'>"

    @property
    def name(self):
        if self._mesh == NULL:
            return "None"
        return to_py_string(self._mesh.name)

    @property
    def element_id(self):
        return self._mesh.element_id

    @property
    def typed_id(self):
        return self._mesh.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._mesh.props)

    # Simple properties
    @property
    def num_vertices(self):
        return self._mesh.num_vertices

    @property
    def num_indices(self):
        return self._mesh.num_indices

    @property
    def num_faces(self):
        return self._mesh.num_faces

    @property
    def num_triangles(self):
        return self._mesh.num_triangles

    @property
    def num_edges(self):
        return self._mesh.num_edges

    @property
    def max_face_triangles(self):
        return self._mesh.max_face_triangles

    @property
    def num_empty_faces(self):
        return self._mesh.num_empty_faces

    @property
    def num_point_faces(self):
        return self._mesh.num_point_faces

    @property
    def num_line_faces(self):
        return self._mesh.num_line_faces

    @property
    def skinned_is_local(self):
        return <bint> self._mesh.skinned_is_local

    # Complex properties - TODO
    @property
    def faces(self):
        # TODO: faces add implementation
        raise NotImplementedError("faces is not implemented yet.")

    @property
    def face_smoothing(self):
        # TODO: face_smoothing add implementation
        raise NotImplementedError("face_smoothing is not implemented yet.")

    @property
    def face_material(self):
        # TODO: face_material add implementation
        raise NotImplementedError("face_material is not implemented yet.")

    @property
    def face_group(self):
        # TODO: face_group add implementation
        raise NotImplementedError("face_group is not implemented yet.")

    @property
    def face_hole(self):
        # TODO: face_hole add implementation
        raise NotImplementedError("face_hole is not implemented yet.")

    @property
    def edges(self):
        # TODO: edges add implementation
        raise NotImplementedError("edges is not implemented yet.")

    @property
    def edge_smoothing(self):
        # TODO: edge_smoothing add implementation
        raise NotImplementedError("edge_smoothing is not implemented yet.")

    @property
    def edge_crease(self):
        # TODO: edge_crease add implementation
        raise NotImplementedError("edge_crease is not implemented yet.")

    @property
    def edge_visibility(self):
        # TODO: edge_visibility add implementation
        raise NotImplementedError("edge_visibility is not implemented yet.")

    @property
    def vertex_indices(self):
        # TODO: vertex_indices add implementation
        raise NotImplementedError("vertex_indices is not implemented yet.")

    @property
    def vertices(self):
        # TODO: vertices add implementation
        raise NotImplementedError("vertices is not implemented yet.")

    @property
    def vertex_first_index(self):
        # TODO: vertex_first_index add implementation
        raise NotImplementedError("vertex_first_index is not implemented yet.")

    @property
    def vertex_position(self):
        # TODO: vertex_position add implementation
        raise NotImplementedError("vertex_position is not implemented yet.")

    @property
    def vertex_normal(self):
        # TODO: vertex_normal add implementation
        raise NotImplementedError("vertex_normal is not implemented yet.")

    @property
    def vertex_uv(self):
        # TODO: vertex_uv add implementation
        raise NotImplementedError("vertex_uv is not implemented yet.")

    @property
    def vertex_tangent(self):
        # TODO: vertex_tangent add implementation
        raise NotImplementedError("vertex_tangent is not implemented yet.")

    @property
    def vertex_bitangent(self):
        # TODO: vertex_bitangent add implementation
        raise NotImplementedError("vertex_bitangent is not implemented yet.")

    @property
    def vertex_color(self):
        # TODO: vertex_color add implementation
        raise NotImplementedError("vertex_color is not implemented yet.")

    @property
    def vertex_crease(self):
        # TODO: vertex_crease add implementation
        raise NotImplementedError("vertex_crease is not implemented yet.")

    @property
    def uv_sets(self):
        # TODO: uv_sets add implementation
        raise NotImplementedError("uv_sets is not implemented yet.")

    @property
    def color_sets(self):
        # TODO: color_sets add implementation
        raise NotImplementedError("color_sets is not implemented yet.")

    @property
    def materials(self):
        # TODO: materials add implementation
        raise NotImplementedError("materials is not implemented yet.")

    @property
    def face_groups(self):
        # TODO: face_groups add implementation
        raise NotImplementedError("face_groups is not implemented yet.")

    @property
    def material_parts(self):
        # TODO: material_parts add implementation
        raise NotImplementedError("material_parts is not implemented yet.")

    @property
    def face_group_parts(self):
        # TODO: face_group_parts add implementation
        raise NotImplementedError("face_group_parts is not implemented yet.")

    @property
    def material_part_usage_order(self):
        # TODO: material_part_usage_order add implementation
        raise NotImplementedError("material_part_usage_order is not implemented yet.")

    @property
    def skinned_position(self):
        # TODO: skinned_position add implementation
        raise NotImplementedError("skinned_position is not implemented yet.")

    @property
    def skinned_normal(self):
        # TODO: skinned_normal add implementation
        raise NotImplementedError("skinned_normal is not implemented yet.")

    @property
    def skin_deformers(self):
        # TODO: skin_deformers add implementation
        raise NotImplementedError("skin_deformers is not implemented yet.")

    @property
    def blend_deformers(self):
        # TODO: blend_deformers add implementation
        raise NotImplementedError("blend_deformers is not implemented yet.")

    @property
    def cache_deformers(self):
        # TODO: cache_deformers add implementation
        raise NotImplementedError("cache_deformers is not implemented yet.")

    @property
    def all_deformers(self):
        # TODO: all_deformers add implementation
        raise NotImplementedError("all_deformers is not implemented yet.")
