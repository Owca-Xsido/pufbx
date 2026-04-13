import numpy as np
import pytest

import pyufbx as fbx
from pyufbx.core.math_types import Vec3Property


@pytest.fixture
def cube_scene():
    """Load the cube and bone FBX scene with animation data."""
    return fbx.load_fbx("tests/fixtures/drunk_idle_turn_360_R_001.fbx")


@pytest.fixture
def anim_stacks(cube_scene):
    """Get all animation stacks from the scene."""
    return cube_scene.anim_stacks


@pytest.fixture
def first_anim_stack(anim_stacks):
    """Get the first animation stack if available."""
    if len(anim_stacks) > 0:
        return anim_stacks[0]
    pytest.skip("No animation stacks found in the test fixture")


# ============================================================================
# AnimCurve Tests
# ============================================================================


def test_anim_curve_basic_properties(cube_scene):
    """Test AnimCurve basic properties."""
    # Navigate through the scene to find animation curves
    anim_stacks = cube_scene.anim_stacks

    if len(anim_stacks) == 0:
        pytest.skip("No animation data in test fixture")

    # Look for animation curves in the scene
    found_curve = False
    for stack in anim_stacks:
        for layer in stack.layers:
            if len(layer.anim_values) > 0:
                anim_value = layer.anim_values[0]
                curves = anim_value.curves
                if len(curves) > 0:
                    curve = curves[0]
                    found_curve = True

                    # Test basic properties
                    assert isinstance(curve.name, str)
                    assert isinstance(curve.element_id, int)
                    assert isinstance(curve.typed_id, int)
                    assert repr(curve) is not None
                    assert "AnimCurve" in repr(curve)
                    break
        if found_curve:
            break

    if not found_curve:
        pytest.skip("No animation curves found in test fixture")


def test_anim_curve_keyframes_property(cube_scene):
    """Test AnimCurve keyframes property returns KeyframeList."""
    anim_stacks = cube_scene.anim_stacks

    if len(anim_stacks) == 0:
        pytest.skip("No animation data in test fixture")

    found_curve = False
    for stack in anim_stacks:
        for layer in stack.layers:
            if len(layer.anim_values) > 0:
                anim_value = layer.anim_values[0]
                curves = anim_value.curves
                if len(curves) > 0:
                    curve = curves[0]
                    found_curve = True

                    # Test keyframes property
                    keyframes = curve.keyframes
                    assert keyframes is not None
                    assert isinstance(keyframes, fbx.KeyframeList)
                    break
        if found_curve:
            break

    if not found_curve:
        pytest.skip("No animation curves found in test fixture")


def test_anim_curve_get_keyframes_numpy(cube_scene):
    """Test AnimCurve get_keyframes() method returns NumPy array."""
    anim_stacks = cube_scene.anim_stacks

    if len(anim_stacks) == 0:
        pytest.skip("No animation data in test fixture")

    found_curve = False
    for stack in anim_stacks:
        for layer in stack.layers:
            if len(layer.anim_values) > 0:
                anim_value = layer.anim_values[0]
                curves = anim_value.curves
                if len(curves) > 0:
                    curve = curves[0]
                    found_curve = True

                    # Test get_keyframes() method
                    keyframes_array = curve.get_keyframes()
                    assert isinstance(keyframes_array, np.ndarray)

                    # Verify dtype structure
                    assert keyframes_array.dtype.names is not None
                    assert "time" in keyframes_array.dtype.names
                    assert "value" in keyframes_array.dtype.names
                    assert "interpolation" in keyframes_array.dtype.names

                    # If there are keyframes, verify data types
                    if len(keyframes_array) > 0:
                        assert keyframes_array["time"].dtype == np.float64
                        assert keyframes_array["value"].dtype == np.float64
                        assert keyframes_array["interpolation"].dtype == np.int32
                    break
        if found_curve:
            break

    if not found_curve:
        pytest.skip("No animation curves found in test fixture")


def test_anim_curve_value_time_ranges(cube_scene):
    """Test AnimCurve min/max value and time properties."""
    anim_stacks = cube_scene.anim_stacks

    if len(anim_stacks) == 0:
        pytest.skip("No animation data in test fixture")

    found_curve = False
    for stack in anim_stacks:
        for layer in stack.layers:
            if len(layer.anim_values) > 0:
                anim_value = layer.anim_values[0]
                curves = anim_value.curves
                if len(curves) > 0:
                    curve = curves[0]
                    found_curve = True

                    # Test value ranges
                    assert isinstance(curve.min_value, (int, float))
                    assert isinstance(curve.max_value, (int, float))
                    assert curve.min_value <= curve.max_value

                    # Test time ranges
                    assert isinstance(curve.min_time, (int, float))
                    assert isinstance(curve.max_time, (int, float))
                    assert curve.min_time <= curve.max_time
                    break
        if found_curve:
            break

    if not found_curve:
        pytest.skip("No animation curves found in test fixture")


def test_anim_curve_extrapolation_not_implemented(cube_scene):
    """Test that extrapolation methods raise NotImplementedError."""
    anim_stacks = cube_scene.anim_stacks

    if len(anim_stacks) == 0:
        pytest.skip("No animation data in test fixture")

    found_curve = False
    for stack in anim_stacks:
        for layer in stack.layers:
            if len(layer.anim_values) > 0:
                anim_value = layer.anim_values[0]
                curves = anim_value.curves
                if len(curves) > 0:
                    curve = curves[0]
                    found_curve = True

                    # Test pre_extrapolation raises NotImplementedError
                    with pytest.raises(NotImplementedError):
                        _ = curve.pre_extrapolation

                    # Test post_extrapolation raises NotImplementedError
                    with pytest.raises(NotImplementedError):
                        _ = curve.post_extrapolation
                    break
        if found_curve:
            break

    if not found_curve:
        pytest.skip("No animation curves found in test fixture")


# ============================================================================
# AnimValue Tests
# ============================================================================


def test_anim_value_basic_properties(cube_scene):
    """Test AnimValue basic properties."""
    anim_stacks = cube_scene.anim_stacks

    if len(anim_stacks) == 0:
        pytest.skip("No animation data in test fixture")

    found_value = False
    for stack in anim_stacks:
        for layer in stack.layers:
            if len(layer.anim_values) > 0:
                anim_value = layer.anim_values[0]
                found_value = True

                # Test basic properties
                assert isinstance(anim_value.name, str)
                assert isinstance(anim_value.element_id, int)
                assert isinstance(anim_value.typed_id, int)
                assert repr(anim_value) is not None
                assert "AnimValue" in repr(anim_value)
                break
        if found_value:
            break

    if not found_value:
        pytest.skip("No animation values found in test fixture")


def test_anim_value_default_value(cube_scene):
    """Test AnimValue default_value returns Vec3Property."""
    anim_stacks = cube_scene.anim_stacks

    if len(anim_stacks) == 0:
        pytest.skip("No animation data in test fixture")

    found_value = False
    for stack in anim_stacks:
        for layer in stack.layers:
            if len(layer.anim_values) > 0:
                anim_value = layer.anim_values[0]
                found_value = True

                # Test default_value
                default = anim_value.default_value
                assert isinstance(default, Vec3Property)
                assert len(default) == 3
                break
        if found_value:
            break

    if not found_value:
        pytest.skip("No animation values found in test fixture")


def test_anim_value_curves(cube_scene):
    """Test AnimValue curves property returns AnimCurveList."""
    anim_stacks = cube_scene.anim_stacks

    if len(anim_stacks) == 0:
        pytest.skip("No animation data in test fixture")

    found_value = False
    for stack in anim_stacks:
        for layer in stack.layers:
            if len(layer.anim_values) > 0:
                anim_value = layer.anim_values[0]
                found_value = True

                # Test curves property
                curves = anim_value.curves
                assert curves is not None
                assert isinstance(curves, fbx.AnimCurveList)
                assert len(curves) == 3  # X, Y, Z components
                break
        if found_value:
            break

    if not found_value:
        pytest.skip("No animation values found in test fixture")


def test_anim_value_properties_wrapper(cube_scene):
    """Test AnimValue properties returns PropsWrapper."""
    anim_stacks = cube_scene.anim_stacks

    if len(anim_stacks) == 0:
        pytest.skip("No animation data in test fixture")

    found_value = False
    for stack in anim_stacks:
        for layer in stack.layers:
            if len(layer.anim_values) > 0:
                anim_value = layer.anim_values[0]
                found_value = True

                # Test properties
                props = anim_value.properties
                assert isinstance(props, fbx.PropsWrapper)
                break
        if found_value:
            break

    if not found_value:
        pytest.skip("No animation values found in test fixture")


# ============================================================================
# Anim Tests
# ============================================================================


def test_anim_time_boundaries(cube_scene):
    """Test Anim time_begin and time_end properties."""
    anim_stacks = cube_scene.anim_stacks

    if len(anim_stacks) == 0:
        pytest.skip("No animation data in test fixture")

    found_anim = False
    for stack in anim_stacks:
        for layer in stack.layers:
            anim = layer.anim
            if anim is not None:
                found_anim = True

                # Test time boundaries
                assert isinstance(anim.time_begin, (int, float))
                assert isinstance(anim.time_end, (int, float))
                assert anim.time_begin <= anim.time_end
                break
        if found_anim:
            break

    if not found_anim:
        pytest.skip("No anim objects found in test fixture")


def test_anim_boolean_flags(cube_scene):
    """Test Anim boolean flags."""
    anim_stacks = cube_scene.anim_stacks

    if len(anim_stacks) == 0:
        pytest.skip("No animation data in test fixture")

    found_anim = False
    for stack in anim_stacks:
        for layer in stack.layers:
            anim = layer.anim
            if anim is not None:
                found_anim = True

                # Test boolean flags
                assert isinstance(anim.ignore_connections, bool)
                assert isinstance(anim.custom, bool)
                break
        if found_anim:
            break

    if not found_anim:
        pytest.skip("No anim objects found in test fixture")


def test_anim_layers(cube_scene):
    """Test that Anim.layers returns an AnimLayerList."""
    from pyufbx.generated.lists import AnimLayerList

    anim_stacks = cube_scene.anim_stacks

    if len(anim_stacks) == 0:
        pytest.skip("No animation data in test fixture")

    found_anim = False
    for stack in anim_stacks:
        for layer in stack.layers:
            anim = layer.anim
            if anim is not None:
                found_anim = True
                assert isinstance(anim.layers, AnimLayerList)
                break
        if found_anim:
            break

    if not found_anim:
        pytest.skip("No anim objects found in test fixture")
