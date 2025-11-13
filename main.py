import pyufbx as fbx 



print(dir(fbx))
scene = fbx.load_fbx("/home/owca/Desktop/code/pyufbx/test/Walking.fbx")
print(scene)


