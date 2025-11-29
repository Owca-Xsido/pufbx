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


@pytest.fixture
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


def test_property_value(props):
    """Test property value retrieval."""
    for prop in props:
        value = prop.value
        print(f" - {prop.name} ({prop.prop_type}): {value}")
        if prop.prop_type == fbx.PropType.UFBX_PROP_INTEGER:
            value = prop.value
            assert isinstance(value, int)

        assert value is not None

