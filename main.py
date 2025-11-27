import pyufbx as fbx 



scene = fbx.load_fbx("samples/f_Ani_guns_dialogue_disgust_001.fbx")
for node in scene.nodes:
    # print(dir(node))
    print(node.is_visible)
    print(node.type)