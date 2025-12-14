import numpy as np

from pyufbx.core.transform import Vec3Property


def test_vec3_init():
    """Test Vec3Property initialization."""
    v = Vec3Property(1.0, 2.0, 3.0)
    x, y, z = v
    assert x == 1.0
    assert y == 2.0
    assert z == 3.0


def test_vec3_as_list():
    """Test conversion to list."""
    v = Vec3Property(1.5, 2.5, 3.5)
    result = v.as_list()
    assert result == [1.5, 2.5, 3.5]
    assert isinstance(result, list)


def test_vec3_as_tuple():
    """Test conversion to tuple."""
    v = Vec3Property(1.0, 2.0, 3.0)
    result = v.as_tuple()
    assert result == (1.0, 2.0, 3.0)
    assert isinstance(result, tuple)


def test_vec3_as_array():
    """Test conversion to numpy array."""
    v = Vec3Property(1.0, 2.0, 3.0)
    result = v.as_array()
    assert isinstance(result, np.ndarray)
    assert result.dtype == np.float64
    assert np.allclose(result, [1.0, 2.0, 3.0])


def test_vec3_repr():
    """Test string representation."""
    v = Vec3Property(1.0, 2.0, 3.0)
    assert repr(v) == "Vec3(1.0, 2.0, 3.0)"


def test_vec3_iter():
    """Test iteration/unpacking."""
    v = Vec3Property(4.0, 5.0, 6.0)
    x, y, z = v
    assert x == 4.0
    assert y == 5.0
    assert z == 6.0


def test_vec3_iter_to_list():
    """Test converting iterator to list."""
    v = Vec3Property(7.0, 8.0, 9.0)
    result = list(v)
    assert result == [7.0, 8.0, 9.0]


def test_vec3_negative_values():
    """Test with negative values."""
    v = Vec3Property(-1.5, -2.5, -3.5)
    assert v.as_list() == [-1.5, -2.5, -3.5]
    assert v.as_tuple() == (-1.5, -2.5, -3.5)


def test_vec3_zero_values():
    """Test with zero values."""
    v = Vec3Property(0.0, 0.0, 0.0)
    assert v.as_list() == [0.0, 0.0, 0.0]
    x, y, z = v
    assert x == y == z == 0.0
