"""
Example 03: Export animation to a dense numpy array.

anim_to_array() returns:
    data        float64 array of shape (num_nodes, num_frames, 10)
                columns: [tx, ty, tz, rx, ry, rz, rw, sx, sy, sz]
    times       float64 array of shape (num_frames,)  — seconds
    node_names  list of node name strings

Rotation columns 3-6 are quaternion components (x, y, z, w).
"""
import numpy as np
import pyufbx

data, times, node_names = pyufbx.anim_to_array(
    "samples/drunk_idle_turn_360_R_001.fbx",
    anim_index=0,
    resample_rate=30.0,
)

print(f"Shape: {data.shape}  → ({len(node_names)} nodes, {len(times)} frames, 10 channels)")
print(f"Duration: {times[-1]:.3f}s  frame step: {times[1]-times[0]:.4f}s\n")

# Slice out just the rotation quaternions for every node
rotations = data[:, :, 3:7]   # shape (num_nodes, num_frames, 4)  — x y z w

for i, name in enumerate(node_names):
    q = rotations[i]
    magnitudes = np.linalg.norm(q, axis=-1)
    print(f"{name}: rot range w=[{q[:,3].min():.3f}, {q[:,3].max():.3f}]  "
          f"|q| mean={magnitudes.mean():.6f}")
