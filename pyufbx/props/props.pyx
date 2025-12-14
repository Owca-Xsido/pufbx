from pyufbx.pyufbx cimport *

from ..core.transform cimport Transform
from ..elements.bone cimport Bone
from ..elements.element cimport Element
from ..elements.node cimport Node

from ..enums.property_types import PropFlags, PropType

include "../core/math_types.pxi"
include "../core/strings.pxi"
include "../generated/generated_wrappers.pxi"

cdef class PropsWrapper:

    @staticmethod
    cdef PropsWrapper create(ufbx_props *props):
        cdef PropsWrapper obj = PropsWrapper.__new__(PropsWrapper)
        obj._props = props
        return obj

    def __len__(self):
        return self._props.props.count

    @property
    def num_animated(self):
        return self._props.num_animated

    @property
    def defaults(self):
        if self._props.defaults != NULL:
            return PropsWrapper.create(self._props.defaults)
        return None

    def __getitem__(self, idx):
        if idx < 0:
            idx += self._props.props.count
        if idx < 0 or idx >= self._props.props.count:
            raise IndexError("Index out of range")
        return wrap_prop(&self._props.props.data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._props.props.count):
            yield wrap_prop(&self._props.props.data[i])


cdef class Prop:


    def __str__(self):
        return self.name

    def __repr__(self):
        return f"<Name='{self.name}'>"

    @property
    def name(self):

        return to_py_string(self._prop.name)

    @property
    def prop_type(self):
        """Returns prop type Class"""
        return PropType(<int>self._prop.type)

    @property
    def flags(self):
        return PropFlags(<int>self._prop.flags)

    @property
    def value_as_float(self):
        """Always get numeric value as float (works for int, bool, number types)."""
        return <double> self._prop.value_real

    @property
    def value_as_int(self):
        """Always get numeric value as int (works for int, bool, number types)."""
        return <int> self._prop.value_int

    @property
    def value(self):
        """Return the property value in the appropriate Python type."""
        ptype = self.prop_type

        # String types
        if ptype == PropType.STRING:
            return to_py_string(self._prop.value_str)

        # Numeric types
        elif ptype == PropType.BOOLEAN:
            return <bint> self._prop.value_int

        elif ptype == PropType.INTEGER:
            return <int> self._prop.value_int

        elif ptype == PropType.NUMBER:
            return <double> self._prop.value_real

        # Vector types
        elif ptype == PropType.VECTOR:
            return Vec3Property(
                self._prop.value_vec3.x,
                self._prop.value_vec3.y,
                self._prop.value_vec3.z
            )

        elif ptype == PropType.COLOR:
            return Vec3Property(
                self._prop.value_vec3.x,
                self._prop.value_vec3.y,
                self._prop.value_vec3.z)

        elif ptype == PropType.COLOR_WITH_ALPHA:
            return Vec4Property(self._prop.value_vec4.x,
                                self._prop.value_vec4.y,
                                self._prop.value_vec4.z,
                                self._prop.value_vec4.w)

        elif ptype == PropType.TRANSLATION:
            return Vec3Property(
                self._prop.value_vec3.x,
                self._prop.value_vec3.y,
                self._prop.value_vec3.z
            )

        elif ptype == PropType.ROTATION:
            return Vec3Property(
                self._prop.value_vec3.x,
                self._prop.value_vec3.y,
                self._prop.value_vec3.z
            )

        elif ptype == PropType.SCALING:
            return Vec3Property(
                self._prop.value_vec3.x,
                self._prop.value_vec3.y,
                self._prop.value_vec3.z
            )
        # # Blob/binary data
        elif ptype == PropType.BLOB:
            return blob_to_bytes(self._prop.value_blob)

        # Fallback for unknown types
        else:
            return None