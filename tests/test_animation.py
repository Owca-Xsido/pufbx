import pytest

import pyufbx as fbx


def test_anim_start_end(cube_scene):
    anim = cube_scene.anim
    assert anim.time_begin == 0.0
    assert anim.time_end == 10.0
