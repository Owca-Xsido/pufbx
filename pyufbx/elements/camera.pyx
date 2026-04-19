# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_camera

from ..core.math_types cimport Vec2Property
from ..generated.lists cimport NodeList
from ..props.prop cimport PropsWrapper
from .element cimport Element

include "../core/strings.pxi"


cdef class Camera:
    """Represents a camera in the FBX structure."""

    def __cinit__(self):
        self._camera = NULL

    def __repr__(self):
        if self._camera == NULL:
            return "<Camera None>"
        return f"<Camera name='{self.name}'>"

    @property
    def name(self):
        if self._camera == NULL:
            return "None"
        return to_py_string(self._camera.name)

    @property
    def element_id(self):
        return self._camera.element_id

    @property
    def typed_id(self):
        return self._camera.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._camera.props)

    # Simple properties
    @property
    def projection_mode(self):
        # TODO: Create ProjectionMode enum if needed
        return <int> self._camera.projection_mode

    @property
    def resolution_is_pixels(self):
        return <bint> self._camera.resolution_is_pixels

    @property
    def resolution(self):
        return Vec2Property(
            self._camera.resolution.x,
            self._camera.resolution.y
        )

    @property
    def field_of_view_deg(self):
        return Vec2Property(
            self._camera.field_of_view_deg.x,
            self._camera.field_of_view_deg.y
        )

    @property
    def field_of_view_tan(self):
        return Vec2Property(
            self._camera.field_of_view_tan.x,
            self._camera.field_of_view_tan.y
        )

    @property
    def orthographic_extent(self):
        return self._camera.orthographic_extent

    @property
    def orthographic_size(self):
        return Vec2Property(
            self._camera.orthographic_size.x,
            self._camera.orthographic_size.y
        )

    @property
    def projection_plane(self):
        return Vec2Property(
            self._camera.projection_plane.x,
            self._camera.projection_plane.y
        )

    @property
    def aspect_ratio(self):
        return self._camera.aspect_ratio

    @property
    def near_plane(self):
        return self._camera.near_plane

    @property
    def far_plane(self):
        return self._camera.far_plane

    @property
    def aspect_mode(self):
        # TODO: Create AspectMode enum if needed
        return <int> self._camera.aspect_mode

    @property
    def aperture_mode(self):
        # TODO: Create ApertureMode enum if needed
        return <int> self._camera.aperture_mode

    @property
    def gate_fit(self):
        # TODO: Create GateFit enum if needed
        return <int> self._camera.gate_fit

    @property
    def aperture_format(self):
        # TODO: Create ApertureFormat enum if needed
        return <int> self._camera.aperture_format

    @property
    def focal_length_mm(self):
        return self._camera.focal_length_mm

    @property
    def film_size_inch(self):
        return Vec2Property(
            self._camera.film_size_inch.x,
            self._camera.film_size_inch.y
        )

    @property
    def aperture_size_inch(self):
        return Vec2Property(
            self._camera.aperture_size_inch.x,
            self._camera.aperture_size_inch.y
        )

    @property
    def squeeze_ratio(self):
        return self._camera.squeeze_ratio

    @property
    def instances(self):
        return NodeList.create(self._camera.instances.data, self._camera.instances.count)

