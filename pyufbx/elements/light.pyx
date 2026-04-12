# cython: language_level=3
from pyufbx.pyufbx cimport ufbx_light

from ..core.math_types cimport Vec3Property
from ..generated.lists cimport NodeList
from ..props.prop cimport PropsWrapper
from .element cimport Element

include "../core/strings.pxi"


cdef class Light:
    """Represents a light in the FBX structure."""

    def __cinit__(self):
        self._light = NULL

    def __repr__(self):
        if self._light == NULL:
            return "<Light None>"
        return f"<Light name='{self.name}'>"

    @property
    def name(self):
        if self._light == NULL:
            return "None"
        return to_py_string(self._light.name)

    @property
    def element_id(self):
        return self._light.element_id

    @property
    def typed_id(self):
        return self._light.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._light.props)

    # Simple properties
    @property
    def color(self):
        return Vec3Property(
            self._light.color.x,
            self._light.color.y,
            self._light.color.z
        )

    @property
    def intensity(self):
        return self._light.intensity

    @property
    def local_direction(self):
        return Vec3Property(
            self._light.local_direction.x,
            self._light.local_direction.y,
            self._light.local_direction.z
        )

    @property
    def light_type(self):
        # TODO: Create LightType enum if needed
        return <int> self._light.type

    @property
    def decay(self):
        # TODO: Create LightDecay enum if needed
        return <int> self._light.decay

    @property
    def area_shape(self):
        # TODO: Create LightAreaShape enum if needed
        return <int> self._light.area_shape

    @property
    def inner_angle(self):
        return self._light.inner_angle

    @property
    def outer_angle(self):
        return self._light.outer_angle

    @property
    def cast_light(self):
        return <bint> self._light.cast_light

    @property
    def cast_shadows(self):
        return <bint> self._light.cast_shadows

    @property
    def instances(self):
        return NodeList.create(self._light.instances.data, self._light.instances.count)

