"""
Example 02: Bake animation and read rotation keyframes as quaternions.

After bake_anim(), each node's rotation_keys is a structured numpy array:
    dtype: [('time', float64), ('value', {'x','y','z','w'}), ('flags', uint32)]

FBX stores Euler angles internally; bake_anim composites the full
transformation chain (pre/post rotations, pivots, rotation order) into
a single unit quaternion per keyframe — no manual Euler→Quat needed.
"""
import pyufbx

scene = pyufbx.load_fbx("tests/fixtures/drunk_idle_turn_360_R_001.fbx")
anim = scene.anim_stacks[0].anim

baked = pyufbx.bake_anim(scene, anim, resample_rate=30.0)

print(f"Baked {len(baked.modified_nodes)} nodes")
print(f"Duration: {baked.playback_duration:.3f}s\n")

for node in baked.modified_nodes:
    r = node.rotation_keys          # structured numpy array
    times = r["time"]               # shape (N,)
    quats = r["value"]              # structured: .x .y .z .w

    scene_node = scene.nodes[node.typed_id]
    print(f"{scene_node.name}: {len(r)} rotation keyframes")
    print(f"  first:  t={times[0]:.4f}s  quat=({quats['x'][0]:.4f}, {quats['y'][0]:.4f}, {quats['z'][0]:.4f}, {quats['w'][0]:.4f})")
    print(f"  last:   t={times[-1]:.4f}s  quat=({quats['x'][-1]:.4f}, {quats['y'][-1]:.4f}, {quats['z'][-1]:.4f}, {quats['w'][-1]:.4f})")
