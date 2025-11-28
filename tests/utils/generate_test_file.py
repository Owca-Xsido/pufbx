import math

# Extend path to save the FBX file
import bpy

output_dir = bpy.path.abspath("tests/fixtures")
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
    if parent_obj:
        cube.parent = parent_obj

    parent_obj = cube
    cubes.append(cube)

# -------------------------------------------------------
# Animate cubes
# -------------------------------------------------------
start = 1
end = 100

for i, cube in enumerate(cubes, start=1):
    bpy.context.view_layer.objects.active = cube
    cube.rotation_euler = (0, 0, 0)
    cube.keyframe_insert(data_path="rotation_euler", frame=start)

    # Predictable rotation: 10° * index * frame_ratio
    cube.rotation_euler = (0, 0, math.radians(i * 100))
    cube.keyframe_insert(data_path="rotation_euler", frame=end)

# -------------------------------------------------------
# Create armature with bone chain: bone_1 -> bone_2 -> ... -> bone_10
# -------------------------------------------------------
bpy.ops.object.armature_add(enter_editmode=True)
arm = bpy.context.object
arm.name = "Armature"
edit_bones = arm.data.edit_bones

root = edit_bones[0]
root.name = "bone_1"
root.head = (0, 0, 0)
root.tail = (0, 0, 1)

prev_bone = root

for i in range(2, 11):
    bone = edit_bones.new(f"bone_{i}")
    bone.head = prev_bone.tail
    bone.tail = (bone.head[0], bone.head[1], bone.head[2] + 1)
    bone.parent = prev_bone
    prev_bone = bone

bpy.ops.object.mode_set(mode="POSE")

# -------------------------------------------------------
# Animate bones
# -------------------------------------------------------
for i, pbone in enumerate(arm.pose.bones, start=1):
    pbone.rotation_mode = "XYZ"
    pbone.rotation_euler = (0, 0, 0)
    pbone.keyframe_insert(data_path="rotation_euler", frame=start)

    # Predictable rotation: each bone rotates more
    pbone.rotation_euler = (0, 0, math.radians(i * 50))
    pbone.keyframe_insert(data_path="rotation_euler", frame=end)

# -------------------------------------------------------
# Export FBX
# -------------------------------------------------------
output_path = bpy.path.abspath("tests/fixtures/cube_and_bone.fbx")
bpy.ops.export_scene.fbx(
    filepath=output_path,
    use_selection=False,
    apply_scale_options="FBX_SCALE_ALL",
    bake_space_transform=False,
)

print("Exported FBX:", output_path)
