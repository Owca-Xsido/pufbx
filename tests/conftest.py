import pytest

import pyufbx as fbx


@pytest.fixture
def cube_scene():
    """Load the cube and bone FBX scene."""
    return fbx.load_fbx("tests/fixtures/cube_and_bone.fbx")


@pytest.fixture
def cube_1(cube_scene):
    """Get the first child node (cube) from the scene."""
    root = cube_scene.root_node
    return root.children[0]


@pytest.fixture
def all_nodes(cube_scene):
    """Get all nodes from the scene."""
    return cube_scene.nodes
