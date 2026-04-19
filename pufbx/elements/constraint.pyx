# cython: language_level=3
from pufbx.pufbx cimport ufbx_constraint

from ..props.prop cimport PropsWrapper
from .element cimport Element

include "../core/strings.pxi"


cdef class Constraint:
    """Represents a constraint in the FBX structure."""

    def __cinit__(self):
        self._constraint = NULL

    def __repr__(self):
        if self._constraint == NULL:
            return "<Constraint None>"
        return f"<Constraint name='{self.name}'>"

    @property
    def name(self):
        if self._constraint == NULL:
            return "None"
        return to_py_string(self._constraint.name)

    @property
    def element_id(self):
        return self._constraint.element_id

    @property
    def typed_id(self):
        return self._constraint.typed_id

    @property
    def properties(self):
        return PropsWrapper.create(&self._constraint.props)

    # Simple properties
    @property
    def constraint_type(self):
        # TODO: Create ConstraintType enum if needed
        return <int> self._constraint.type

    # Complex properties - TODO
    @property
    def node(self):
        # TODO: node add implementation
        raise NotImplementedError("node is not implemented yet.")

    @property
    def targets(self):
        # TODO: targets add implementation
        raise NotImplementedError("targets is not implemented yet.")

