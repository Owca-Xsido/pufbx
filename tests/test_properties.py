import pytest

import pyufbx as fbx

# Mock classes to simulate C struct behavior


@pytest.fixture
def cube_scene():
    # Assuming you have a load function
    return fbx.load_fbx("tests/fixtures/cube_and_bone.fbx")


@pytest.fixture
def prop(cube_scene):
    root = cube_scene.root_node
    first_child = root.children[0]
    return first_child.properties[0]


def props(cube_scene):
    root = cube_scene.root_node
    first_child = root.children[0]
    return first_child.properties


def test_property_name(prop):
    """Test property name retrieval."""
    assert isinstance(prop.name, str)
    assert prop.name != ""


def test_propery_type(prop):
    """Test property value retrieval."""
    assert prop.prop_type is not None
    assert isinstance(prop.prop_type, fbx.PropType)
    assert prop.prop_type.name != ""


def test_property_flags(prop):
    """Test property flags retrieval."""
    assert prop.flags is not None
    assert isinstance(prop.flags, fbx.PropFlags)


def test_property_value_string(prop):
    """Test property value retrieval as string."""
    print(f"Property Value String: {prop.value}")
    assert isinstance(prop.value, str)
    assert prop.value != ""


def test_property_value_int(prop):
    """Test property value retrieval as int."""
    value = prop.value
    assert isinstance(value, int)
