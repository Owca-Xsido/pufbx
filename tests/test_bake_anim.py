"""
Regression tests for bake_anim / anim_to_array.

The key regression being guarded: if ufbx.c is compiled into more than one
extension module, ufbx's interned string pointers differ between modules and
bake_anim silently returns 2 identity-quaternion keyframes instead of real data.
"""
import pathlib

import numpy as np
import pytest
import pyufbx

SAMPLE_FBX = str(pathlib.Path(__file__).parent / "fixtures" / "drunk_idle_turn_360_R_001.fbx")


@pytest.fixture(scope="module")
def baked():
    scene = pyufbx.load_fbx(SAMPLE_FBX)
    anim = scene.anim_stacks[0].anim
    return pyufbx.bake_anim(scene, anim)


def test_bake_returns_many_keyframes(baked):
    """Guard against the duplicate-ufbx.c linker bug that produces 2 fallback keyframes."""
    nodes = baked.modified_nodes
    assert len(nodes) > 0
    rot = nodes[0].rotation_keys
    assert len(rot) > 2, (
        f"Got {len(rot)} rotation keyframes — expected >2. "
        "This usually means ufbx.c is compiled into multiple extension modules, "
        "breaking ufbx's internal string interning. See setup.py NEEDS_UFBX_C."
    )


def test_rotation_keys_not_identity(baked):
    """Keyframes must contain real rotation data, not identity quaternions."""
    rot = baked.modified_nodes[0].rotation_keys
    w = rot["value"]["w"]
    # Identity quaternion has w=1.0 for all frames
    assert not np.allclose(w, 1.0), "All rotation keys are identity — animation data is missing."


def test_translation_keys_shape(baked):
    node = baked.modified_nodes[0]
    t = node.translation_keys
    assert t.dtype.names == ("time", "value", "flags")
    assert len(t) > 2


def test_scale_keys_shape(baked):
    node = baked.modified_nodes[0]
    s = node.scale_keys
    assert s.dtype.names == ("time", "value", "flags")
    assert len(s) > 0


def test_anim_to_array_shape():
    data, times, names = pyufbx.anim_to_array(SAMPLE_FBX)
    assert data.ndim == 3
    assert data.shape[2] == 10  # tx ty tz rx ry rz rw sx sy sz
    assert data.shape[0] == len(names)
    assert data.shape[1] == len(times)
    assert data.shape[1] > 2


def test_anim_to_array_not_identity():
    data, times, names = pyufbx.anim_to_array(SAMPLE_FBX)
    # rx ry rz should not all be zero
    assert not np.allclose(data[:, :, 3:6], 0.0)
