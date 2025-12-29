from enum import IntEnum


class Interpolation(IntEnum):
    """Enum representing ufbx interpolation types."""

    def __str__(self):
        return self.name

    def __repr__(self):
        return f"Interpolation.{self.name}"

    UFBX_INTERPOLATION_CONSTANT_PREV = 0

    UFBX_INTERPOLATION_CONSTANT_NEXT = 1

    UFBX_INTERPOLATION_LINEAR = 2

    UFBX_INTERPOLATION_CUBIC = 3

    UFBX_INTERPOLATION_COUNT = 4
