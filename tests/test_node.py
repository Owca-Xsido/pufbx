import pytest

import pyufbx as fbx  # Replace with your actual module name


@pytest.fixture
def cube_scene():
    # Assuming you have a load function
    return fbx.load_fbx("tests/fixtures/cube_and_bone.fbx")


@pytest.fixture()
def cube_1(cube_scene):
    root = cube_scene.root_node
    return root.children[0]


def test_root_node_properties(cube_scene):
    """Test the root node basics."""
    root = cube_scene.root_node

    assert isinstance(root, fbx.Node)
    assert root.is_root is True
    # FBX root usually has specific ID/Name conventions
    assert root.id is not None
    assert root.parent is None


def test_lcl_values(cube_1):
    assert isinstance(cube_1.lcl_translation, fbx.Vec3Property)
    assert isinstance(cube_1.lcl_rotation, fbx.Vec3Property)
    assert isinstance(cube_1.lcl_scale, fbx.Vec3Property)


def test_node_hierarchy_navigation(cube_scene):
    """Test parent/child relationships."""
    root = cube_scene.root_node

    # Assert we can read children
    assert len(root) > 0  # Using __len__

    # Get the first child
    child = root.children[0]

    assert isinstance(child, fbx.Node)
    assert child.parent.id == root.id  # Verify referential integrity
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


def test_element_access(cube_scene):
    """Test the 'element' property wrapper."""
    root = cube_scene.root_node

    # The root node usually has an element type
    element = root.element
    assert element is not None
    # Assuming Element class has a property 'type'
    assert element.element_type is not None


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
