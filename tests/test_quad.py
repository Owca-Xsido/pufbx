# cython: language_level=3
import numpy as np

from pufbx.core.math_types import QuatProperty


def test_quat_init():
    """Test QuatProperty initialization."""
    quat = QuatProperty(1.0, 2.0, 3.0, 4.0)
    x, y, z, w = quat
    assert x == 1.0
    assert y == 2.0
    assert z == 3.0
    assert w == 4.0


def test_quat_as_list():
    """Test QuatProperty.as_list() conversion."""
    quat = QuatProperty(0.5, 0.5, 0.5, 0.5)
    result = quat.as_list()
    assert result == [0.5, 0.5, 0.5, 0.5]
    assert isinstance(result, list)


def test_quat_as_tuple():
    """Test QuatProperty.as_tuple() conversion."""
    quat = QuatProperty(1.0, 0.0, 0.0, 0.0)
    result = quat.as_tuple()
    assert result == (1.0, 0.0, 0.0, 0.0)
    assert isinstance(result, tuple)


def test_quat_as_array():
    """Test QuatProperty.as_array() conversion to numpy array."""
    quat = QuatProperty(0.1, 0.2, 0.3, 0.4)
    result = quat.as_array()
    assert isinstance(result, np.ndarray)
    assert result.dtype == np.float64
    assert np.allclose(result, [0.1, 0.2, 0.3, 0.4])


def test_quat_repr():
    """Test QuatProperty string representation."""
    quat = QuatProperty(1.5, 2.5, 3.5, 4.5)
    repr_str = repr(quat)
    assert "Quat" in repr_str
    assert "1.5" in repr_str
    assert "4.5" in repr_str


def test_quat_iter():
    """Test QuatProperty iteration/unpacking."""
    quat = QuatProperty(10.0, 20.0, 30.0, 40.0)
    x, y, z, w = quat
    assert x == 10.0
    assert y == 20.0
    assert z == 30.0
    assert w == 40.0


def test_quat_iter_to_list():
    """Test converting QuatProperty to list via iteration."""
    quat = QuatProperty(5.0, 6.0, 7.0, 8.0)
    result = list(quat)
    assert result == [5.0, 6.0, 7.0, 8.0]


def test_quat_zero():
    """Test QuatProperty with zero values."""
    quat = QuatProperty(0.0, 0.0, 0.0, 0.0)
    assert quat.as_list() == [0.0, 0.0, 0.0, 0.0]
    assert quat.as_array().sum() == 0.0


def test_quat_negative_values():
    """Test QuatProperty with negative values."""
    quat = QuatProperty(-1.0, -2.0, -3.0, -4.0)
    assert quat.as_tuple() == (-1.0, -2.0, -3.0, -4.0)
    assert np.allclose(quat.as_array(), [-1.0, -2.0, -3.0, -4.0])
