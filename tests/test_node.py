import pytest

import pyufbx as fbx
from pyufbx.core.math_types import Vec3Property


@pytest.fixture
def cube_scene():
    # Assuming you have a load function
    return fbx.load_fbx("tests/fixtures/cube_and_bone.fbx")


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
    """Test navigating to the cube node."""
    root = cube_scene.root_node

    cube_node = None
    root_node_len = len(root)
    all_nodes_count = cube_scene.num_nodes
    all_nodes = cube_scene.nodes

    for node in root:  # Using __iter__
        if node.name == "cube_1":
            cube_node = node
            break

    assert all_nodes is not None
    assert all_nodes_count == 22
    assert root_node_len == 2
    assert cube_node is not None
    assert cube_node.name == "cube_1"
    assert cube_node.node_depth == 1


def test_node_attributes(cube_scene):
    """Test name, representation, and type."""
    # Find the specific node named "Cube"
    # (assuming you implement a find method or just iterate)
    cube_node = None
    for node in cube_scene.root_node:  # Using __iter__
        if node.name == "cube_1":
            cube_node = node
            break

    assert cube_node is not None
    assert "cube_1" in repr(cube_node)  # Test __repr__
    assert cube_node.is_visible is True




def test_missing_optional_components(cube_scene):
    """Test safety when C pointers are NULL (e.g. Bone)."""
    root = cube_scene.root_node

    # The root node is usually NOT a bone
    assert root.bone is None

    # If the node has no specific attribute
    # assert root.attrib is None # Depends on your specific file


def test_not_implemented_features(cube_scene):
    """Test that placeholders raise errors correctly."""
    root = cube_scene.root_node

    with pytest.raises(NotImplementedError):
        _ = root.geometry_transform_helper
