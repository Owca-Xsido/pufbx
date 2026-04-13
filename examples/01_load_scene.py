"""
Example 01: Load an FBX scene and inspect its nodes.

Shows how to open an FBX file, walk the node hierarchy, and print
each node's name and attribute type.
"""
import pyufbx

scene = pyufbx.load_fbx("samples/drunk_idle_turn_360_R_001.fbx")

print(f"Nodes: {len(scene.nodes)}")
print(f"Anim stacks: {len(scene.anim_stacks)}")
print()

for node in scene.nodes:
    indent = "  " * node.node_depth
    print(f"{indent}{node.name!r}  attrib={node.attrib_type}")
