import pytest

import pyufbx as fbx
from pyufbx.core.math_types import Vec3Property


@pytest.fixture
def cube_scene():
    # Assuming you have a load function
    return fbx.load_fbx("tests/fixtures/drunk_idle_turn_360_R_001.fbx")


@pytest.fixture()
def cube_1(cube_scene):
    root = cube_scene.root_node
    return root.children[0]


@pytest.fixture()
def all_nodes(cube_scene):
    return cube_scene.nodes


def test_all_nodes_in_scene(all_nodes):
    for node in all_nodes:
        assert repr(node) is not None
        assert isinstance(str(node), str)
        assert isinstance(node.name, str)
        assert isinstance(node.element_id, int)
        assert isinstance(node.typed_id, int)
        assert isinstance(node.properties, fbx.PropsWrapper)
        if not node.is_root:
            assert node.parent is not None
        assert node.num_children is not None
        if node.num_children != 0:
            assert isinstance(node.children, fbx.NodeList)
        assert isinstance(node.all_attribs, fbx.ElementList)
        assert isinstance(node.inherit_mode, fbx.InheritMode)

        assert isinstance(node.original_inherit_mode, fbx.InheritMode)
        assert isinstance(node.local_transform, fbx.Transform)
        assert isinstance(node.geometry_transform, fbx.Transform)
        assert isinstance(node.inherit_scale, Vec3Property)
        # assert isinstance(node.inherit_scale_node, fbx.Node)


def test_transform(all_nodes):
    for node in all_nodes:
        transform = node.local_transform
        translation = transform.translation
        rotation = transform.rotation
        scale = transform.scale

        assert isinstance(translation, Vec3Property)
        assert isinstance(rotation, fbx.QuatProperty)
        assert isinstance(scale, Vec3Property)


def test_root_node_properties(cube_scene):
    """Test the root node basics."""
    root = cube_scene.root_node

    assert isinstance(root, fbx.Node)
    assert root.is_root is True
    # FBX root usually has specific ID/Name conventions
    assert root.element_id is not None
    assert root.parent is None
    assert root.typed_id is not None


def test_lcl_values(cube_1):
    assert isinstance(cube_1.lcl_translation, Vec3Property)
    assert isinstance(cube_1.lcl_rotation, Vec3Property)
    assert isinstance(cube_1.lcl_scale, Vec3Property)


def test_node_hierarchy_navigation(cube_scene):
    """Test parent/child relationships."""
    root = cube_scene.root_node

    # Assert we can read children
    assert len(root) > 0  # Using __len__

    # Get the first child
    child = root.children[0]

    assert isinstance(child, fbx.Node)
    assert child.parent.element_id == root.element_id  # Verify referential integrity
    assert child.is_root is False
    assert child.node_depth == 1


def test_cube_navigation(cube_scene):
    """Test navigating the scene node tree."""
    root = cube_scene.root_node
    all_nodes = cube_scene.nodes

    assert all_nodes is not None
    assert cube_scene.num_nodes > 0
    assert len(root) > 0

    first_child = list(root)[0]
    assert first_child is not None
    assert first_child.node_depth == 1


def test_node_attributes(cube_scene):
    """Test name, representation, and type."""
    first_child = list(cube_scene.root_node)[0]

    assert first_child is not None
    assert first_child.name in repr(first_child)
    assert first_child.is_visible is True


def test_missing_optional_components(cube_scene):
    """Test safety when C pointers are NULL (e.g. Bone)."""
    root = cube_scene.root_node

    # The root node is usually NOT a bone
    assert root.bone is None

    # If the node has no specific attribute
    # assert root.attrib is None # Depends on your specific file


def test_not_implemented_features(cube_scene):
    """geometry_transform_helper returns None when not present (not an error)."""
    root = cube_scene.root_node
    assert root.geometry_transform_helper is None
