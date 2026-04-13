"""
Example 04: Access raw animation curves (Euler angles, Bezier tangents).

Before baking, FBX stores rotation as three separate Euler-angle curves
(one per axis: X, Y, Z). Each curve has keyframes with Bezier tangent handles.

Use this when you need the original authored keyframe data rather than
the resampled quaternion output from bake_anim().
"""
import pyufbx

scene = pyufbx.load_fbx("tests/fixtures/drunk_idle_turn_360_R_001.fbx")
anim = scene.anim_stacks[0].anim

for layer in anim.layers:
    for anim_value in layer.anim_values:
        curves = anim_value.curves  # up to 3: X, Y, Z

        active = [c for c in curves if c is not None]
        if not active:
            continue

        print(f"AnimValue — {len(active)} curve(s), first curve: {len(active[0].get_keyframes())} keyframes")

        curve = active[0]
        keyframes = curve.get_keyframes()  # structured numpy array

        if len(keyframes) == 0:
            continue

        k0 = keyframes[0]
        print(f"  keyframe[0]: time={k0['time']:.4f}s  value={k0['value']:.4f}  "
              f"interp={k0['interpolation']}  "
              f"left=({k0['left']['dx']:.4f}, {k0['left']['dy']:.4f})  "
              f"right=({k0['right']['dx']:.4f}, {k0['right']['dy']:.4f})")
        break  # just show first anim_value for brevity
