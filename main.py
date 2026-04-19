import pufbx as fbx 



scene = fbx.load_fbx("samples/f_Ani_guns_dialogue_disgust_001.fbx")
for node in scene.nodes:
    for child in node:
       print(node.attrib_type)