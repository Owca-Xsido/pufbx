# cython: language_level=3
from pyufbx.pyufbx cimport (
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


cdef class ElementList:
    cdef ufbx_element **_data
    cdef size_t _count
    @staticmethod
    cdef ElementList create(ufbx_element **data, size_t count)

cdef class NodeList:
    cdef ufbx_node **_data
    cdef size_t _count
    @staticmethod
    cdef NodeList create(ufbx_node **data, size_t count)

cdef class PropList:
    cdef ufbx_prop *_data
    cdef size_t _count
    @staticmethod
    cdef PropList create(ufbx_prop *data, size_t count)

cdef class TransformList:
    cdef ufbx_transform **_data
    cdef size_t _count
    @staticmethod
    cdef TransformList create(ufbx_transform **data, size_t count)

cdef class BoneList:
    cdef ufbx_bone **_data
    cdef size_t _count
    @staticmethod
    cdef BoneList create(ufbx_bone **data, size_t count)

cdef class AnimList:
    cdef ufbx_anim **_data
    cdef size_t _count
    @staticmethod
    cdef AnimList create(ufbx_anim **data, size_t count)

cdef class AnimValueList:
    cdef ufbx_anim_value **_data
    cdef size_t _count
    @staticmethod
    cdef AnimValueList create(ufbx_anim_value **data, size_t count)

cdef class AnimCurveList:
    cdef ufbx_anim_curve **_data
    cdef size_t _count
    @staticmethod
    cdef AnimCurveList create(ufbx_anim_curve **data, size_t count)

cdef class KeyframeList:
    cdef ufbx_keyframe *_data
    cdef size_t _count
    @staticmethod
    cdef KeyframeList create(ufbx_keyframe *data, size_t count)

cdef class AnimPropList:
    cdef ufbx_anim_prop *_data
    cdef size_t _count
    @staticmethod
    cdef AnimPropList create(ufbx_anim_prop *data, size_t count)

cdef class AnimLayerList:
    cdef ufbx_anim_layer **_data
    cdef size_t _count
    @staticmethod
    cdef AnimLayerList create(ufbx_anim_layer **data, size_t count)

cdef class BakedAnimList:
    cdef ufbx_baked_anim **_data
    cdef size_t _count
    @staticmethod
    cdef BakedAnimList create(ufbx_baked_anim **data, size_t count)

cdef class BakedNodeList:
    cdef ufbx_baked_node *_data
    cdef size_t _count
    @staticmethod
    cdef BakedNodeList create(ufbx_baked_node *data, size_t count)

cdef class MeshList:
    cdef ufbx_mesh **_data
    cdef size_t _count
    @staticmethod
    cdef MeshList create(ufbx_mesh **data, size_t count)

cdef class LightList:
    cdef ufbx_light **_data
    cdef size_t _count
    @staticmethod
    cdef LightList create(ufbx_light **data, size_t count)

cdef class CameraList:
    cdef ufbx_camera **_data
    cdef size_t _count
    @staticmethod
    cdef CameraList create(ufbx_camera **data, size_t count)

cdef class EmptyList:
    cdef ufbx_empty **_data
    cdef size_t _count
    @staticmethod
    cdef EmptyList create(ufbx_empty **data, size_t count)

cdef class LineCurveList:
    cdef ufbx_line_curve **_data
    cdef size_t _count
    @staticmethod
    cdef LineCurveList create(ufbx_line_curve **data, size_t count)

cdef class NurbsCurveList:
    cdef ufbx_nurbs_curve **_data
    cdef size_t _count
    @staticmethod
    cdef NurbsCurveList create(ufbx_nurbs_curve **data, size_t count)

cdef class NurbsSurfaceList:
    cdef ufbx_nurbs_surface **_data
    cdef size_t _count
    @staticmethod
    cdef NurbsSurfaceList create(ufbx_nurbs_surface **data, size_t count)

cdef class NurbsTrimSurfaceList:
    cdef ufbx_nurbs_trim_surface **_data
    cdef size_t _count
    @staticmethod
    cdef NurbsTrimSurfaceList create(ufbx_nurbs_trim_surface **data, size_t count)

cdef class NurbsTrimBoundaryList:
    cdef ufbx_nurbs_trim_boundary **_data
    cdef size_t _count
    @staticmethod
    cdef NurbsTrimBoundaryList create(ufbx_nurbs_trim_boundary **data, size_t count)

cdef class ProceduralGeometryList:
    cdef ufbx_procedural_geometry **_data
    cdef size_t _count
    @staticmethod
    cdef ProceduralGeometryList create(ufbx_procedural_geometry **data, size_t count)

cdef class StereoCameraList:
    cdef ufbx_stereo_camera **_data
    cdef size_t _count
    @staticmethod
    cdef StereoCameraList create(ufbx_stereo_camera **data, size_t count)

cdef class CameraSwitcherList:
    cdef ufbx_camera_switcher **_data
    cdef size_t _count
    @staticmethod
    cdef CameraSwitcherList create(ufbx_camera_switcher **data, size_t count)

cdef class MarkerList:
    cdef ufbx_marker **_data
    cdef size_t _count
    @staticmethod
    cdef MarkerList create(ufbx_marker **data, size_t count)

cdef class LodGroupList:
    cdef ufbx_lod_group **_data
    cdef size_t _count
    @staticmethod
    cdef LodGroupList create(ufbx_lod_group **data, size_t count)

cdef class SkinDeformerList:
    cdef ufbx_skin_deformer **_data
    cdef size_t _count
    @staticmethod
    cdef SkinDeformerList create(ufbx_skin_deformer **data, size_t count)

cdef class SkinClusterList:
    cdef ufbx_skin_cluster **_data
    cdef size_t _count
    @staticmethod
    cdef SkinClusterList create(ufbx_skin_cluster **data, size_t count)

cdef class BlendDeformerList:
    cdef ufbx_blend_deformer **_data
    cdef size_t _count
    @staticmethod
    cdef BlendDeformerList create(ufbx_blend_deformer **data, size_t count)

cdef class BlendChannelList:
    cdef ufbx_blend_channel **_data
    cdef size_t _count
    @staticmethod
    cdef BlendChannelList create(ufbx_blend_channel **data, size_t count)

cdef class BlendShapeList:
    cdef ufbx_blend_shape **_data
    cdef size_t _count
    @staticmethod
    cdef BlendShapeList create(ufbx_blend_shape **data, size_t count)

cdef class CacheDeformerList:
    cdef ufbx_cache_deformer **_data
    cdef size_t _count
    @staticmethod
    cdef CacheDeformerList create(ufbx_cache_deformer **data, size_t count)

cdef class CacheFileList:
    cdef ufbx_cache_file **_data
    cdef size_t _count
    @staticmethod
    cdef CacheFileList create(ufbx_cache_file **data, size_t count)

cdef class MaterialList:
    cdef ufbx_material **_data
    cdef size_t _count
    @staticmethod
    cdef MaterialList create(ufbx_material **data, size_t count)

cdef class TextureList:
    cdef ufbx_texture **_data
    cdef size_t _count
    @staticmethod
    cdef TextureList create(ufbx_texture **data, size_t count)

cdef class VideoList:
    cdef ufbx_video **_data
    cdef size_t _count
    @staticmethod
    cdef VideoList create(ufbx_video **data, size_t count)

cdef class ShaderList:
    cdef ufbx_shader **_data
    cdef size_t _count
    @staticmethod
    cdef ShaderList create(ufbx_shader **data, size_t count)

cdef class ShaderBindingList:
    cdef ufbx_shader_binding **_data
    cdef size_t _count
    @staticmethod
    cdef ShaderBindingList create(ufbx_shader_binding **data, size_t count)

cdef class AnimStackList:
    cdef ufbx_anim_stack **_data
    cdef size_t _count
    @staticmethod
    cdef AnimStackList create(ufbx_anim_stack **data, size_t count)

cdef class DisplayLayerList:
    cdef ufbx_display_layer **_data
    cdef size_t _count
    @staticmethod
    cdef DisplayLayerList create(ufbx_display_layer **data, size_t count)

cdef class SelectionSetList:
    cdef ufbx_selection_set **_data
    cdef size_t _count
    @staticmethod
    cdef SelectionSetList create(ufbx_selection_set **data, size_t count)

cdef class SelectionNodeList:
    cdef ufbx_selection_node **_data
    cdef size_t _count
    @staticmethod
    cdef SelectionNodeList create(ufbx_selection_node **data, size_t count)

cdef class CharacterList:
    cdef ufbx_character **_data
    cdef size_t _count
    @staticmethod
    cdef CharacterList create(ufbx_character **data, size_t count)

cdef class ConstraintList:
    cdef ufbx_constraint **_data
    cdef size_t _count
    @staticmethod
    cdef ConstraintList create(ufbx_constraint **data, size_t count)

cdef class AudioLayerList:
    cdef ufbx_audio_layer **_data
    cdef size_t _count
    @staticmethod
    cdef AudioLayerList create(ufbx_audio_layer **data, size_t count)

cdef class AudioClipList:
    cdef ufbx_audio_clip **_data
    cdef size_t _count
    @staticmethod
    cdef AudioClipList create(ufbx_audio_clip **data, size_t count)

cdef class PoseList:
    cdef ufbx_pose **_data
    cdef size_t _count
    @staticmethod
    cdef PoseList create(ufbx_pose **data, size_t count)

cdef class MetadataObjectList:
    cdef ufbx_metadata_object **_data
    cdef size_t _count
    @staticmethod
    cdef MetadataObjectList create(ufbx_metadata_object **data, size_t count)

cdef class TextureFileList:
    cdef ufbx_texture_file *_data
    cdef size_t _count
    @staticmethod
    cdef TextureFileList create(ufbx_texture_file *data, size_t count)

