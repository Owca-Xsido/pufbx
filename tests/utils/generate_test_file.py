import math
import os

import bpy

# -------------------------------------------------------
# Output path
# -------------------------------------------------------
output_path = bpy.path.abspath("//tests/fixtures/cube_and_bone.fbx")

# Ensure directory exists

os.makedirs(os.path.dirname(output_path), exist_ok=True)

# -------------------------------------------------------
# Clean scene
# -------------------------------------------------------
bpy.ops.object.select_all(action="SELECT")
bpy.ops.object.delete()

# -------------------------------------------------------
# Create cube hierarchy: cube_1 -> cube_2 -> ... -> cube_10
# -------------------------------------------------------
cubes = []
parent_obj = None

for i in range(1, 11):
    bpy.ops.mesh.primitive_cube_add(size=1, location=(i * 2.0, 0, 0))
    cube = bpy.context.object
    cube.name = f"cube_{i}"

    # Parent to previous cube
    if parent_obj is not None:
        cube.parent = parent_obj

    parent_obj = cube
    cubes.append(cube)

# -------------------------------------------------------
# Animate cube chain
# -------------------------------------------------------
start_frame = 1
mid_frame = 50
end_frame = 100

for index, cube in enumerate(cubes, start=1):

    cube.rotation_mode = "XYZ"

    cube.location = (index * 2.0, 0, 0)
    cube.rotation_euler = (0, 0, 0)
    cube.scale = (1, 1, 1)
    cube.keyframe_insert("location", frame=start_frame)
    cube.keyframe_insert("rotation_euler", frame=start_frame)
    cube.keyframe_insert("scale", frame=start_frame)

    cube.location = (index * 2.0 + index * 0.3, index * 0.5, index * 0.3)
    cube.rotation_euler = (
        math.radians(index * 10),
        math.radians(index * 15),
        math.radians(index * 50),
    )
    cube.scale = (1 + index * 0.01, 1 + index * 0.01, 1 + index * 0.01)
    cube.keyframe_insert("location", frame=mid_frame)
    cube.keyframe_insert("rotation_euler", frame=mid_frame)
    cube.keyframe_insert("scale", frame=mid_frame)

    cube.location = (index * 2.0, index * 1.0, 0)
    cube.rotation_euler = (0, 0, math.radians(index * 100))
    cube.scale = (1, 1, 1)
    cube.keyframe_insert("location", frame=end_frame)
    cube.keyframe_insert("rotation_euler", frame=end_frame)
    cube.keyframe_insert("scale", frame=end_frame)

# -------------------------------------------------------
# Create armature with bone chain
# -------------------------------------------------------
bpy.ops.object.armature_add(enter_editmode=True)
arm = bpy.context.object
arm.name = "Armature"
edit_bones = arm.data.edit_bones

# Rename root bone
root = edit_bones[0]
root.name = "bone_1"
root.head = (0, 0, 0)
root.tail = (0, 0, 1)

prev = root

for i in range(2, 11):
    bone = edit_bones.new(f"bone_{i}")
    bone.head = prev.tail
    bone.tail = (bone.head[0], bone.head[1], bone.head[2] + 1)
    bone.parent = prev
    prev = bone

# Switch to pose mode
bpy.ops.object.mode_set(mode="POSE")

# -------------------------------------------------------
# Animate bone rotations
# -------------------------------------------------------
for i, pbone in enumerate(arm.pose.bones, start=1):
    pbone.rotation_mode = "XYZ"

    pbone.location = (0, 0, 0)
    pbone.rotation_euler = (0, 0, 0)
    pbone.scale = (1, 1, 1)
    pbone.keyframe_insert("location", frame=start_frame)
    pbone.keyframe_insert("rotation_euler", frame=start_frame)
    pbone.keyframe_insert("scale", frame=start_frame)

    pbone.location = (i * 0.05, i * 0.05, i * 0.1)
    pbone.rotation_euler = (
        math.radians(i * 5),
        math.radians(i * 10),
        math.radians(i * 25),
    )
    pbone.scale = (1 + i * 0.005, 1 + i * 0.005, 1 + i * 0.005)
    pbone.keyframe_insert("location", frame=mid_frame)
    pbone.keyframe_insert("rotation_euler", frame=mid_frame)
    pbone.keyframe_insert("scale", frame=mid_frame)

    pbone.location = (0, 0, 0)
    pbone.rotation_euler = (0, 0, math.radians(i * 50))
    pbone.scale = (1, 1, 1)
    pbone.keyframe_insert("location", frame=end_frame)
    pbone.keyframe_insert("rotation_euler", frame=end_frame)
    pbone.keyframe_insert("scale", frame=end_frame)

# -------------------------------------------------------
# Export FBX
# -------------------------------------------------------
bpy.ops.export_scene.fbx(
    filepath=output_path,
    use_selection=False,
    apply_scale_options="FBX_SCALE_ALL",
    bake_space_transform=False,
    add_leaf_bones=False,
)

print("Exported FBX:", output_path)
