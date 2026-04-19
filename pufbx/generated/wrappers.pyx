# cython: language_level=3
from threading import Lock
from weakref import WeakValueDictionary

from pufbx.animation.anim cimport Anim, AnimLayer, AnimProp, AnimValue
from pufbx.animation.anim_curve cimport AnimCurve
from pufbx.animation.anim_stack cimport AnimStack
from pufbx.animation.bake_anim cimport BakedAnim
from pufbx.animation.keyframe cimport Keyframe
from pufbx.audio.audio_clip cimport AudioClip
from pufbx.audio.audio_layer cimport AudioLayer
from pufbx.core.transform cimport Transform
from pufbx.elements.blend_channel cimport BlendChannel
from pufbx.elements.blend_deformer cimport BlendDeformer
from pufbx.elements.blend_shape cimport BlendShape
from pufbx.elements.bone cimport Bone
from pufbx.elements.cache_deformer cimport CacheDeformer
from pufbx.elements.cache_file cimport CacheFile
from pufbx.elements.camera cimport Camera
from pufbx.elements.camera_switcher cimport CameraSwitcher
from pufbx.elements.character cimport Character
from pufbx.elements.constraint cimport Constraint
from pufbx.elements.display_layer cimport DisplayLayer
from pufbx.elements.element cimport Element
from pufbx.elements.empty cimport Empty
from pufbx.elements.light cimport Light
from pufbx.elements.line_curve cimport LineCurve
from pufbx.elements.lod_group cimport LodGroup
from pufbx.elements.marker cimport Marker
from pufbx.elements.mesh cimport Mesh
from pufbx.elements.metadata_object cimport MetadataObject
from pufbx.elements.node cimport BakedNode, Node
from pufbx.elements.nurbs_curve cimport NurbsCurve
from pufbx.elements.nurbs_surface cimport NurbsSurface
from pufbx.elements.nurbs_trim_boundary cimport NurbsTrimBoundary
from pufbx.elements.nurbs_trim_surface cimport NurbsTrimSurface
from pufbx.elements.pose cimport Pose
from pufbx.elements.procedural_geometry cimport ProceduralGeometry
from pufbx.elements.selection_node cimport SelectionNode
from pufbx.elements.selection_set cimport SelectionSet
from pufbx.elements.skin_cluster cimport SkinCluster
from pufbx.elements.skin_deformer cimport SkinDeformer
from pufbx.elements.stereo_camera cimport StereoCamera
from pufbx.materials.material cimport Material
from pufbx.materials.shader cimport Shader
from pufbx.materials.shader_binding cimport ShaderBinding
from pufbx.materials.texture cimport Texture
from pufbx.materials.texture_file cimport TextureFile
from pufbx.materials.video cimport Video
from pufbx.props.prop cimport Prop
from pufbx.pufbx cimport (
    ufbx_anim,
    ufbx_anim_curve,
    ufbx_anim_layer,
    ufbx_anim_prop,
    ufbx_anim_stack,
    ufbx_anim_value,
    ufbx_audio_clip,
    ufbx_audio_layer,
    ufbx_baked_anim,
    ufbx_baked_node,
    ufbx_blend_channel,
    ufbx_blend_deformer,
    ufbx_blend_shape,
    ufbx_bone,
    ufbx_cache_deformer,
    ufbx_cache_file,
    ufbx_camera,
    ufbx_camera_switcher,
    ufbx_character,
    ufbx_constraint,
    ufbx_display_layer,
    ufbx_element,
    ufbx_empty,
    ufbx_keyframe,
    ufbx_light,
    ufbx_line_curve,
    ufbx_lod_group,
    ufbx_marker,
    ufbx_material,
    ufbx_mesh,
    ufbx_metadata_object,
    ufbx_node,
    ufbx_nurbs_curve,
    ufbx_nurbs_surface,
    ufbx_nurbs_trim_boundary,
    ufbx_nurbs_trim_surface,
    ufbx_pose,
    ufbx_procedural_geometry,
    ufbx_prop,
    ufbx_selection_node,
    ufbx_selection_set,
    ufbx_shader,
    ufbx_shader_binding,
    ufbx_skin_cluster,
    ufbx_skin_deformer,
    ufbx_stereo_camera,
    ufbx_texture,
    ufbx_texture_file,
    ufbx_transform,
    ufbx_video,
)


# Cache for Element
cdef object _element_cache_lock = Lock()
cdef object _element_cache = WeakValueDictionary()

cdef Element wrap_element(ufbx_element *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _element_cache_lock:
        cached = _element_cache.get(ptr_key, None)
        if cached is not None:
            return <Element>cached
        
        obj = Element()
        obj._element = ptr
        _element_cache[ptr_key] = obj
        return obj
# Cache for Node
cdef object _node_cache_lock = Lock()
cdef object _node_cache = WeakValueDictionary()

cdef Node wrap_node(ufbx_node *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _node_cache_lock:
        cached = _node_cache.get(ptr_key, None)
        if cached is not None:
            return <Node>cached
        
        obj = Node()
        obj._node = ptr
        _node_cache[ptr_key] = obj
        return obj
# Cache for Prop
cdef object _prop_cache_lock = Lock()
cdef object _prop_cache = WeakValueDictionary()

cdef Prop wrap_prop(ufbx_prop *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _prop_cache_lock:
        cached = _prop_cache.get(ptr_key, None)
        if cached is not None:
            return <Prop>cached
        
        obj = Prop()
        obj._prop = ptr
        _prop_cache[ptr_key] = obj
        return obj
# Cache for Transform
cdef object _transform_cache_lock = Lock()
cdef object _transform_cache = WeakValueDictionary()

cdef Transform wrap_transform(ufbx_transform *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _transform_cache_lock:
        cached = _transform_cache.get(ptr_key, None)
        if cached is not None:
            return <Transform>cached
        
        obj = Transform()
        obj._transform = ptr
        _transform_cache[ptr_key] = obj
        return obj
# Cache for Bone
cdef object _bone_cache_lock = Lock()
cdef object _bone_cache = WeakValueDictionary()

cdef Bone wrap_bone(ufbx_bone *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _bone_cache_lock:
        cached = _bone_cache.get(ptr_key, None)
        if cached is not None:
            return <Bone>cached
        
        obj = Bone()
        obj._bone = ptr
        _bone_cache[ptr_key] = obj
        return obj
# Cache for Anim
cdef object _anim_cache_lock = Lock()
cdef object _anim_cache = WeakValueDictionary()

cdef Anim wrap_anim(ufbx_anim *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _anim_cache_lock:
        cached = _anim_cache.get(ptr_key, None)
        if cached is not None:
            return <Anim>cached
        
        obj = Anim()
        obj._anim = ptr
        _anim_cache[ptr_key] = obj
        return obj
# Cache for AnimValue
cdef object _anim_value_cache_lock = Lock()
cdef object _anim_value_cache = WeakValueDictionary()

cdef AnimValue wrap_anim_value(ufbx_anim_value *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _anim_value_cache_lock:
        cached = _anim_value_cache.get(ptr_key, None)
        if cached is not None:
            return <AnimValue>cached
        
        obj = AnimValue()
        obj._anim_value = ptr
        _anim_value_cache[ptr_key] = obj
        return obj
# Cache for AnimCurve
cdef object _anim_curve_cache_lock = Lock()
cdef object _anim_curve_cache = WeakValueDictionary()

cdef AnimCurve wrap_anim_curve(ufbx_anim_curve *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _anim_curve_cache_lock:
        cached = _anim_curve_cache.get(ptr_key, None)
        if cached is not None:
            return <AnimCurve>cached
        
        obj = AnimCurve()
        obj._anim_curve = ptr
        _anim_curve_cache[ptr_key] = obj
        return obj
# Cache for Keyframe
cdef object _keyframe_cache_lock = Lock()
cdef object _keyframe_cache = WeakValueDictionary()

cdef Keyframe wrap_keyframe(ufbx_keyframe *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _keyframe_cache_lock:
        cached = _keyframe_cache.get(ptr_key, None)
        if cached is not None:
            return <Keyframe>cached
        
        obj = Keyframe()
        obj._keyframe = ptr
        _keyframe_cache[ptr_key] = obj
        return obj
# Cache for AnimProp
cdef object _anim_prop_cache_lock = Lock()
cdef object _anim_prop_cache = WeakValueDictionary()

cdef AnimProp wrap_anim_prop(ufbx_anim_prop *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _anim_prop_cache_lock:
        cached = _anim_prop_cache.get(ptr_key, None)
        if cached is not None:
            return <AnimProp>cached
        
        obj = AnimProp()
        obj._anim_prop = ptr
        _anim_prop_cache[ptr_key] = obj
        return obj
# Cache for AnimLayer
cdef object _anim_layer_cache_lock = Lock()
cdef object _anim_layer_cache = WeakValueDictionary()

cdef AnimLayer wrap_anim_layer(ufbx_anim_layer *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _anim_layer_cache_lock:
        cached = _anim_layer_cache.get(ptr_key, None)
        if cached is not None:
            return <AnimLayer>cached
        
        obj = AnimLayer()
        obj._anim_layer = ptr
        _anim_layer_cache[ptr_key] = obj
        return obj
# Cache for BakedAnim
cdef object _baked_anim_cache_lock = Lock()
cdef object _baked_anim_cache = WeakValueDictionary()

cdef BakedAnim wrap_baked_anim(ufbx_baked_anim *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _baked_anim_cache_lock:
        cached = _baked_anim_cache.get(ptr_key, None)
        if cached is not None:
            return <BakedAnim>cached
        
        obj = BakedAnim()
        obj._baked_anim = ptr
        _baked_anim_cache[ptr_key] = obj
        return obj
# Cache for BakedNode
cdef object _baked_node_cache_lock = Lock()
cdef object _baked_node_cache = WeakValueDictionary()

cdef BakedNode wrap_baked_node(ufbx_baked_node *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _baked_node_cache_lock:
        cached = _baked_node_cache.get(ptr_key, None)
        if cached is not None:
            return <BakedNode>cached
        
        obj = BakedNode()
        obj._baked_node = ptr
        _baked_node_cache[ptr_key] = obj
        return obj
# Cache for Mesh
cdef object _mesh_cache_lock = Lock()
cdef object _mesh_cache = WeakValueDictionary()

cdef Mesh wrap_mesh(ufbx_mesh *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _mesh_cache_lock:
        cached = _mesh_cache.get(ptr_key, None)
        if cached is not None:
            return <Mesh>cached
        
        obj = Mesh()
        obj._mesh = ptr
        _mesh_cache[ptr_key] = obj
        return obj
# Cache for Light
cdef object _light_cache_lock = Lock()
cdef object _light_cache = WeakValueDictionary()

cdef Light wrap_light(ufbx_light *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _light_cache_lock:
        cached = _light_cache.get(ptr_key, None)
        if cached is not None:
            return <Light>cached
        
        obj = Light()
        obj._light = ptr
        _light_cache[ptr_key] = obj
        return obj
# Cache for Camera
cdef object _camera_cache_lock = Lock()
cdef object _camera_cache = WeakValueDictionary()

cdef Camera wrap_camera(ufbx_camera *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _camera_cache_lock:
        cached = _camera_cache.get(ptr_key, None)
        if cached is not None:
            return <Camera>cached
        
        obj = Camera()
        obj._camera = ptr
        _camera_cache[ptr_key] = obj
        return obj
# Cache for Empty
cdef object _empty_cache_lock = Lock()
cdef object _empty_cache = WeakValueDictionary()

cdef Empty wrap_empty(ufbx_empty *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _empty_cache_lock:
        cached = _empty_cache.get(ptr_key, None)
        if cached is not None:
            return <Empty>cached
        
        obj = Empty()
        obj._empty = ptr
        _empty_cache[ptr_key] = obj
        return obj
# Cache for LineCurve
cdef object _line_curve_cache_lock = Lock()
cdef object _line_curve_cache = WeakValueDictionary()

cdef LineCurve wrap_line_curve(ufbx_line_curve *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _line_curve_cache_lock:
        cached = _line_curve_cache.get(ptr_key, None)
        if cached is not None:
            return <LineCurve>cached
        
        obj = LineCurve()
        obj._line_curve = ptr
        _line_curve_cache[ptr_key] = obj
        return obj
# Cache for NurbsCurve
cdef object _nurbs_curve_cache_lock = Lock()
cdef object _nurbs_curve_cache = WeakValueDictionary()

cdef NurbsCurve wrap_nurbs_curve(ufbx_nurbs_curve *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _nurbs_curve_cache_lock:
        cached = _nurbs_curve_cache.get(ptr_key, None)
        if cached is not None:
            return <NurbsCurve>cached
        
        obj = NurbsCurve()
        obj._nurbs_curve = ptr
        _nurbs_curve_cache[ptr_key] = obj
        return obj
# Cache for NurbsSurface
cdef object _nurbs_surface_cache_lock = Lock()
cdef object _nurbs_surface_cache = WeakValueDictionary()

cdef NurbsSurface wrap_nurbs_surface(ufbx_nurbs_surface *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _nurbs_surface_cache_lock:
        cached = _nurbs_surface_cache.get(ptr_key, None)
        if cached is not None:
            return <NurbsSurface>cached
        
        obj = NurbsSurface()
        obj._nurbs_surface = ptr
        _nurbs_surface_cache[ptr_key] = obj
        return obj
# Cache for NurbsTrimSurface
cdef object _nurbs_trim_surface_cache_lock = Lock()
cdef object _nurbs_trim_surface_cache = WeakValueDictionary()

cdef NurbsTrimSurface wrap_nurbs_trim_surface(ufbx_nurbs_trim_surface *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _nurbs_trim_surface_cache_lock:
        cached = _nurbs_trim_surface_cache.get(ptr_key, None)
        if cached is not None:
            return <NurbsTrimSurface>cached
        
        obj = NurbsTrimSurface()
        obj._nurbs_trim_surface = ptr
        _nurbs_trim_surface_cache[ptr_key] = obj
        return obj
# Cache for NurbsTrimBoundary
cdef object _nurbs_trim_boundary_cache_lock = Lock()
cdef object _nurbs_trim_boundary_cache = WeakValueDictionary()

cdef NurbsTrimBoundary wrap_nurbs_trim_boundary(ufbx_nurbs_trim_boundary *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _nurbs_trim_boundary_cache_lock:
        cached = _nurbs_trim_boundary_cache.get(ptr_key, None)
        if cached is not None:
            return <NurbsTrimBoundary>cached
        
        obj = NurbsTrimBoundary()
        obj._nurbs_trim_boundary = ptr
        _nurbs_trim_boundary_cache[ptr_key] = obj
        return obj
# Cache for ProceduralGeometry
cdef object _procedural_geometry_cache_lock = Lock()
cdef object _procedural_geometry_cache = WeakValueDictionary()

cdef ProceduralGeometry wrap_procedural_geometry(ufbx_procedural_geometry *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _procedural_geometry_cache_lock:
        cached = _procedural_geometry_cache.get(ptr_key, None)
        if cached is not None:
            return <ProceduralGeometry>cached
        
        obj = ProceduralGeometry()
        obj._procedural_geometry = ptr
        _procedural_geometry_cache[ptr_key] = obj
        return obj
# Cache for StereoCamera
cdef object _stereo_camera_cache_lock = Lock()
cdef object _stereo_camera_cache = WeakValueDictionary()

cdef StereoCamera wrap_stereo_camera(ufbx_stereo_camera *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _stereo_camera_cache_lock:
        cached = _stereo_camera_cache.get(ptr_key, None)
        if cached is not None:
            return <StereoCamera>cached
        
        obj = StereoCamera()
        obj._stereo_camera = ptr
        _stereo_camera_cache[ptr_key] = obj
        return obj
# Cache for CameraSwitcher
cdef object _camera_switcher_cache_lock = Lock()
cdef object _camera_switcher_cache = WeakValueDictionary()

cdef CameraSwitcher wrap_camera_switcher(ufbx_camera_switcher *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _camera_switcher_cache_lock:
        cached = _camera_switcher_cache.get(ptr_key, None)
        if cached is not None:
            return <CameraSwitcher>cached
        
        obj = CameraSwitcher()
        obj._camera_switcher = ptr
        _camera_switcher_cache[ptr_key] = obj
        return obj
# Cache for Marker
cdef object _marker_cache_lock = Lock()
cdef object _marker_cache = WeakValueDictionary()

cdef Marker wrap_marker(ufbx_marker *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _marker_cache_lock:
        cached = _marker_cache.get(ptr_key, None)
        if cached is not None:
            return <Marker>cached
        
        obj = Marker()
        obj._marker = ptr
        _marker_cache[ptr_key] = obj
        return obj
# Cache for LodGroup
cdef object _lod_group_cache_lock = Lock()
cdef object _lod_group_cache = WeakValueDictionary()

cdef LodGroup wrap_lod_group(ufbx_lod_group *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _lod_group_cache_lock:
        cached = _lod_group_cache.get(ptr_key, None)
        if cached is not None:
            return <LodGroup>cached
        
        obj = LodGroup()
        obj._lod_group = ptr
        _lod_group_cache[ptr_key] = obj
        return obj
# Cache for SkinDeformer
cdef object _skin_deformer_cache_lock = Lock()
cdef object _skin_deformer_cache = WeakValueDictionary()

cdef SkinDeformer wrap_skin_deformer(ufbx_skin_deformer *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _skin_deformer_cache_lock:
        cached = _skin_deformer_cache.get(ptr_key, None)
        if cached is not None:
            return <SkinDeformer>cached
        
        obj = SkinDeformer()
        obj._skin_deformer = ptr
        _skin_deformer_cache[ptr_key] = obj
        return obj
# Cache for SkinCluster
cdef object _skin_cluster_cache_lock = Lock()
cdef object _skin_cluster_cache = WeakValueDictionary()

cdef SkinCluster wrap_skin_cluster(ufbx_skin_cluster *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _skin_cluster_cache_lock:
        cached = _skin_cluster_cache.get(ptr_key, None)
        if cached is not None:
            return <SkinCluster>cached
        
        obj = SkinCluster()
        obj._skin_cluster = ptr
        _skin_cluster_cache[ptr_key] = obj
        return obj
# Cache for BlendDeformer
cdef object _blend_deformer_cache_lock = Lock()
cdef object _blend_deformer_cache = WeakValueDictionary()

cdef BlendDeformer wrap_blend_deformer(ufbx_blend_deformer *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _blend_deformer_cache_lock:
        cached = _blend_deformer_cache.get(ptr_key, None)
        if cached is not None:
            return <BlendDeformer>cached
        
        obj = BlendDeformer()
        obj._blend_deformer = ptr
        _blend_deformer_cache[ptr_key] = obj
        return obj
# Cache for BlendChannel
cdef object _blend_channel_cache_lock = Lock()
cdef object _blend_channel_cache = WeakValueDictionary()

cdef BlendChannel wrap_blend_channel(ufbx_blend_channel *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _blend_channel_cache_lock:
        cached = _blend_channel_cache.get(ptr_key, None)
        if cached is not None:
            return <BlendChannel>cached
        
        obj = BlendChannel()
        obj._blend_channel = ptr
        _blend_channel_cache[ptr_key] = obj
        return obj
# Cache for BlendShape
cdef object _blend_shape_cache_lock = Lock()
cdef object _blend_shape_cache = WeakValueDictionary()

cdef BlendShape wrap_blend_shape(ufbx_blend_shape *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _blend_shape_cache_lock:
        cached = _blend_shape_cache.get(ptr_key, None)
        if cached is not None:
            return <BlendShape>cached
        
        obj = BlendShape()
        obj._blend_shape = ptr
        _blend_shape_cache[ptr_key] = obj
        return obj
# Cache for CacheDeformer
cdef object _cache_deformer_cache_lock = Lock()
cdef object _cache_deformer_cache = WeakValueDictionary()

cdef CacheDeformer wrap_cache_deformer(ufbx_cache_deformer *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _cache_deformer_cache_lock:
        cached = _cache_deformer_cache.get(ptr_key, None)
        if cached is not None:
            return <CacheDeformer>cached
        
        obj = CacheDeformer()
        obj._cache_deformer = ptr
        _cache_deformer_cache[ptr_key] = obj
        return obj
# Cache for CacheFile
cdef object _cache_file_cache_lock = Lock()
cdef object _cache_file_cache = WeakValueDictionary()

cdef CacheFile wrap_cache_file(ufbx_cache_file *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _cache_file_cache_lock:
        cached = _cache_file_cache.get(ptr_key, None)
        if cached is not None:
            return <CacheFile>cached
        
        obj = CacheFile()
        obj._cache_file = ptr
        _cache_file_cache[ptr_key] = obj
        return obj
# Cache for Material
cdef object _material_cache_lock = Lock()
cdef object _material_cache = WeakValueDictionary()

cdef Material wrap_material(ufbx_material *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _material_cache_lock:
        cached = _material_cache.get(ptr_key, None)
        if cached is not None:
            return <Material>cached
        
        obj = Material()
        obj._material = ptr
        _material_cache[ptr_key] = obj
        return obj
# Cache for Texture
cdef object _texture_cache_lock = Lock()
cdef object _texture_cache = WeakValueDictionary()

cdef Texture wrap_texture(ufbx_texture *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _texture_cache_lock:
        cached = _texture_cache.get(ptr_key, None)
        if cached is not None:
            return <Texture>cached
        
        obj = Texture()
        obj._texture = ptr
        _texture_cache[ptr_key] = obj
        return obj
# Cache for Video
cdef object _video_cache_lock = Lock()
cdef object _video_cache = WeakValueDictionary()

cdef Video wrap_video(ufbx_video *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _video_cache_lock:
        cached = _video_cache.get(ptr_key, None)
        if cached is not None:
            return <Video>cached
        
        obj = Video()
        obj._video = ptr
        _video_cache[ptr_key] = obj
        return obj
# Cache for Shader
cdef object _shader_cache_lock = Lock()
cdef object _shader_cache = WeakValueDictionary()

cdef Shader wrap_shader(ufbx_shader *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _shader_cache_lock:
        cached = _shader_cache.get(ptr_key, None)
        if cached is not None:
            return <Shader>cached
        
        obj = Shader()
        obj._shader = ptr
        _shader_cache[ptr_key] = obj
        return obj
# Cache for ShaderBinding
cdef object _shader_binding_cache_lock = Lock()
cdef object _shader_binding_cache = WeakValueDictionary()

cdef ShaderBinding wrap_shader_binding(ufbx_shader_binding *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _shader_binding_cache_lock:
        cached = _shader_binding_cache.get(ptr_key, None)
        if cached is not None:
            return <ShaderBinding>cached
        
        obj = ShaderBinding()
        obj._shader_binding = ptr
        _shader_binding_cache[ptr_key] = obj
        return obj
# Cache for AnimStack
cdef object _anim_stack_cache_lock = Lock()
cdef object _anim_stack_cache = WeakValueDictionary()

cdef AnimStack wrap_anim_stack(ufbx_anim_stack *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _anim_stack_cache_lock:
        cached = _anim_stack_cache.get(ptr_key, None)
        if cached is not None:
            return <AnimStack>cached
        
        obj = AnimStack()
        obj._anim_stack = ptr
        _anim_stack_cache[ptr_key] = obj
        return obj
# Cache for DisplayLayer
cdef object _display_layer_cache_lock = Lock()
cdef object _display_layer_cache = WeakValueDictionary()

cdef DisplayLayer wrap_display_layer(ufbx_display_layer *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _display_layer_cache_lock:
        cached = _display_layer_cache.get(ptr_key, None)
        if cached is not None:
            return <DisplayLayer>cached
        
        obj = DisplayLayer()
        obj._display_layer = ptr
        _display_layer_cache[ptr_key] = obj
        return obj
# Cache for SelectionSet
cdef object _selection_set_cache_lock = Lock()
cdef object _selection_set_cache = WeakValueDictionary()

cdef SelectionSet wrap_selection_set(ufbx_selection_set *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _selection_set_cache_lock:
        cached = _selection_set_cache.get(ptr_key, None)
        if cached is not None:
            return <SelectionSet>cached
        
        obj = SelectionSet()
        obj._selection_set = ptr
        _selection_set_cache[ptr_key] = obj
        return obj
# Cache for SelectionNode
cdef object _selection_node_cache_lock = Lock()
cdef object _selection_node_cache = WeakValueDictionary()

cdef SelectionNode wrap_selection_node(ufbx_selection_node *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _selection_node_cache_lock:
        cached = _selection_node_cache.get(ptr_key, None)
        if cached is not None:
            return <SelectionNode>cached
        
        obj = SelectionNode()
        obj._selection_node = ptr
        _selection_node_cache[ptr_key] = obj
        return obj
# Cache for Character
cdef object _character_cache_lock = Lock()
cdef object _character_cache = WeakValueDictionary()

cdef Character wrap_character(ufbx_character *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _character_cache_lock:
        cached = _character_cache.get(ptr_key, None)
        if cached is not None:
            return <Character>cached
        
        obj = Character()
        obj._character = ptr
        _character_cache[ptr_key] = obj
        return obj
# Cache for Constraint
cdef object _constraint_cache_lock = Lock()
cdef object _constraint_cache = WeakValueDictionary()

cdef Constraint wrap_constraint(ufbx_constraint *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _constraint_cache_lock:
        cached = _constraint_cache.get(ptr_key, None)
        if cached is not None:
            return <Constraint>cached
        
        obj = Constraint()
        obj._constraint = ptr
        _constraint_cache[ptr_key] = obj
        return obj
# Cache for AudioLayer
cdef object _audio_layer_cache_lock = Lock()
cdef object _audio_layer_cache = WeakValueDictionary()

cdef AudioLayer wrap_audio_layer(ufbx_audio_layer *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _audio_layer_cache_lock:
        cached = _audio_layer_cache.get(ptr_key, None)
        if cached is not None:
            return <AudioLayer>cached
        
        obj = AudioLayer()
        obj._audio_layer = ptr
        _audio_layer_cache[ptr_key] = obj
        return obj
# Cache for AudioClip
cdef object _audio_clip_cache_lock = Lock()
cdef object _audio_clip_cache = WeakValueDictionary()

cdef AudioClip wrap_audio_clip(ufbx_audio_clip *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _audio_clip_cache_lock:
        cached = _audio_clip_cache.get(ptr_key, None)
        if cached is not None:
            return <AudioClip>cached
        
        obj = AudioClip()
        obj._audio_clip = ptr
        _audio_clip_cache[ptr_key] = obj
        return obj
# Cache for Pose
cdef object _pose_cache_lock = Lock()
cdef object _pose_cache = WeakValueDictionary()

cdef Pose wrap_pose(ufbx_pose *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _pose_cache_lock:
        cached = _pose_cache.get(ptr_key, None)
        if cached is not None:
            return <Pose>cached
        
        obj = Pose()
        obj._pose = ptr
        _pose_cache[ptr_key] = obj
        return obj
# Cache for MetadataObject
cdef object _metadata_object_cache_lock = Lock()
cdef object _metadata_object_cache = WeakValueDictionary()

cdef MetadataObject wrap_metadata_object(ufbx_metadata_object *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _metadata_object_cache_lock:
        cached = _metadata_object_cache.get(ptr_key, None)
        if cached is not None:
            return <MetadataObject>cached
        
        obj = MetadataObject()
        obj._metadata_object = ptr
        _metadata_object_cache[ptr_key] = obj
        return obj
# Cache for TextureFile
cdef object _texture_file_cache_lock = Lock()
cdef object _texture_file_cache = WeakValueDictionary()

cdef TextureFile wrap_texture_file(ufbx_texture_file *ptr):
    if ptr == NULL:
        return None
    
    cdef size_t ptr_key = <size_t>ptr
    
    with _texture_file_cache_lock:
        cached = _texture_file_cache.get(ptr_key, None)
        if cached is not None:
            return <TextureFile>cached
        
        obj = TextureFile()
        obj._texture_file = ptr
        _texture_file_cache[ptr_key] = obj
        return obj
