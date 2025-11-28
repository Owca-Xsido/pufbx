from libc.stdint cimport (int32_t, int64_t, uint8_t, uint32_t, uint64_t,
                          uintptr_t)


cdef extern from "<stdbool.h>":
    ctypedef int bool

cdef extern from "ufbx/ufbx.h":

    ctypedef double ufbx_real

    cdef struct ufbx_string:
        const char* data
        size_t length

    cdef struct ufbx_blob:
        const void* data
        size_t size

    cdef struct ufbx_vec2:
        ufbx_real v[2]
        ufbx_real x
        ufbx_real y

    cdef struct ufbx_vec3:
        ufbx_real v[3]
        ufbx_real x
        ufbx_real y
        ufbx_real z

    cdef struct ufbx_vec4:
        ufbx_real v[4]
        ufbx_real x
        ufbx_real y
        ufbx_real z
        ufbx_real w

    cdef struct ufbx_quat:
        ufbx_real v[4]
        ufbx_real x
        ufbx_real y
        ufbx_real z
        ufbx_real w

    cpdef enum ufbx_rotation_order:
        UFBX_ROTATION_ORDER_XYZ
        UFBX_ROTATION_ORDER_XZY
        UFBX_ROTATION_ORDER_YZX
        UFBX_ROTATION_ORDER_YXZ
        UFBX_ROTATION_ORDER_ZXY
        UFBX_ROTATION_ORDER_ZYX
        UFBX_ROTATION_ORDER_SPHERIC
        UFBX_ROTATION_ORDER_FORCE_32BIT

    cpdef enum:
        UFBX_ROTATION_ORDER_COUNT

    cdef struct ufbx_transform:
        ufbx_vec3 translation
        ufbx_quat rotation
        ufbx_vec3 scale

    cdef struct ufbx_matrix:
        ufbx_vec3 cols[4]
        ufbx_real v[12]
        ufbx_real m00
        ufbx_real m10
        ufbx_real m20
        ufbx_real m01
        ufbx_real m11
        ufbx_real m21
        ufbx_real m02
        ufbx_real m12
        ufbx_real m22
        ufbx_real m03
        ufbx_real m13
        ufbx_real m23

    cdef struct ufbx_void_list:
        void* data
        size_t count

    cdef struct ufbx_bool_list:
        bool* data
        size_t count

    cdef struct ufbx_uint32_list:
        uint32_t* data
        size_t count

    cdef struct ufbx_real_list:
        ufbx_real* data
        size_t count

    cdef struct ufbx_vec2_list:
        ufbx_vec2* data
        size_t count

    cdef struct ufbx_vec3_list:
        ufbx_vec3* data
        size_t count

    cdef struct ufbx_vec4_list:
        ufbx_vec4* data
        size_t count

    cdef struct ufbx_string_list:
        ufbx_string* data
        size_t count

    cpdef enum ufbx_dom_value_type:
        UFBX_DOM_VALUE_NUMBER
        UFBX_DOM_VALUE_STRING
        UFBX_DOM_VALUE_BLOB
        UFBX_DOM_VALUE_ARRAY_I32
        UFBX_DOM_VALUE_ARRAY_I64
        UFBX_DOM_VALUE_ARRAY_F32
        UFBX_DOM_VALUE_ARRAY_F64
        UFBX_DOM_VALUE_ARRAY_BLOB
        UFBX_DOM_VALUE_ARRAY_IGNORED
        UFBX_DOM_VALUE_TYPE_FORCE_32BIT

    cpdef enum:
        UFBX_DOM_VALUE_TYPE_COUNT

    cdef struct ufbx_int32_list:
        int32_t* data
        size_t count

    cdef struct ufbx_int64_list:
        int64_t* data
        size_t count

    cdef struct ufbx_float_list:
        float* data
        size_t count

    cdef struct ufbx_double_list:
        double* data
        size_t count

    cdef struct ufbx_blob_list:
        ufbx_blob* data
        size_t count

    cdef struct ufbx_dom_value:
        ufbx_dom_value_type type
        ufbx_string value_str
        ufbx_blob value_blob
        int64_t value_int
        double value_float

    cdef struct ufbx_dom_node_list:
        ufbx_dom_node** data
        size_t count

    cdef struct ufbx_dom_value_list:
        ufbx_dom_value* data
        size_t count

    cdef struct ufbx_dom_node:
        ufbx_string name
        ufbx_dom_node_list children
        ufbx_dom_value_list values

    cpdef enum ufbx_prop_type:
        UFBX_PROP_UNKNOWN
        UFBX_PROP_BOOLEAN
        UFBX_PROP_INTEGER
        UFBX_PROP_NUMBER
        UFBX_PROP_VECTOR
        UFBX_PROP_COLOR
        UFBX_PROP_COLOR_WITH_ALPHA
        UFBX_PROP_STRING
        UFBX_PROP_DATE_TIME
        UFBX_PROP_TRANSLATION
        UFBX_PROP_ROTATION
        UFBX_PROP_SCALING
        UFBX_PROP_DISTANCE
        UFBX_PROP_COMPOUND
        UFBX_PROP_BLOB
        UFBX_PROP_REFERENCE
        UFBX_PROP_TYPE_FORCE_32BIT

    cpdef enum:
        UFBX_PROP_TYPE_COUNT

    cpdef enum ufbx_prop_flags:
        UFBX_PROP_FLAG_ANIMATABLE
        UFBX_PROP_FLAG_USER_DEFINED
        UFBX_PROP_FLAG_HIDDEN
        UFBX_PROP_FLAG_LOCK_X
        UFBX_PROP_FLAG_LOCK_Y
        UFBX_PROP_FLAG_LOCK_Z
        UFBX_PROP_FLAG_LOCK_W
        UFBX_PROP_FLAG_MUTE_X
        UFBX_PROP_FLAG_MUTE_Y
        UFBX_PROP_FLAG_MUTE_Z
        UFBX_PROP_FLAG_MUTE_W
        UFBX_PROP_FLAG_SYNTHETIC
        UFBX_PROP_FLAG_ANIMATED
        UFBX_PROP_FLAG_NOT_FOUND
        UFBX_PROP_FLAG_CONNECTED
        UFBX_PROP_FLAG_NO_VALUE
        UFBX_PROP_FLAG_OVERRIDDEN
        UFBX_PROP_FLAG_VALUE_REAL
        UFBX_PROP_FLAG_VALUE_VEC2
        UFBX_PROP_FLAG_VALUE_VEC3
        UFBX_PROP_FLAG_VALUE_VEC4
        UFBX_PROP_FLAG_VALUE_INT
        UFBX_PROP_FLAG_VALUE_STR
        UFBX_PROP_FLAG_VALUE_BLOB
        UFBX_PROP_FLAGS_FORCE_32BIT

    cdef struct ufbx_prop:
        ufbx_string name
        uint32_t _internal_key
        ufbx_prop_type type
        ufbx_prop_flags flags
        ufbx_string value_str
        ufbx_blob value_blob
        int64_t value_int
        ufbx_real value_real_arr[4]
        ufbx_real value_real
        ufbx_vec2 value_vec2
        ufbx_vec3 value_vec3
        ufbx_vec4 value_vec4

    cdef struct ufbx_prop_list:
        ufbx_prop* data
        size_t count

    cdef struct ufbx_props:
        ufbx_prop_list props
        size_t num_animated
        ufbx_props* defaults

    cdef struct ufbx_element_list:
        ufbx_element** data
        size_t count

    cdef struct ufbx_unknown_list:
        ufbx_unknown** data
        size_t count

    cdef struct ufbx_node_list:
        ufbx_node** data
        size_t count

    cdef struct ufbx_mesh_list:
        ufbx_mesh** data
        size_t count

    cdef struct ufbx_light_list:
        ufbx_light** data
        size_t count

    cdef struct ufbx_camera_list:
        ufbx_camera** data
        size_t count

    cdef struct ufbx_bone_list:
        ufbx_bone** data
        size_t count

    cdef struct ufbx_empty_list:
        ufbx_empty** data
        size_t count

    cdef struct ufbx_line_curve_list:
        ufbx_line_curve** data
        size_t count

    cdef struct ufbx_nurbs_curve_list:
        ufbx_nurbs_curve** data
        size_t count

    cdef struct ufbx_nurbs_surface_list:
        ufbx_nurbs_surface** data
        size_t count

    cdef struct ufbx_nurbs_trim_surface_list:
        ufbx_nurbs_trim_surface** data
        size_t count

    cdef struct ufbx_nurbs_trim_boundary_list:
        ufbx_nurbs_trim_boundary** data
        size_t count

    cdef struct ufbx_procedural_geometry_list:
        ufbx_procedural_geometry** data
        size_t count

    cdef struct ufbx_stereo_camera_list:
        ufbx_stereo_camera** data
        size_t count

    cdef struct ufbx_camera_switcher_list:
        ufbx_camera_switcher** data
        size_t count

    cdef struct ufbx_marker_list:
        ufbx_marker** data
        size_t count

    cdef struct ufbx_lod_group_list:
        ufbx_lod_group** data
        size_t count

    cdef struct ufbx_skin_deformer_list:
        ufbx_skin_deformer** data
        size_t count

    cdef struct ufbx_skin_cluster_list:
        ufbx_skin_cluster** data
        size_t count

    cdef struct ufbx_blend_deformer_list:
        ufbx_blend_deformer** data
        size_t count

    cdef struct ufbx_blend_channel_list:
        ufbx_blend_channel** data
        size_t count

    cdef struct ufbx_blend_shape_list:
        ufbx_blend_shape** data
        size_t count

    cdef struct ufbx_cache_deformer_list:
        ufbx_cache_deformer** data
        size_t count

    cdef struct ufbx_cache_file_list:
        ufbx_cache_file** data
        size_t count

    cdef struct ufbx_material_list:
        ufbx_material** data
        size_t count

    cdef struct ufbx_texture_list:
        ufbx_texture** data
        size_t count

    cdef struct ufbx_video_list:
        ufbx_video** data
        size_t count

    cdef struct ufbx_shader_list:
        ufbx_shader** data
        size_t count

    cdef struct ufbx_shader_binding_list:
        ufbx_shader_binding** data
        size_t count

    cdef struct ufbx_anim_stack_list:
        ufbx_anim_stack** data
        size_t count

    cdef struct ufbx_anim_layer_list:
        ufbx_anim_layer** data
        size_t count

    cdef struct ufbx_anim_value_list:
        ufbx_anim_value** data
        size_t count

    cdef struct ufbx_anim_curve_list:
        ufbx_anim_curve** data
        size_t count

    cdef struct ufbx_display_layer_list:
        ufbx_display_layer** data
        size_t count

    cdef struct ufbx_selection_set_list:
        ufbx_selection_set** data
        size_t count

    cdef struct ufbx_selection_node_list:
        ufbx_selection_node** data
        size_t count

    cdef struct ufbx_character_list:
        ufbx_character** data
        size_t count

    cdef struct ufbx_constraint_list:
        ufbx_constraint** data
        size_t count

    cdef struct ufbx_audio_layer_list:
        ufbx_audio_layer** data
        size_t count

    cdef struct ufbx_audio_clip_list:
        ufbx_audio_clip** data
        size_t count

    cdef struct ufbx_pose_list:
        ufbx_pose** data
        size_t count

    cdef struct ufbx_metadata_object_list:
        ufbx_metadata_object** data
        size_t count

    cpdef enum ufbx_element_type:
        UFBX_ELEMENT_UNKNOWN
        UFBX_ELEMENT_NODE
        UFBX_ELEMENT_MESH
        UFBX_ELEMENT_LIGHT
        UFBX_ELEMENT_CAMERA
        UFBX_ELEMENT_BONE
        UFBX_ELEMENT_EMPTY
        UFBX_ELEMENT_LINE_CURVE
        UFBX_ELEMENT_NURBS_CURVE
        UFBX_ELEMENT_NURBS_SURFACE
        UFBX_ELEMENT_NURBS_TRIM_SURFACE
        UFBX_ELEMENT_NURBS_TRIM_BOUNDARY
        UFBX_ELEMENT_PROCEDURAL_GEOMETRY
        UFBX_ELEMENT_STEREO_CAMERA
        UFBX_ELEMENT_CAMERA_SWITCHER
        UFBX_ELEMENT_MARKER
        UFBX_ELEMENT_LOD_GROUP
        UFBX_ELEMENT_SKIN_DEFORMER
        UFBX_ELEMENT_SKIN_CLUSTER
        UFBX_ELEMENT_BLEND_DEFORMER
        UFBX_ELEMENT_BLEND_CHANNEL
        UFBX_ELEMENT_BLEND_SHAPE
        UFBX_ELEMENT_CACHE_DEFORMER
        UFBX_ELEMENT_CACHE_FILE
        UFBX_ELEMENT_MATERIAL
        UFBX_ELEMENT_TEXTURE
        UFBX_ELEMENT_VIDEO
        UFBX_ELEMENT_SHADER
        UFBX_ELEMENT_SHADER_BINDING
        UFBX_ELEMENT_ANIM_STACK
        UFBX_ELEMENT_ANIM_LAYER
        UFBX_ELEMENT_ANIM_VALUE
        UFBX_ELEMENT_ANIM_CURVE
        UFBX_ELEMENT_DISPLAY_LAYER
        UFBX_ELEMENT_SELECTION_SET
        UFBX_ELEMENT_SELECTION_NODE
        UFBX_ELEMENT_CHARACTER
        UFBX_ELEMENT_CONSTRAINT
        UFBX_ELEMENT_AUDIO_LAYER
        UFBX_ELEMENT_AUDIO_CLIP
        UFBX_ELEMENT_POSE
        UFBX_ELEMENT_METADATA_OBJECT
        UFBX_ELEMENT_TYPE_FIRST_ATTRIB
        UFBX_ELEMENT_TYPE_LAST_ATTRIB
        UFBX_ELEMENT_TYPE_FORCE_32BIT

    cpdef enum:
        UFBX_ELEMENT_TYPE_COUNT

    cdef struct ufbx_connection:
        ufbx_element* src
        ufbx_element* dst
        ufbx_string src_prop
        ufbx_string dst_prop

    cdef struct ufbx_connection_list:
        ufbx_connection* data
        size_t count

    cdef struct ufbx_element:
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id
        ufbx_node_list instances
        ufbx_element_type type
        ufbx_connection_list connections_src
        ufbx_connection_list connections_dst
        ufbx_dom_node* dom_node
        ufbx_scene* scene

    cdef struct ufbx_unknown:
        ufbx_string type
        ufbx_string super_type
        ufbx_string sub_type
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id

    cpdef enum ufbx_inherit_mode:
        UFBX_INHERIT_MODE_NORMAL
        UFBX_INHERIT_MODE_IGNORE_PARENT_SCALE
        UFBX_INHERIT_MODE_COMPONENTWISE_SCALE
        UFBX_INHERIT_MODE_FORCE_32BIT

    cpdef enum:
        UFBX_INHERIT_MODE_COUNT

    cpdef enum ufbx_mirror_axis:
        UFBX_MIRROR_AXIS_NONE
        UFBX_MIRROR_AXIS_X
        UFBX_MIRROR_AXIS_Y
        UFBX_MIRROR_AXIS_Z
        UFBX_MIRROR_AXIS_FORCE_32BIT

    cpdef enum:
        UFBX_MIRROR_AXIS_COUNT

    cdef struct ufbx_node:
        ufbx_node* parent
        ufbx_node_list children
        ufbx_mesh* mesh
        ufbx_light* light
        ufbx_camera* camera
        ufbx_bone* bone
        ufbx_element* attrib
        ufbx_node* geometry_transform_helper
        ufbx_node* scale_helper
        ufbx_element_type attrib_type
        ufbx_element_list all_attribs
        ufbx_inherit_mode inherit_mode
        ufbx_inherit_mode original_inherit_mode
        ufbx_transform local_transform
        ufbx_transform geometry_transform
        ufbx_vec3 inherit_scale
        ufbx_node* inherit_scale_node
        ufbx_rotation_order rotation_order
        ufbx_vec3 euler_rotation
        ufbx_matrix node_to_parent
        ufbx_matrix node_to_world
        ufbx_matrix geometry_to_node
        ufbx_matrix geometry_to_world
        ufbx_matrix unscaled_node_to_world
        ufbx_vec3 adjust_pre_translation
        ufbx_quat adjust_pre_rotation
        ufbx_real adjust_pre_scale
        ufbx_quat adjust_post_rotation
        ufbx_real adjust_post_scale
        ufbx_real adjust_translation_scale
        ufbx_mirror_axis adjust_mirror_axis
        ufbx_material_list materials
        ufbx_pose* bind_pose
        bool visible
        bool is_root
        bool has_geometry_transform
        bool has_adjust_transform
        bool has_root_adjust_transform
        bool is_geometry_transform_helper
        bool is_scale_helper
        bool is_scale_compensate_parent
        uint32_t node_depth
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id

    cdef struct ufbx_vertex_attrib:
        bool exists
        ufbx_void_list values
        ufbx_uint32_list indices
        size_t value_reals
        bool unique_per_vertex
        ufbx_real_list values_w

    cdef struct ufbx_vertex_real:
        bool exists
        ufbx_real_list values
        ufbx_uint32_list indices
        size_t value_reals
        bool unique_per_vertex
        ufbx_real_list values_w

    cdef struct ufbx_vertex_vec2:
        bool exists
        ufbx_vec2_list values
        ufbx_uint32_list indices
        size_t value_reals
        bool unique_per_vertex
        ufbx_real_list values_w

    cdef struct ufbx_vertex_vec3:
        bool exists
        ufbx_vec3_list values
        ufbx_uint32_list indices
        size_t value_reals
        bool unique_per_vertex
        ufbx_real_list values_w

    cdef struct ufbx_vertex_vec4:
        bool exists
        ufbx_vec4_list values
        ufbx_uint32_list indices
        size_t value_reals
        bool unique_per_vertex
        ufbx_real_list values_w

    cdef struct ufbx_uv_set:
        ufbx_string name
        uint32_t index
        ufbx_vertex_vec2 vertex_uv
        ufbx_vertex_vec3 vertex_tangent
        ufbx_vertex_vec3 vertex_bitangent

    cdef struct ufbx_color_set:
        ufbx_string name
        uint32_t index
        ufbx_vertex_vec4 vertex_color

    cdef struct ufbx_uv_set_list:
        ufbx_uv_set* data
        size_t count

    cdef struct ufbx_color_set_list:
        ufbx_color_set* data
        size_t count

    cdef struct ufbx_edge:
        uint32_t indices[2]
        uint32_t a
        uint32_t b

    cdef struct ufbx_edge_list:
        ufbx_edge* data
        size_t count

    cdef struct ufbx_face:
        uint32_t index_begin
        uint32_t num_indices

    cdef struct ufbx_face_list:
        ufbx_face* data
        size_t count

    cdef struct ufbx_mesh_part:
        uint32_t index
        size_t num_faces
        size_t num_triangles
        size_t num_empty_faces
        size_t num_point_faces
        size_t num_line_faces
        ufbx_uint32_list face_indices

    cdef struct ufbx_mesh_part_list:
        ufbx_mesh_part* data
        size_t count

    cdef struct ufbx_face_group:
        int32_t id
        ufbx_string name

    cdef struct ufbx_face_group_list:
        ufbx_face_group* data
        size_t count

    cdef struct ufbx_subdivision_weight_range:
        uint32_t weight_begin
        uint32_t num_weights

    cdef struct ufbx_subdivision_weight_range_list:
        ufbx_subdivision_weight_range* data
        size_t count

    cdef struct ufbx_subdivision_weight:
        ufbx_real weight
        uint32_t index

    cdef struct ufbx_subdivision_weight_list:
        ufbx_subdivision_weight* data
        size_t count

    cdef struct ufbx_subdivision_result:
        size_t result_memory_used
        size_t temp_memory_used
        size_t result_allocs
        size_t temp_allocs
        ufbx_subdivision_weight_range_list source_vertex_ranges
        ufbx_subdivision_weight_list source_vertex_weights
        ufbx_subdivision_weight_range_list skin_cluster_ranges
        ufbx_subdivision_weight_list skin_cluster_weights

    cpdef enum ufbx_subdivision_display_mode:
        UFBX_SUBDIVISION_DISPLAY_DISABLED
        UFBX_SUBDIVISION_DISPLAY_HULL
        UFBX_SUBDIVISION_DISPLAY_HULL_AND_SMOOTH
        UFBX_SUBDIVISION_DISPLAY_SMOOTH
        UFBX_SUBDIVISION_DISPLAY_MODE_FORCE_32BIT

    cpdef enum:
        UFBX_SUBDIVISION_DISPLAY_MODE_COUNT

    cpdef enum ufbx_subdivision_boundary:
        UFBX_SUBDIVISION_BOUNDARY_DEFAULT
        UFBX_SUBDIVISION_BOUNDARY_LEGACY
        UFBX_SUBDIVISION_BOUNDARY_SHARP_CORNERS
        UFBX_SUBDIVISION_BOUNDARY_SHARP_NONE
        UFBX_SUBDIVISION_BOUNDARY_SHARP_BOUNDARY
        UFBX_SUBDIVISION_BOUNDARY_SHARP_INTERIOR
        UFBX_SUBDIVISION_BOUNDARY_FORCE_32BIT

    cpdef enum:
        UFBX_SUBDIVISION_BOUNDARY_COUNT

    cdef struct ufbx_mesh:
        size_t num_vertices
        size_t num_indices
        size_t num_faces
        size_t num_triangles
        size_t num_edges
        size_t max_face_triangles
        size_t num_empty_faces
        size_t num_point_faces
        size_t num_line_faces
        ufbx_face_list faces
        ufbx_bool_list face_smoothing
        ufbx_uint32_list face_material
        ufbx_uint32_list face_group
        ufbx_bool_list face_hole
        ufbx_edge_list edges
        ufbx_bool_list edge_smoothing
        ufbx_real_list edge_crease
        ufbx_bool_list edge_visibility
        ufbx_uint32_list vertex_indices
        ufbx_vec3_list vertices
        ufbx_uint32_list vertex_first_index
        ufbx_vertex_vec3 vertex_position
        ufbx_vertex_vec3 vertex_normal
        ufbx_vertex_vec2 vertex_uv
        ufbx_vertex_vec3 vertex_tangent
        ufbx_vertex_vec3 vertex_bitangent
        ufbx_vertex_vec4 vertex_color
        ufbx_vertex_real vertex_crease
        ufbx_uv_set_list uv_sets
        ufbx_color_set_list color_sets
        ufbx_material_list materials
        ufbx_face_group_list face_groups
        ufbx_mesh_part_list material_parts
        ufbx_mesh_part_list face_group_parts
        ufbx_uint32_list material_part_usage_order
        bool skinned_is_local
        ufbx_vertex_vec3 skinned_position
        ufbx_vertex_vec3 skinned_normal
        ufbx_skin_deformer_list skin_deformers
        ufbx_blend_deformer_list blend_deformers
        ufbx_cache_deformer_list cache_deformers
        ufbx_element_list all_deformers
        uint32_t subdivision_preview_levels
        uint32_t subdivision_render_levels
        ufbx_subdivision_display_mode subdivision_display_mode
        ufbx_subdivision_boundary subdivision_boundary
        ufbx_subdivision_boundary subdivision_uv_boundary
        bool reversed_winding
        bool generated_normals
        bool subdivision_evaluated
        ufbx_subdivision_result* subdivision_result
        bool from_tessellated_nurbs
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id
        ufbx_node_list instances

    cpdef enum ufbx_light_type:
        UFBX_LIGHT_POINT
        UFBX_LIGHT_DIRECTIONAL
        UFBX_LIGHT_SPOT
        UFBX_LIGHT_AREA
        UFBX_LIGHT_VOLUME
        UFBX_LIGHT_TYPE_FORCE_32BIT

    cpdef enum:
        UFBX_LIGHT_TYPE_COUNT

    cpdef enum ufbx_light_decay:
        UFBX_LIGHT_DECAY_NONE
        UFBX_LIGHT_DECAY_LINEAR
        UFBX_LIGHT_DECAY_QUADRATIC
        UFBX_LIGHT_DECAY_CUBIC
        UFBX_LIGHT_DECAY_FORCE_32BIT

    cpdef enum:
        UFBX_LIGHT_DECAY_COUNT

    cpdef enum ufbx_light_area_shape:
        UFBX_LIGHT_AREA_SHAPE_RECTANGLE
        UFBX_LIGHT_AREA_SHAPE_SPHERE
        UFBX_LIGHT_AREA_SHAPE_FORCE_32BIT

    cpdef enum:
        UFBX_LIGHT_AREA_SHAPE_COUNT

    cdef struct ufbx_light:
        ufbx_vec3 color
        ufbx_real intensity
        ufbx_vec3 local_direction
        ufbx_light_type type
        ufbx_light_decay decay
        ufbx_light_area_shape area_shape
        ufbx_real inner_angle
        ufbx_real outer_angle
        bool cast_light
        bool cast_shadows
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id
        ufbx_node_list instances

    cpdef enum ufbx_projection_mode:
        UFBX_PROJECTION_MODE_PERSPECTIVE
        UFBX_PROJECTION_MODE_ORTHOGRAPHIC
        UFBX_PROJECTION_MODE_FORCE_32BIT

    cpdef enum:
        UFBX_PROJECTION_MODE_COUNT

    cpdef enum ufbx_aspect_mode:
        UFBX_ASPECT_MODE_WINDOW_SIZE
        UFBX_ASPECT_MODE_FIXED_RATIO
        UFBX_ASPECT_MODE_FIXED_RESOLUTION
        UFBX_ASPECT_MODE_FIXED_WIDTH
        UFBX_ASPECT_MODE_FIXED_HEIGHT
        UFBX_ASPECT_MODE_FORCE_32BIT

    cpdef enum:
        UFBX_ASPECT_MODE_COUNT

    cpdef enum ufbx_aperture_mode:
        UFBX_APERTURE_MODE_HORIZONTAL_AND_VERTICAL
        UFBX_APERTURE_MODE_HORIZONTAL
        UFBX_APERTURE_MODE_VERTICAL
        UFBX_APERTURE_MODE_FOCAL_LENGTH
        UFBX_APERTURE_MODE_FORCE_32BIT

    cpdef enum:
        UFBX_APERTURE_MODE_COUNT

    cpdef enum ufbx_gate_fit:
        UFBX_GATE_FIT_NONE
        UFBX_GATE_FIT_VERTICAL
        UFBX_GATE_FIT_HORIZONTAL
        UFBX_GATE_FIT_FILL
        UFBX_GATE_FIT_OVERSCAN
        UFBX_GATE_FIT_STRETCH
        UFBX_GATE_FIT_FORCE_32BIT

    cpdef enum:
        UFBX_GATE_FIT_COUNT

    cpdef enum ufbx_aperture_format:
        UFBX_APERTURE_FORMAT_CUSTOM
        UFBX_APERTURE_FORMAT_16MM_THEATRICAL
        UFBX_APERTURE_FORMAT_SUPER_16MM
        UFBX_APERTURE_FORMAT_35MM_ACADEMY
        UFBX_APERTURE_FORMAT_35MM_TV_PROJECTION
        UFBX_APERTURE_FORMAT_35MM_FULL_APERTURE
        UFBX_APERTURE_FORMAT_35MM_185_PROJECTION
        UFBX_APERTURE_FORMAT_35MM_ANAMORPHIC
        UFBX_APERTURE_FORMAT_70MM_PROJECTION
        UFBX_APERTURE_FORMAT_VISTAVISION
        UFBX_APERTURE_FORMAT_DYNAVISION
        UFBX_APERTURE_FORMAT_IMAX
        UFBX_APERTURE_FORMAT_FORCE_32BIT

    cpdef enum:
        UFBX_APERTURE_FORMAT_COUNT

    cpdef enum ufbx_coordinate_axis:
        UFBX_COORDINATE_AXIS_POSITIVE_X
        UFBX_COORDINATE_AXIS_NEGATIVE_X
        UFBX_COORDINATE_AXIS_POSITIVE_Y
        UFBX_COORDINATE_AXIS_NEGATIVE_Y
        UFBX_COORDINATE_AXIS_POSITIVE_Z
        UFBX_COORDINATE_AXIS_NEGATIVE_Z
        UFBX_COORDINATE_AXIS_UNKNOWN
        UFBX_COORDINATE_AXIS_FORCE_32BIT

    cpdef enum:
        UFBX_COORDINATE_AXIS_COUNT

    cdef struct ufbx_coordinate_axes:
        ufbx_coordinate_axis right
        ufbx_coordinate_axis up
        ufbx_coordinate_axis front

    cdef struct ufbx_camera:
        ufbx_projection_mode projection_mode
        bool resolution_is_pixels
        ufbx_vec2 resolution
        ufbx_vec2 field_of_view_deg
        ufbx_vec2 field_of_view_tan
        ufbx_real orthographic_extent
        ufbx_vec2 orthographic_size
        ufbx_vec2 projection_plane
        ufbx_real aspect_ratio
        ufbx_real near_plane
        ufbx_real far_plane
        ufbx_coordinate_axes projection_axes
        ufbx_aspect_mode aspect_mode
        ufbx_aperture_mode aperture_mode
        ufbx_gate_fit gate_fit
        ufbx_aperture_format aperture_format
        ufbx_real focal_length_mm
        ufbx_vec2 film_size_inch
        ufbx_vec2 aperture_size_inch
        ufbx_real squeeze_ratio
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id
        ufbx_node_list instances

    cdef struct ufbx_bone:
        ufbx_real radius
        ufbx_real relative_length
        bool is_root
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id
        ufbx_node_list instances

    cdef struct ufbx_empty:
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id
        ufbx_node_list instances

    cdef struct ufbx_line_segment:
        uint32_t index_begin
        uint32_t num_indices

    cdef struct ufbx_line_segment_list:
        ufbx_line_segment* data
        size_t count

    cdef struct ufbx_line_curve:
        ufbx_vec3 color
        ufbx_vec3_list control_points
        ufbx_uint32_list point_indices
        ufbx_line_segment_list segments
        bool from_tessellated_nurbs
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id
        ufbx_node_list instances

    cpdef enum ufbx_nurbs_topology:
        UFBX_NURBS_TOPOLOGY_OPEN
        UFBX_NURBS_TOPOLOGY_PERIODIC
        UFBX_NURBS_TOPOLOGY_CLOSED
        UFBX_NURBS_TOPOLOGY_FORCE_32BIT

    cpdef enum:
        UFBX_NURBS_TOPOLOGY_COUNT

    cdef struct ufbx_nurbs_basis:
        uint32_t order
        ufbx_nurbs_topology topology
        ufbx_real_list knot_vector
        ufbx_real t_min
        ufbx_real t_max
        ufbx_real_list spans
        bool is_2d
        size_t num_wrap_control_points
        bool valid

    cdef struct ufbx_nurbs_curve:
        ufbx_nurbs_basis basis
        ufbx_vec4_list control_points
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id
        ufbx_node_list instances

    cdef struct ufbx_nurbs_surface:
        ufbx_nurbs_basis basis_u
        ufbx_nurbs_basis basis_v
        size_t num_control_points_u
        size_t num_control_points_v
        ufbx_vec4_list control_points
        uint32_t span_subdivision_u
        uint32_t span_subdivision_v
        bool flip_normals
        ufbx_material* material
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id
        ufbx_node_list instances

    cdef struct ufbx_nurbs_trim_surface:
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id
        ufbx_node_list instances

    cdef struct ufbx_nurbs_trim_boundary:
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id
        ufbx_node_list instances

    cdef struct ufbx_procedural_geometry:
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id
        ufbx_node_list instances

    cdef struct ufbx_stereo_camera:
        ufbx_camera* left
        ufbx_camera* right
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id
        ufbx_node_list instances

    cdef struct ufbx_camera_switcher:
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id
        ufbx_node_list instances

    cpdef enum ufbx_marker_type:
        UFBX_MARKER_UNKNOWN
        UFBX_MARKER_FK_EFFECTOR
        UFBX_MARKER_IK_EFFECTOR
        UFBX_MARKER_TYPE_FORCE_32BIT

    cpdef enum:
        UFBX_MARKER_TYPE_COUNT

    cdef struct ufbx_marker:
        ufbx_marker_type type
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id
        ufbx_node_list instances

    cpdef enum ufbx_lod_display:
        UFBX_LOD_DISPLAY_USE_LOD
        UFBX_LOD_DISPLAY_SHOW
        UFBX_LOD_DISPLAY_HIDE
        UFBX_LOD_DISPLAY_FORCE_32BIT

    cpdef enum:
        UFBX_LOD_DISPLAY_COUNT

    cdef struct ufbx_lod_level:
        ufbx_real distance
        ufbx_lod_display display

    cdef struct ufbx_lod_level_list:
        ufbx_lod_level* data
        size_t count

    cdef struct ufbx_lod_group:
        bool relative_distances
        ufbx_lod_level_list lod_levels
        bool ignore_parent_transform
        bool use_distance_limit
        ufbx_real distance_limit_min
        ufbx_real distance_limit_max
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id
        ufbx_node_list instances

    cpdef enum ufbx_skinning_method:
        UFBX_SKINNING_METHOD_LINEAR
        UFBX_SKINNING_METHOD_RIGID
        UFBX_SKINNING_METHOD_DUAL_QUATERNION
        UFBX_SKINNING_METHOD_BLENDED_DQ_LINEAR
        UFBX_SKINNING_METHOD_FORCE_32BIT

    cpdef enum:
        UFBX_SKINNING_METHOD_COUNT

    cdef struct ufbx_skin_vertex:
        uint32_t weight_begin
        uint32_t num_weights
        ufbx_real dq_weight

    cdef struct ufbx_skin_vertex_list:
        ufbx_skin_vertex* data
        size_t count

    cdef struct ufbx_skin_weight:
        uint32_t cluster_index
        ufbx_real weight

    cdef struct ufbx_skin_weight_list:
        ufbx_skin_weight* data
        size_t count

    cdef struct ufbx_skin_deformer:
        ufbx_skinning_method skinning_method
        ufbx_skin_cluster_list clusters
        ufbx_skin_vertex_list vertices
        ufbx_skin_weight_list weights
        size_t max_weights_per_vertex
        size_t num_dq_weights
        ufbx_uint32_list dq_vertices
        ufbx_real_list dq_weights
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id

    cdef struct ufbx_skin_cluster:
        ufbx_node* bone_node
        ufbx_matrix geometry_to_bone
        ufbx_matrix mesh_node_to_bone
        ufbx_matrix bind_to_world
        ufbx_matrix geometry_to_world
        ufbx_transform geometry_to_world_transform
        size_t num_weights
        ufbx_uint32_list vertices
        ufbx_real_list weights
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id

    cdef struct ufbx_blend_deformer:
        ufbx_blend_channel_list channels
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id

    cdef struct ufbx_blend_keyframe:
        ufbx_blend_shape* shape
        ufbx_real target_weight
        ufbx_real effective_weight

    cdef struct ufbx_blend_keyframe_list:
        ufbx_blend_keyframe* data
        size_t count

    cdef struct ufbx_blend_channel:
        ufbx_real weight
        ufbx_blend_keyframe_list keyframes
        ufbx_blend_shape* target_shape
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id

    cdef struct ufbx_blend_shape:
        size_t num_offsets
        ufbx_uint32_list offset_vertices
        ufbx_vec3_list position_offsets
        ufbx_vec3_list normal_offsets
        ufbx_real_list offset_weights
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id

    cpdef enum ufbx_cache_file_format:
        UFBX_CACHE_FILE_FORMAT_UNKNOWN
        UFBX_CACHE_FILE_FORMAT_PC2
        UFBX_CACHE_FILE_FORMAT_MC
        UFBX_CACHE_FILE_FORMAT_FORCE_32BIT

    cpdef enum:
        UFBX_CACHE_FILE_FORMAT_COUNT

    cpdef enum ufbx_cache_data_format:
        UFBX_CACHE_DATA_FORMAT_UNKNOWN
        UFBX_CACHE_DATA_FORMAT_REAL_FLOAT
        UFBX_CACHE_DATA_FORMAT_VEC3_FLOAT
        UFBX_CACHE_DATA_FORMAT_REAL_DOUBLE
        UFBX_CACHE_DATA_FORMAT_VEC3_DOUBLE
        UFBX_CACHE_DATA_FORMAT_FORCE_32BIT

    cpdef enum:
        UFBX_CACHE_DATA_FORMAT_COUNT

    cpdef enum ufbx_cache_data_encoding:
        UFBX_CACHE_DATA_ENCODING_UNKNOWN
        UFBX_CACHE_DATA_ENCODING_LITTLE_ENDIAN
        UFBX_CACHE_DATA_ENCODING_BIG_ENDIAN
        UFBX_CACHE_DATA_ENCODING_FORCE_32BIT

    cpdef enum:
        UFBX_CACHE_DATA_ENCODING_COUNT

    cpdef enum ufbx_cache_interpretation:
        UFBX_CACHE_INTERPRETATION_UNKNOWN
        UFBX_CACHE_INTERPRETATION_POINTS
        UFBX_CACHE_INTERPRETATION_VERTEX_POSITION
        UFBX_CACHE_INTERPRETATION_VERTEX_NORMAL
        UFBX_CACHE_INTERPRETATION_FORCE_32BIT

    cpdef enum:
        UFBX_CACHE_INTERPRETATION_COUNT

    cdef struct ufbx_cache_frame:
        ufbx_string channel
        double time
        ufbx_string filename
        ufbx_cache_file_format file_format
        ufbx_mirror_axis mirror_axis
        ufbx_real scale_factor
        ufbx_cache_data_format data_format
        ufbx_cache_data_encoding data_encoding
        uint64_t data_offset
        uint32_t data_count
        uint32_t data_element_bytes
        uint64_t data_total_bytes

    cdef struct ufbx_cache_frame_list:
        ufbx_cache_frame* data
        size_t count

    cdef struct ufbx_cache_channel:
        ufbx_string name
        ufbx_cache_interpretation interpretation
        ufbx_string interpretation_name
        ufbx_cache_frame_list frames
        ufbx_mirror_axis mirror_axis
        ufbx_real scale_factor

    cdef struct ufbx_cache_channel_list:
        ufbx_cache_channel* data
        size_t count

    cdef struct ufbx_geometry_cache:
        ufbx_string root_filename
        ufbx_cache_channel_list channels
        ufbx_cache_frame_list frames
        ufbx_string_list extra_info

    cdef struct ufbx_cache_deformer:
        ufbx_string channel
        ufbx_cache_file* file
        ufbx_geometry_cache* external_cache
        ufbx_cache_channel* external_channel
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id

    cdef struct ufbx_cache_file:
        ufbx_string filename
        ufbx_string absolute_filename
        ufbx_string relative_filename
        ufbx_blob raw_filename
        ufbx_blob raw_absolute_filename
        ufbx_blob raw_relative_filename
        ufbx_cache_file_format format
        ufbx_geometry_cache* external_cache
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id

    cdef struct ufbx_material_map:
        int64_t value_int
        ufbx_texture* texture
        bool has_value
        bool texture_enabled
        bool feature_disabled
        uint8_t value_components
        ufbx_real value_real
        ufbx_vec2 value_vec2
        ufbx_vec3 value_vec3
        ufbx_vec4 value_vec4

    cdef struct ufbx_material_feature_info:
        bool enabled
        bool is_explicit

    cdef struct ufbx_material_texture:
        ufbx_string material_prop
        ufbx_string shader_prop
        ufbx_texture* texture

    cdef struct ufbx_material_texture_list:
        ufbx_material_texture* data
        size_t count

    cpdef enum ufbx_shader_type:
        UFBX_SHADER_UNKNOWN
        UFBX_SHADER_FBX_LAMBERT
        UFBX_SHADER_FBX_PHONG
        UFBX_SHADER_OSL_STANDARD_SURFACE
        UFBX_SHADER_ARNOLD_STANDARD_SURFACE
        UFBX_SHADER_3DS_MAX_PHYSICAL_MATERIAL
        UFBX_SHADER_3DS_MAX_PBR_METAL_ROUGH
        UFBX_SHADER_3DS_MAX_PBR_SPEC_GLOSS
        UFBX_SHADER_GLTF_MATERIAL
        UFBX_SHADER_OPENPBR_MATERIAL
        UFBX_SHADER_SHADERFX_GRAPH
        UFBX_SHADER_BLENDER_PHONG
        UFBX_SHADER_WAVEFRONT_MTL
        UFBX_SHADER_TYPE_FORCE_32BIT

    cpdef enum:
        UFBX_SHADER_TYPE_COUNT

    cpdef enum ufbx_material_fbx_map:
        UFBX_MATERIAL_FBX_DIFFUSE_FACTOR
        UFBX_MATERIAL_FBX_DIFFUSE_COLOR
        UFBX_MATERIAL_FBX_SPECULAR_FACTOR
        UFBX_MATERIAL_FBX_SPECULAR_COLOR
        UFBX_MATERIAL_FBX_SPECULAR_EXPONENT
        UFBX_MATERIAL_FBX_REFLECTION_FACTOR
        UFBX_MATERIAL_FBX_REFLECTION_COLOR
        UFBX_MATERIAL_FBX_TRANSPARENCY_FACTOR
        UFBX_MATERIAL_FBX_TRANSPARENCY_COLOR
        UFBX_MATERIAL_FBX_EMISSION_FACTOR
        UFBX_MATERIAL_FBX_EMISSION_COLOR
        UFBX_MATERIAL_FBX_AMBIENT_FACTOR
        UFBX_MATERIAL_FBX_AMBIENT_COLOR
        UFBX_MATERIAL_FBX_NORMAL_MAP
        UFBX_MATERIAL_FBX_BUMP
        UFBX_MATERIAL_FBX_BUMP_FACTOR
        UFBX_MATERIAL_FBX_DISPLACEMENT_FACTOR
        UFBX_MATERIAL_FBX_DISPLACEMENT
        UFBX_MATERIAL_FBX_VECTOR_DISPLACEMENT_FACTOR
        UFBX_MATERIAL_FBX_VECTOR_DISPLACEMENT
        UFBX_MATERIAL_FBX_MAP_FORCE_32BIT

    cpdef enum:
        UFBX_MATERIAL_FBX_MAP_COUNT

    cpdef enum ufbx_material_pbr_map:
        UFBX_MATERIAL_PBR_BASE_FACTOR
        UFBX_MATERIAL_PBR_BASE_COLOR
        UFBX_MATERIAL_PBR_ROUGHNESS
        UFBX_MATERIAL_PBR_METALNESS
        UFBX_MATERIAL_PBR_DIFFUSE_ROUGHNESS
        UFBX_MATERIAL_PBR_SPECULAR_FACTOR
        UFBX_MATERIAL_PBR_SPECULAR_COLOR
        UFBX_MATERIAL_PBR_SPECULAR_IOR
        UFBX_MATERIAL_PBR_SPECULAR_ANISOTROPY
        UFBX_MATERIAL_PBR_SPECULAR_ROTATION
        UFBX_MATERIAL_PBR_TRANSMISSION_FACTOR
        UFBX_MATERIAL_PBR_TRANSMISSION_COLOR
        UFBX_MATERIAL_PBR_TRANSMISSION_DEPTH
        UFBX_MATERIAL_PBR_TRANSMISSION_SCATTER
        UFBX_MATERIAL_PBR_TRANSMISSION_SCATTER_ANISOTROPY
        UFBX_MATERIAL_PBR_TRANSMISSION_DISPERSION
        UFBX_MATERIAL_PBR_TRANSMISSION_ROUGHNESS
        UFBX_MATERIAL_PBR_TRANSMISSION_EXTRA_ROUGHNESS
        UFBX_MATERIAL_PBR_TRANSMISSION_PRIORITY
        UFBX_MATERIAL_PBR_TRANSMISSION_ENABLE_IN_AOV
        UFBX_MATERIAL_PBR_SUBSURFACE_FACTOR
        UFBX_MATERIAL_PBR_SUBSURFACE_COLOR
        UFBX_MATERIAL_PBR_SUBSURFACE_RADIUS
        UFBX_MATERIAL_PBR_SUBSURFACE_SCALE
        UFBX_MATERIAL_PBR_SUBSURFACE_ANISOTROPY
        UFBX_MATERIAL_PBR_SUBSURFACE_TINT_COLOR
        UFBX_MATERIAL_PBR_SUBSURFACE_TYPE
        UFBX_MATERIAL_PBR_SHEEN_FACTOR
        UFBX_MATERIAL_PBR_SHEEN_COLOR
        UFBX_MATERIAL_PBR_SHEEN_ROUGHNESS
        UFBX_MATERIAL_PBR_COAT_FACTOR
        UFBX_MATERIAL_PBR_COAT_COLOR
        UFBX_MATERIAL_PBR_COAT_ROUGHNESS
        UFBX_MATERIAL_PBR_COAT_IOR
        UFBX_MATERIAL_PBR_COAT_ANISOTROPY
        UFBX_MATERIAL_PBR_COAT_ROTATION
        UFBX_MATERIAL_PBR_COAT_NORMAL
        UFBX_MATERIAL_PBR_COAT_AFFECT_BASE_COLOR
        UFBX_MATERIAL_PBR_COAT_AFFECT_BASE_ROUGHNESS
        UFBX_MATERIAL_PBR_THIN_FILM_FACTOR
        UFBX_MATERIAL_PBR_THIN_FILM_THICKNESS
        UFBX_MATERIAL_PBR_THIN_FILM_IOR
        UFBX_MATERIAL_PBR_EMISSION_FACTOR
        UFBX_MATERIAL_PBR_EMISSION_COLOR
        UFBX_MATERIAL_PBR_OPACITY
        UFBX_MATERIAL_PBR_INDIRECT_DIFFUSE
        UFBX_MATERIAL_PBR_INDIRECT_SPECULAR
        UFBX_MATERIAL_PBR_NORMAL_MAP
        UFBX_MATERIAL_PBR_TANGENT_MAP
        UFBX_MATERIAL_PBR_DISPLACEMENT_MAP
        UFBX_MATERIAL_PBR_MATTE_FACTOR
        UFBX_MATERIAL_PBR_MATTE_COLOR
        UFBX_MATERIAL_PBR_AMBIENT_OCCLUSION
        UFBX_MATERIAL_PBR_GLOSSINESS
        UFBX_MATERIAL_PBR_COAT_GLOSSINESS
        UFBX_MATERIAL_PBR_TRANSMISSION_GLOSSINESS
        UFBX_MATERIAL_PBR_MAP_FORCE_32BIT

    cpdef enum:
        UFBX_MATERIAL_PBR_MAP_COUNT

    cpdef enum ufbx_material_feature:
        UFBX_MATERIAL_FEATURE_PBR
        UFBX_MATERIAL_FEATURE_METALNESS
        UFBX_MATERIAL_FEATURE_DIFFUSE
        UFBX_MATERIAL_FEATURE_SPECULAR
        UFBX_MATERIAL_FEATURE_EMISSION
        UFBX_MATERIAL_FEATURE_TRANSMISSION
        UFBX_MATERIAL_FEATURE_COAT
        UFBX_MATERIAL_FEATURE_SHEEN
        UFBX_MATERIAL_FEATURE_OPACITY
        UFBX_MATERIAL_FEATURE_AMBIENT_OCCLUSION
        UFBX_MATERIAL_FEATURE_MATTE
        UFBX_MATERIAL_FEATURE_UNLIT
        UFBX_MATERIAL_FEATURE_IOR
        UFBX_MATERIAL_FEATURE_DIFFUSE_ROUGHNESS
        UFBX_MATERIAL_FEATURE_TRANSMISSION_ROUGHNESS
        UFBX_MATERIAL_FEATURE_THIN_WALLED
        UFBX_MATERIAL_FEATURE_CAUSTICS
        UFBX_MATERIAL_FEATURE_EXIT_TO_BACKGROUND
        UFBX_MATERIAL_FEATURE_INTERNAL_REFLECTIONS
        UFBX_MATERIAL_FEATURE_DOUBLE_SIDED
        UFBX_MATERIAL_FEATURE_ROUGHNESS_AS_GLOSSINESS
        UFBX_MATERIAL_FEATURE_COAT_ROUGHNESS_AS_GLOSSINESS
        UFBX_MATERIAL_FEATURE_TRANSMISSION_ROUGHNESS_AS_GLOSSINESS
        UFBX_MATERIAL_FEATURE_FORCE_32BIT

    cpdef enum:
        UFBX_MATERIAL_FEATURE_COUNT

    cdef struct ufbx_material_fbx_maps:
        ufbx_material_map maps[(19) + 1]
        ufbx_material_map diffuse_factor
        ufbx_material_map diffuse_color
        ufbx_material_map specular_factor
        ufbx_material_map specular_color
        ufbx_material_map specular_exponent
        ufbx_material_map reflection_factor
        ufbx_material_map reflection_color
        ufbx_material_map transparency_factor
        ufbx_material_map transparency_color
        ufbx_material_map emission_factor
        ufbx_material_map emission_color
        ufbx_material_map ambient_factor
        ufbx_material_map ambient_color
        ufbx_material_map normal_map
        ufbx_material_map bump
        ufbx_material_map bump_factor
        ufbx_material_map displacement_factor
        ufbx_material_map displacement
        ufbx_material_map vector_displacement_factor
        ufbx_material_map vector_displacement

    cdef struct ufbx_material_pbr_maps:
        ufbx_material_map maps[(55) + 1]
        ufbx_material_map base_factor
        ufbx_material_map base_color
        ufbx_material_map roughness
        ufbx_material_map metalness
        ufbx_material_map diffuse_roughness
        ufbx_material_map specular_factor
        ufbx_material_map specular_color
        ufbx_material_map specular_ior
        ufbx_material_map specular_anisotropy
        ufbx_material_map specular_rotation
        ufbx_material_map transmission_factor
        ufbx_material_map transmission_color
        ufbx_material_map transmission_depth
        ufbx_material_map transmission_scatter
        ufbx_material_map transmission_scatter_anisotropy
        ufbx_material_map transmission_dispersion
        ufbx_material_map transmission_roughness
        ufbx_material_map transmission_extra_roughness
        ufbx_material_map transmission_priority
        ufbx_material_map transmission_enable_in_aov
        ufbx_material_map subsurface_factor
        ufbx_material_map subsurface_color
        ufbx_material_map subsurface_radius
        ufbx_material_map subsurface_scale
        ufbx_material_map subsurface_anisotropy
        ufbx_material_map subsurface_tint_color
        ufbx_material_map subsurface_type
        ufbx_material_map sheen_factor
        ufbx_material_map sheen_color
        ufbx_material_map sheen_roughness
        ufbx_material_map coat_factor
        ufbx_material_map coat_color
        ufbx_material_map coat_roughness
        ufbx_material_map coat_ior
        ufbx_material_map coat_anisotropy
        ufbx_material_map coat_rotation
        ufbx_material_map coat_normal
        ufbx_material_map coat_affect_base_color
        ufbx_material_map coat_affect_base_roughness
        ufbx_material_map thin_film_factor
        ufbx_material_map thin_film_thickness
        ufbx_material_map thin_film_ior
        ufbx_material_map emission_factor
        ufbx_material_map emission_color
        ufbx_material_map opacity
        ufbx_material_map indirect_diffuse
        ufbx_material_map indirect_specular
        ufbx_material_map normal_map
        ufbx_material_map tangent_map
        ufbx_material_map displacement_map
        ufbx_material_map matte_factor
        ufbx_material_map matte_color
        ufbx_material_map ambient_occlusion
        ufbx_material_map glossiness
        ufbx_material_map coat_glossiness
        ufbx_material_map transmission_glossiness

    cdef struct ufbx_material_features:
        ufbx_material_feature_info features[(22) + 1]
        ufbx_material_feature_info pbr
        ufbx_material_feature_info metalness
        ufbx_material_feature_info diffuse
        ufbx_material_feature_info specular
        ufbx_material_feature_info emission
        ufbx_material_feature_info transmission
        ufbx_material_feature_info coat
        ufbx_material_feature_info sheen
        ufbx_material_feature_info opacity
        ufbx_material_feature_info ambient_occlusion
        ufbx_material_feature_info matte
        ufbx_material_feature_info unlit
        ufbx_material_feature_info ior
        ufbx_material_feature_info diffuse_roughness
        ufbx_material_feature_info transmission_roughness
        ufbx_material_feature_info thin_walled
        ufbx_material_feature_info caustics
        ufbx_material_feature_info exit_to_background
        ufbx_material_feature_info internal_reflections
        ufbx_material_feature_info double_sided
        ufbx_material_feature_info roughness_as_glossiness
        ufbx_material_feature_info coat_roughness_as_glossiness
        ufbx_material_feature_info transmission_roughness_as_glossiness

    cdef struct ufbx_material:
        ufbx_material_fbx_maps fbx
        ufbx_material_pbr_maps pbr
        ufbx_material_features features
        ufbx_shader_type shader_type
        ufbx_shader* shader
        ufbx_string shading_model_name
        ufbx_string shader_prop_prefix
        ufbx_material_texture_list textures
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id

    cpdef enum ufbx_texture_type:
        UFBX_TEXTURE_FILE
        UFBX_TEXTURE_LAYERED
        UFBX_TEXTURE_PROCEDURAL
        UFBX_TEXTURE_SHADER
        UFBX_TEXTURE_TYPE_FORCE_32BIT

    cpdef enum:
        UFBX_TEXTURE_TYPE_COUNT

    cpdef enum ufbx_blend_mode:
        UFBX_BLEND_TRANSLUCENT
        UFBX_BLEND_ADDITIVE
        UFBX_BLEND_MULTIPLY
        UFBX_BLEND_MULTIPLY_2X
        UFBX_BLEND_OVER
        UFBX_BLEND_REPLACE
        UFBX_BLEND_DISSOLVE
        UFBX_BLEND_DARKEN
        UFBX_BLEND_COLOR_BURN
        UFBX_BLEND_LINEAR_BURN
        UFBX_BLEND_DARKER_COLOR
        UFBX_BLEND_LIGHTEN
        UFBX_BLEND_SCREEN
        UFBX_BLEND_COLOR_DODGE
        UFBX_BLEND_LINEAR_DODGE
        UFBX_BLEND_LIGHTER_COLOR
        UFBX_BLEND_SOFT_LIGHT
        UFBX_BLEND_HARD_LIGHT
        UFBX_BLEND_VIVID_LIGHT
        UFBX_BLEND_LINEAR_LIGHT
        UFBX_BLEND_PIN_LIGHT
        UFBX_BLEND_HARD_MIX
        UFBX_BLEND_DIFFERENCE
        UFBX_BLEND_EXCLUSION
        UFBX_BLEND_SUBTRACT
        UFBX_BLEND_DIVIDE
        UFBX_BLEND_HUE
        UFBX_BLEND_SATURATION
        UFBX_BLEND_COLOR
        UFBX_BLEND_LUMINOSITY
        UFBX_BLEND_OVERLAY
        UFBX_BLEND_MODE_FORCE_32BIT

    cpdef enum:
        UFBX_BLEND_MODE_COUNT

    cpdef enum ufbx_wrap_mode:
        UFBX_WRAP_REPEAT
        UFBX_WRAP_CLAMP
        UFBX_WRAP_MODE_FORCE_32BIT

    cpdef enum:
        UFBX_WRAP_MODE_COUNT

    cdef struct ufbx_texture_layer:
        ufbx_texture* texture
        ufbx_blend_mode blend_mode
        ufbx_real alpha

    cdef struct ufbx_texture_layer_list:
        ufbx_texture_layer* data
        size_t count

    cpdef enum ufbx_shader_texture_type:
        UFBX_SHADER_TEXTURE_UNKNOWN
        UFBX_SHADER_TEXTURE_SELECT_OUTPUT
        UFBX_SHADER_TEXTURE_OSL
        UFBX_SHADER_TEXTURE_TYPE_FORCE_32BIT

    cpdef enum:
        UFBX_SHADER_TEXTURE_TYPE_COUNT

    cdef struct ufbx_shader_texture_input:
        ufbx_string name
        int64_t value_int
        ufbx_string value_str
        ufbx_blob value_blob
        ufbx_texture* texture
        int64_t texture_output_index
        bool texture_enabled
        ufbx_prop* prop
        ufbx_prop* texture_prop
        ufbx_prop* texture_enabled_prop
        ufbx_real value_real
        ufbx_vec2 value_vec2
        ufbx_vec3 value_vec3
        ufbx_vec4 value_vec4

    cdef struct ufbx_shader_texture_input_list:
        ufbx_shader_texture_input* data
        size_t count

    cdef struct ufbx_shader_texture:
        ufbx_shader_texture_type type
        ufbx_string shader_name
        uint64_t shader_type_id
        ufbx_shader_texture_input_list inputs
        ufbx_string shader_source
        ufbx_blob raw_shader_source
        ufbx_texture* main_texture
        int64_t main_texture_output_index
        ufbx_string prop_prefix

    cdef struct ufbx_texture_file:
        uint32_t index
        ufbx_string filename
        ufbx_string absolute_filename
        ufbx_string relative_filename
        ufbx_blob raw_filename
        ufbx_blob raw_absolute_filename
        ufbx_blob raw_relative_filename
        ufbx_blob content

    cdef struct ufbx_texture_file_list:
        ufbx_texture_file* data
        size_t count

    cdef struct ufbx_texture:
        ufbx_texture_type type
        ufbx_string filename
        ufbx_string absolute_filename
        ufbx_string relative_filename
        ufbx_blob raw_filename
        ufbx_blob raw_absolute_filename
        ufbx_blob raw_relative_filename
        ufbx_blob content
        ufbx_video* video
        uint32_t file_index
        bool has_file
        ufbx_texture_layer_list layers
        ufbx_shader_texture* shader
        ufbx_texture_list file_textures
        ufbx_string uv_set
        ufbx_wrap_mode wrap_u
        ufbx_wrap_mode wrap_v
        bool has_uv_transform
        ufbx_transform uv_transform
        ufbx_matrix texture_to_uv
        ufbx_matrix uv_to_texture
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id

    cdef struct ufbx_video:
        ufbx_string filename
        ufbx_string absolute_filename
        ufbx_string relative_filename
        ufbx_blob raw_filename
        ufbx_blob raw_absolute_filename
        ufbx_blob raw_relative_filename
        ufbx_blob content
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id

    cdef struct ufbx_shader:
        ufbx_shader_type type
        ufbx_shader_binding_list bindings
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id

    cdef struct ufbx_shader_prop_binding:
        ufbx_string shader_prop
        ufbx_string material_prop

    cdef struct ufbx_shader_prop_binding_list:
        ufbx_shader_prop_binding* data
        size_t count

    cdef struct ufbx_shader_binding:
        ufbx_shader_prop_binding_list prop_bindings
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id

    cdef struct ufbx_prop_override:
        uint32_t element_id
        uint32_t _internal_key
        ufbx_string prop_name
        ufbx_vec4 value
        ufbx_string value_str
        int64_t value_int

    cdef struct ufbx_prop_override_list:
        ufbx_prop_override* data
        size_t count

    cdef struct ufbx_transform_override:
        uint32_t node_id
        ufbx_transform transform

    cdef struct ufbx_transform_override_list:
        ufbx_transform_override* data
        size_t count

    cdef struct ufbx_anim:
        double time_begin
        double time_end
        ufbx_anim_layer_list layers
        ufbx_real_list override_layer_weights
        ufbx_prop_override_list prop_overrides
        ufbx_transform_override_list transform_overrides
        bool ignore_connections
        bool custom

    cdef struct ufbx_anim_stack:
        double time_begin
        double time_end
        ufbx_anim_layer_list layers
        ufbx_anim* anim
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id

    cdef struct ufbx_anim_prop:
        ufbx_element* element
        uint32_t _internal_key
        ufbx_string prop_name
        ufbx_anim_value* anim_value

    cdef struct ufbx_anim_prop_list:
        ufbx_anim_prop* data
        size_t count

    cdef struct ufbx_anim_layer:
        ufbx_real weight
        bool weight_is_animated
        bool blended
        bool additive
        bool compose_rotation
        bool compose_scale
        ufbx_anim_value_list anim_values
        ufbx_anim_prop_list anim_props
        ufbx_anim* anim
        uint32_t _min_element_id
        uint32_t _max_element_id
        uint32_t _element_id_bitmask[4]
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id

    cdef struct ufbx_anim_value:
        ufbx_vec3 default_value
        ufbx_anim_curve* curves[3]
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id

    cpdef enum ufbx_interpolation:
        UFBX_INTERPOLATION_CONSTANT_PREV
        UFBX_INTERPOLATION_CONSTANT_NEXT
        UFBX_INTERPOLATION_LINEAR
        UFBX_INTERPOLATION_CUBIC
        UFBX_INTERPOLATION_FORCE_32BIT

    cpdef enum:
        UFBX_INTERPOLATION_COUNT

    cpdef enum ufbx_extrapolation_mode:
        UFBX_EXTRAPOLATION_CONSTANT
        UFBX_EXTRAPOLATION_REPEAT
        UFBX_EXTRAPOLATION_MIRROR
        UFBX_EXTRAPOLATION_SLOPE
        UFBX_EXTRAPOLATION_REPEAT_RELATIVE
        UFBX_EXTRAPOLATION_FORCE_32BIT

    cpdef enum:
        UFBX_EXTRAPOLATION_MODE_COUNT

    cdef struct ufbx_extrapolation:
        ufbx_extrapolation_mode mode
        int32_t repeat_count

    cdef struct ufbx_tangent:
        float dx
        float dy

    cdef struct ufbx_keyframe:
        double time
        ufbx_real value
        ufbx_interpolation interpolation
        ufbx_tangent left
        ufbx_tangent right

    cdef struct ufbx_keyframe_list:
        ufbx_keyframe* data
        size_t count

    cdef struct ufbx_anim_curve:
        ufbx_keyframe_list keyframes
        ufbx_extrapolation pre_extrapolation
        ufbx_extrapolation post_extrapolation
        ufbx_real min_value
        ufbx_real max_value
        double min_time
        double max_time
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id

    cdef struct ufbx_display_layer:
        ufbx_node_list nodes
        bool visible
        bool frozen
        ufbx_vec3 ui_color
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id

    cdef struct ufbx_selection_set:
        ufbx_selection_node_list nodes
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id

    cdef struct ufbx_selection_node:
        ufbx_node* target_node
        ufbx_mesh* target_mesh
        bool include_node
        ufbx_uint32_list vertices
        ufbx_uint32_list edges
        ufbx_uint32_list faces
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id

    cdef struct ufbx_character:
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id

    cpdef enum ufbx_constraint_type:
        UFBX_CONSTRAINT_UNKNOWN
        UFBX_CONSTRAINT_AIM
        UFBX_CONSTRAINT_PARENT
        UFBX_CONSTRAINT_POSITION
        UFBX_CONSTRAINT_ROTATION
        UFBX_CONSTRAINT_SCALE
        UFBX_CONSTRAINT_SINGLE_CHAIN_IK
        UFBX_CONSTRAINT_TYPE_FORCE_32BIT

    cpdef enum:
        UFBX_CONSTRAINT_TYPE_COUNT

    cdef struct ufbx_constraint_target:
        ufbx_node* node
        ufbx_real weight
        ufbx_transform transform

    cdef struct ufbx_constraint_target_list:
        ufbx_constraint_target* data
        size_t count

    cpdef enum ufbx_constraint_aim_up_type:
        UFBX_CONSTRAINT_AIM_UP_SCENE
        UFBX_CONSTRAINT_AIM_UP_TO_NODE
        UFBX_CONSTRAINT_AIM_UP_ALIGN_NODE
        UFBX_CONSTRAINT_AIM_UP_VECTOR
        UFBX_CONSTRAINT_AIM_UP_NONE
        UFBX_CONSTRAINT_AIM_UP_TYPE_FORCE_32BIT

    cpdef enum:
        UFBX_CONSTRAINT_AIM_UP_TYPE_COUNT

    cpdef enum ufbx_constraint_ik_pole_type:
        UFBX_CONSTRAINT_IK_POLE_VECTOR
        UFBX_CONSTRAINT_IK_POLE_NODE
        UFBX_CONSTRAINT_IK_POLE_TYPE_FORCE_32BIT

    cpdef enum:
        UFBX_CONSTRAINT_IK_POLE_TYPE_COUNT

    cdef struct ufbx_constraint:
        ufbx_constraint_type type
        ufbx_string type_name
        ufbx_node* node
        ufbx_constraint_target_list targets
        ufbx_real weight
        bool active
        bool constrain_translation[3]
        bool constrain_rotation[3]
        bool constrain_scale[3]
        ufbx_transform transform_offset
        ufbx_vec3 aim_vector
        ufbx_constraint_aim_up_type aim_up_type
        ufbx_node* aim_up_node
        ufbx_vec3 aim_up_vector
        ufbx_node* ik_effector
        ufbx_node* ik_end_node
        ufbx_vec3 ik_pole_vector
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id

    cdef struct ufbx_audio_layer:
        ufbx_audio_clip_list clips
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id

    cdef struct ufbx_audio_clip:
        ufbx_string filename
        ufbx_string absolute_filename
        ufbx_string relative_filename
        ufbx_blob raw_filename
        ufbx_blob raw_absolute_filename
        ufbx_blob raw_relative_filename
        ufbx_blob content
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id

    cdef struct ufbx_bone_pose:
        ufbx_node* bone_node
        ufbx_matrix bone_to_world
        ufbx_matrix bone_to_parent

    cdef struct ufbx_bone_pose_list:
        ufbx_bone_pose* data
        size_t count

    cdef struct ufbx_pose:
        bool is_bind_pose
        ufbx_bone_pose_list bone_poses
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id

    cdef struct ufbx_metadata_object:
        ufbx_element element
        ufbx_string name
        ufbx_props props
        uint32_t element_id
        uint32_t typed_id

    cdef struct ufbx_name_element:
        ufbx_string name
        ufbx_element_type type
        uint32_t _internal_key
        ufbx_element* element

    cdef struct ufbx_name_element_list:
        ufbx_name_element* data
        size_t count

    cpdef enum ufbx_exporter:
        UFBX_EXPORTER_UNKNOWN
        UFBX_EXPORTER_FBX_SDK
        UFBX_EXPORTER_BLENDER_BINARY
        UFBX_EXPORTER_BLENDER_ASCII
        UFBX_EXPORTER_MOTION_BUILDER
        UFBX_EXPORTER_FORCE_32BIT

    cpdef enum:
        UFBX_EXPORTER_COUNT

    cdef struct ufbx_application:
        ufbx_string vendor
        ufbx_string name
        ufbx_string version

    cpdef enum ufbx_file_format:
        UFBX_FILE_FORMAT_UNKNOWN
        UFBX_FILE_FORMAT_FBX
        UFBX_FILE_FORMAT_OBJ
        UFBX_FILE_FORMAT_MTL
        UFBX_FILE_FORMAT_FORCE_32BIT

    cpdef enum:
        UFBX_FILE_FORMAT_COUNT

    cpdef enum ufbx_warning_type:
        UFBX_WARNING_MISSING_EXTERNAL_FILE
        UFBX_WARNING_IMPLICIT_MTL
        UFBX_WARNING_TRUNCATED_ARRAY
        UFBX_WARNING_MISSING_GEOMETRY_DATA
        UFBX_WARNING_DUPLICATE_CONNECTION
        UFBX_WARNING_BAD_VERTEX_W_ATTRIBUTE
        UFBX_WARNING_MISSING_POLYGON_MAPPING
        UFBX_WARNING_UNSUPPORTED_VERSION
        UFBX_WARNING_INDEX_CLAMPED
        UFBX_WARNING_BAD_UNICODE
        UFBX_WARNING_BAD_BASE64_CONTENT
        UFBX_WARNING_BAD_ELEMENT_CONNECTED_TO_ROOT
        UFBX_WARNING_DUPLICATE_OBJECT_ID
        UFBX_WARNING_EMPTY_FACE_REMOVED
        UFBX_WARNING_UNKNOWN_OBJ_DIRECTIVE
        UFBX_WARNING_TYPE_FIRST_DEDUPLICATED
        UFBX_WARNING_TYPE_FORCE_32BIT

    cpdef enum:
        UFBX_WARNING_TYPE_COUNT

    cdef struct ufbx_warning:
        ufbx_warning_type type
        ufbx_string description
        uint32_t element_id
        size_t count

    cdef struct ufbx_warning_list:
        ufbx_warning* data
        size_t count

    cpdef enum ufbx_thumbnail_format:
        UFBX_THUMBNAIL_FORMAT_UNKNOWN
        UFBX_THUMBNAIL_FORMAT_RGB_24
        UFBX_THUMBNAIL_FORMAT_RGBA_32
        UFBX_THUMBNAIL_FORMAT_FORCE_32BIT

    cpdef enum:
        UFBX_THUMBNAIL_FORMAT_COUNT

    cpdef enum ufbx_space_conversion:
        UFBX_SPACE_CONVERSION_TRANSFORM_ROOT
        UFBX_SPACE_CONVERSION_ADJUST_TRANSFORMS
        UFBX_SPACE_CONVERSION_MODIFY_GEOMETRY
        UFBX_SPACE_CONVERSION_FORCE_32BIT

    cpdef enum:
        UFBX_SPACE_CONVERSION_COUNT

    cpdef enum ufbx_geometry_transform_handling:
        UFBX_GEOMETRY_TRANSFORM_HANDLING_PRESERVE
        UFBX_GEOMETRY_TRANSFORM_HANDLING_HELPER_NODES
        UFBX_GEOMETRY_TRANSFORM_HANDLING_MODIFY_GEOMETRY
        UFBX_GEOMETRY_TRANSFORM_HANDLING_MODIFY_GEOMETRY_NO_FALLBACK
        UFBX_GEOMETRY_TRANSFORM_HANDLING_FORCE_32BIT

    cpdef enum:
        UFBX_GEOMETRY_TRANSFORM_HANDLING_COUNT

    cpdef enum ufbx_inherit_mode_handling:
        UFBX_INHERIT_MODE_HANDLING_PRESERVE
        UFBX_INHERIT_MODE_HANDLING_HELPER_NODES
        UFBX_INHERIT_MODE_HANDLING_COMPENSATE
        UFBX_INHERIT_MODE_HANDLING_COMPENSATE_NO_FALLBACK
        UFBX_INHERIT_MODE_HANDLING_IGNORE
        UFBX_INHERIT_MODE_HANDLING_FORCE_32BIT

    cpdef enum:
        UFBX_INHERIT_MODE_HANDLING_COUNT

    cpdef enum ufbx_pivot_handling:
        UFBX_PIVOT_HANDLING_RETAIN
        UFBX_PIVOT_HANDLING_ADJUST_TO_PIVOT
        UFBX_PIVOT_HANDLING_ADJUST_TO_ROTATION_PIVOT
        UFBX_PIVOT_HANDLING_FORCE_32BIT

    cpdef enum:
        UFBX_PIVOT_HANDLING_COUNT

    cdef struct ufbx_thumbnail:
        ufbx_props props
        uint32_t width
        uint32_t height
        ufbx_thumbnail_format format
        ufbx_blob data

    cdef struct ufbx_metadata:
        ufbx_warning_list warnings
        bool ascii
        uint32_t version
        ufbx_file_format file_format
        bool may_contain_no_index
        bool may_contain_missing_vertex_position
        bool may_contain_broken_elements
        bool is_unsafe
        bool has_warning[(14) + 1]
        ufbx_string creator
        bool big_endian
        ufbx_string filename
        ufbx_string relative_root
        ufbx_blob raw_filename
        ufbx_blob raw_relative_root
        ufbx_exporter exporter
        uint32_t exporter_version
        ufbx_props scene_props
        ufbx_application original_application
        ufbx_application latest_application
        ufbx_thumbnail thumbnail
        bool geometry_ignored
        bool animation_ignored
        bool embedded_ignored
        size_t max_face_triangles
        size_t result_memory_used
        size_t temp_memory_used
        size_t result_allocs
        size_t temp_allocs
        size_t element_buffer_size
        size_t num_shader_textures
        ufbx_real bone_prop_size_unit
        bool bone_prop_limb_length_relative
        ufbx_real ortho_size_unit
        int64_t ktime_second
        ufbx_string original_file_path
        ufbx_blob raw_original_file_path
        ufbx_space_conversion space_conversion
        ufbx_geometry_transform_handling geometry_transform_handling
        ufbx_inherit_mode_handling inherit_mode_handling
        ufbx_pivot_handling pivot_handling
        ufbx_mirror_axis handedness_conversion_axis
        ufbx_quat root_rotation
        ufbx_real root_scale
        ufbx_mirror_axis mirror_axis
        ufbx_real geometry_scale

    cpdef enum ufbx_time_mode:
        UFBX_TIME_MODE_DEFAULT
        UFBX_TIME_MODE_120_FPS
        UFBX_TIME_MODE_100_FPS
        UFBX_TIME_MODE_60_FPS
        UFBX_TIME_MODE_50_FPS
        UFBX_TIME_MODE_48_FPS
        UFBX_TIME_MODE_30_FPS
        UFBX_TIME_MODE_30_FPS_DROP
        UFBX_TIME_MODE_NTSC_DROP_FRAME
        UFBX_TIME_MODE_NTSC_FULL_FRAME
        UFBX_TIME_MODE_PAL
        UFBX_TIME_MODE_24_FPS
        UFBX_TIME_MODE_1000_FPS
        UFBX_TIME_MODE_FILM_FULL_FRAME
        UFBX_TIME_MODE_CUSTOM
        UFBX_TIME_MODE_96_FPS
        UFBX_TIME_MODE_72_FPS
        UFBX_TIME_MODE_59_94_FPS
        UFBX_TIME_MODE_FORCE_32BIT

    cpdef enum:
        UFBX_TIME_MODE_COUNT

    cpdef enum ufbx_time_protocol:
        UFBX_TIME_PROTOCOL_SMPTE
        UFBX_TIME_PROTOCOL_FRAME_COUNT
        UFBX_TIME_PROTOCOL_DEFAULT
        UFBX_TIME_PROTOCOL_FORCE_32BIT

    cpdef enum:
        UFBX_TIME_PROTOCOL_COUNT

    cpdef enum ufbx_snap_mode:
        UFBX_SNAP_MODE_NONE
        UFBX_SNAP_MODE_SNAP
        UFBX_SNAP_MODE_PLAY
        UFBX_SNAP_MODE_SNAP_AND_PLAY
        UFBX_SNAP_MODE_FORCE_32BIT

    cpdef enum:
        UFBX_SNAP_MODE_COUNT

    cdef struct ufbx_scene_settings:
        ufbx_props props
        ufbx_coordinate_axes axes
        ufbx_real unit_meters
        double frames_per_second
        ufbx_vec3 ambient_color
        ufbx_string default_camera
        ufbx_time_mode time_mode
        ufbx_time_protocol time_protocol
        ufbx_snap_mode snap_mode
        ufbx_coordinate_axis original_axis_up
        ufbx_real original_unit_meters

    cdef struct ufbx_scene:
        ufbx_metadata metadata
        ufbx_scene_settings settings
        ufbx_node* root_node
        ufbx_anim* anim
        ufbx_texture_file_list texture_files
        ufbx_element_list elements
        ufbx_connection_list connections_src
        ufbx_connection_list connections_dst
        ufbx_name_element_list elements_by_name
        ufbx_dom_node* dom_root
        ufbx_element_list elements_by_type[(41) + 1]
        ufbx_unknown_list unknowns
        ufbx_node_list nodes
        ufbx_mesh_list meshes
        ufbx_light_list lights
        ufbx_camera_list cameras
        ufbx_bone_list bones
        ufbx_empty_list empties
        ufbx_line_curve_list line_curves
        ufbx_nurbs_curve_list nurbs_curves
        ufbx_nurbs_surface_list nurbs_surfaces
        ufbx_nurbs_trim_surface_list nurbs_trim_surfaces
        ufbx_nurbs_trim_boundary_list nurbs_trim_boundaries
        ufbx_procedural_geometry_list procedural_geometries
        ufbx_stereo_camera_list stereo_cameras
        ufbx_camera_switcher_list camera_switchers
        ufbx_marker_list markers
        ufbx_lod_group_list lod_groups
        ufbx_skin_deformer_list skin_deformers
        ufbx_skin_cluster_list skin_clusters
        ufbx_blend_deformer_list blend_deformers
        ufbx_blend_channel_list blend_channels
        ufbx_blend_shape_list blend_shapes
        ufbx_cache_deformer_list cache_deformers
        ufbx_cache_file_list cache_files
        ufbx_material_list materials
        ufbx_texture_list textures
        ufbx_video_list videos
        ufbx_shader_list shaders
        ufbx_shader_binding_list shader_bindings
        ufbx_anim_stack_list anim_stacks
        ufbx_anim_layer_list anim_layers
        ufbx_anim_value_list anim_values
        ufbx_anim_curve_list anim_curves
        ufbx_display_layer_list display_layers
        ufbx_selection_set_list selection_sets
        ufbx_selection_node_list selection_nodes
        ufbx_character_list characters
        ufbx_constraint_list constraints
        ufbx_audio_layer_list audio_layers
        ufbx_audio_clip_list audio_clips
        ufbx_pose_list poses
        ufbx_metadata_object_list metadata_objects

    cdef struct ufbx_curve_point:
        bool valid
        ufbx_vec3 position
        ufbx_vec3 derivative

    cdef struct ufbx_surface_point:
        bool valid
        ufbx_vec3 position
        ufbx_vec3 derivative_u
        ufbx_vec3 derivative_v

    cpdef enum ufbx_topo_flags:
        UFBX_TOPO_NON_MANIFOLD
        UFBX_TOPO_FLAGS_FORCE_32BIT

    cdef struct ufbx_topo_edge:
        uint32_t index
        uint32_t next
        uint32_t prev
        uint32_t twin
        uint32_t face
        uint32_t edge
        ufbx_topo_flags flags

    cdef struct ufbx_vertex_stream:
        void* data
        size_t vertex_count
        size_t vertex_size

    ctypedef void* ufbx_alloc_fn(void* user, size_t size)

    ctypedef void* ufbx_realloc_fn(void* user, void* old_ptr, size_t old_size, size_t new_size)

    ctypedef void ufbx_free_fn(void* user, void* ptr, size_t size)

    ctypedef void ufbx_free_allocator_fn(void* user)

    cdef struct ufbx_allocator:
        ufbx_alloc_fn* alloc_fn
        ufbx_realloc_fn* realloc_fn
        ufbx_free_fn* free_fn
        ufbx_free_allocator_fn* free_allocator_fn
        void* user

    cdef struct ufbx_allocator_opts:
        ufbx_allocator allocator
        size_t memory_limit
        size_t allocation_limit
        size_t huge_threshold
        size_t max_chunk_size

    ctypedef size_t ufbx_read_fn(void* user, void* data, size_t size)

    ctypedef bool ufbx_skip_fn(void* user, size_t size)

    ctypedef uint64_t ufbx_size_fn(void* user)

    ctypedef void ufbx_close_fn(void* user)

    cdef struct ufbx_stream:
        ufbx_read_fn* read_fn
        ufbx_skip_fn* skip_fn
        ufbx_size_fn* size_fn
        ufbx_close_fn* close_fn
        void* user

    cpdef enum ufbx_open_file_type:
        UFBX_OPEN_FILE_MAIN_MODEL
        UFBX_OPEN_FILE_GEOMETRY_CACHE
        UFBX_OPEN_FILE_OBJ_MTL
        UFBX_OPEN_FILE_TYPE_FORCE_32BIT

    cpdef enum:
        UFBX_OPEN_FILE_TYPE_COUNT

    ctypedef uintptr_t ufbx_open_file_context

    cdef struct ufbx_open_file_info:
        ufbx_open_file_context context
        ufbx_open_file_type type
        ufbx_blob original_filename

    ctypedef bool ufbx_open_file_fn(void* user, ufbx_stream* stream, const char* path, size_t path_len, const ufbx_open_file_info* info)

    cdef struct ufbx_open_file_cb:
        ufbx_open_file_fn* fn
        void* user

    cdef struct ufbx_open_file_opts:
        uint32_t _begin_zero
        ufbx_allocator_opts allocator
        bool filename_null_terminated
        uint32_t _end_zero

    ctypedef void ufbx_close_memory_fn(void* user, void* data, size_t data_size)

    cdef struct ufbx_close_memory_cb:
        ufbx_close_memory_fn* fn
        void* user

    cdef struct ufbx_open_memory_opts:
        uint32_t _begin_zero
        ufbx_allocator_opts allocator
        bool no_copy
        ufbx_close_memory_cb close_cb
        uint32_t _end_zero

    cdef struct ufbx_error_frame:
        uint32_t source_line
        ufbx_string function
        ufbx_string description

    cpdef enum ufbx_error_type:
        UFBX_ERROR_NONE
        UFBX_ERROR_UNKNOWN
        UFBX_ERROR_FILE_NOT_FOUND
        UFBX_ERROR_EMPTY_FILE
        UFBX_ERROR_EXTERNAL_FILE_NOT_FOUND
        UFBX_ERROR_OUT_OF_MEMORY
        UFBX_ERROR_MEMORY_LIMIT
        UFBX_ERROR_ALLOCATION_LIMIT
        UFBX_ERROR_TRUNCATED_FILE
        UFBX_ERROR_IO
        UFBX_ERROR_CANCELLED
        UFBX_ERROR_UNRECOGNIZED_FILE_FORMAT
        UFBX_ERROR_UNINITIALIZED_OPTIONS
        UFBX_ERROR_ZERO_VERTEX_SIZE
        UFBX_ERROR_TRUNCATED_VERTEX_STREAM
        UFBX_ERROR_INVALID_UTF8
        UFBX_ERROR_FEATURE_DISABLED
        UFBX_ERROR_BAD_NURBS
        UFBX_ERROR_BAD_INDEX
        UFBX_ERROR_NODE_DEPTH_LIMIT
        UFBX_ERROR_THREADED_ASCII_PARSE
        UFBX_ERROR_UNSAFE_OPTIONS
        UFBX_ERROR_DUPLICATE_OVERRIDE
        UFBX_ERROR_UNSUPPORTED_VERSION
        UFBX_ERROR_TYPE_FORCE_32BIT

    cpdef enum:
        UFBX_ERROR_TYPE_COUNT

    cdef struct ufbx_error:
        ufbx_error_type type
        ufbx_string description
        uint32_t stack_size
        ufbx_error_frame stack[8]
        size_t info_length
        char info[256]

    cdef struct ufbx_progress:
        uint64_t bytes_read
        uint64_t bytes_total

    cpdef enum ufbx_progress_result:
        UFBX_PROGRESS_CONTINUE
        UFBX_PROGRESS_CANCEL
        UFBX_PROGRESS_RESULT_FORCE_32BIT

    ctypedef ufbx_progress_result ufbx_progress_fn(void* user, const ufbx_progress* progress)

    cdef struct ufbx_progress_cb:
        ufbx_progress_fn* fn
        void* user

    cdef struct ufbx_inflate_input:
        size_t total_size
        const void* data
        size_t data_size
        void* buffer
        size_t buffer_size
        ufbx_read_fn* read_fn
        void* read_user
        ufbx_progress_cb progress_cb
        uint64_t progress_interval_hint
        uint64_t progress_size_before
        uint64_t progress_size_after
        bool no_header
        bool no_checksum
        size_t internal_fast_bits

    cdef struct ufbx_inflate_retain:
        bool initialized
        uint64_t data[1024]

    cpdef enum ufbx_index_error_handling:
        UFBX_INDEX_ERROR_HANDLING_CLAMP
        UFBX_INDEX_ERROR_HANDLING_NO_INDEX
        UFBX_INDEX_ERROR_HANDLING_ABORT_LOADING
        UFBX_INDEX_ERROR_HANDLING_UNSAFE_IGNORE
        UFBX_INDEX_ERROR_HANDLING_FORCE_32BIT

    cpdef enum:
        UFBX_INDEX_ERROR_HANDLING_COUNT

    cpdef enum ufbx_unicode_error_handling:
        UFBX_UNICODE_ERROR_HANDLING_REPLACEMENT_CHARACTER
        UFBX_UNICODE_ERROR_HANDLING_UNDERSCORE
        UFBX_UNICODE_ERROR_HANDLING_QUESTION_MARK
        UFBX_UNICODE_ERROR_HANDLING_REMOVE
        UFBX_UNICODE_ERROR_HANDLING_ABORT_LOADING
        UFBX_UNICODE_ERROR_HANDLING_UNSAFE_IGNORE
        UFBX_UNICODE_ERROR_HANDLING_FORCE_32BIT

    cpdef enum:
        UFBX_UNICODE_ERROR_HANDLING_COUNT

    cpdef enum ufbx_baked_key_flags:
        UFBX_BAKED_KEY_STEP_LEFT
        UFBX_BAKED_KEY_STEP_RIGHT
        UFBX_BAKED_KEY_STEP_KEY
        UFBX_BAKED_KEY_KEYFRAME
        UFBX_BAKED_KEY_REDUCED
        UFBX_BAKED_KEY_FORCE_32BIT

    cdef struct ufbx_baked_vec3:
        double time
        ufbx_vec3 value
        ufbx_baked_key_flags flags

    cdef struct ufbx_baked_vec3_list:
        ufbx_baked_vec3* data
        size_t count

    cdef struct ufbx_baked_quat:
        double time
        ufbx_quat value
        ufbx_baked_key_flags flags

    cdef struct ufbx_baked_quat_list:
        ufbx_baked_quat* data
        size_t count

    cdef struct ufbx_baked_node:
        uint32_t typed_id
        uint32_t element_id
        bool constant_translation
        bool constant_rotation
        bool constant_scale
        ufbx_baked_vec3_list translation_keys
        ufbx_baked_quat_list rotation_keys
        ufbx_baked_vec3_list scale_keys

    cdef struct ufbx_baked_node_list:
        ufbx_baked_node* data
        size_t count

    cdef struct ufbx_baked_prop:
        ufbx_string name
        bool constant_value
        ufbx_baked_vec3_list keys

    cdef struct ufbx_baked_prop_list:
        ufbx_baked_prop* data
        size_t count

    cdef struct ufbx_baked_element:
        uint32_t element_id
        ufbx_baked_prop_list props

    cdef struct ufbx_baked_element_list:
        ufbx_baked_element* data
        size_t count

    cdef struct ufbx_baked_anim_metadata:
        size_t result_memory_used
        size_t temp_memory_used
        size_t result_allocs
        size_t temp_allocs

    cdef struct ufbx_baked_anim:
        ufbx_baked_node_list nodes
        ufbx_baked_element_list elements
        double playback_time_begin
        double playback_time_end
        double playback_duration
        double key_time_min
        double key_time_max
        ufbx_baked_anim_metadata metadata

    ctypedef uintptr_t ufbx_thread_pool_context

    cdef struct ufbx_thread_pool_info:
        uint32_t max_concurrent_tasks

    ctypedef bool ufbx_thread_pool_init_fn(void* user, ufbx_thread_pool_context ctx, const ufbx_thread_pool_info* info)

    ctypedef void ufbx_thread_pool_run_fn(void* user, ufbx_thread_pool_context ctx, uint32_t group, uint32_t start_index, uint32_t count)

    ctypedef void ufbx_thread_pool_wait_fn(void* user, ufbx_thread_pool_context ctx, uint32_t group, uint32_t max_index)

    ctypedef void ufbx_thread_pool_free_fn(void* user, ufbx_thread_pool_context ctx)

    cdef struct ufbx_thread_pool:
        ufbx_thread_pool_init_fn* init_fn
        ufbx_thread_pool_run_fn* run_fn
        ufbx_thread_pool_wait_fn* wait_fn
        ufbx_thread_pool_free_fn* free_fn
        void* user

    cdef struct ufbx_thread_opts:
        ufbx_thread_pool pool
        size_t num_tasks
        size_t memory_limit

    cpdef enum ufbx_evaluate_flags:
        UFBX_EVALUATE_FLAG_NO_EXTRAPOLATION
        ufbx_evaluate_flags_FORCE_32BIT

    cdef struct ufbx_load_opts:
        uint32_t _begin_zero
        ufbx_allocator_opts temp_allocator
        ufbx_allocator_opts result_allocator
        ufbx_thread_opts thread_opts
        bool ignore_geometry
        bool ignore_animation
        bool ignore_embedded
        bool ignore_all_content
        bool evaluate_skinning
        bool evaluate_caches
        bool load_external_files
        bool ignore_missing_external_files
        bool skip_skin_vertices
        bool skip_mesh_parts
        bool clean_skin_weights
        bool use_blender_pbr_material
        bool disable_quirks
        bool strict
        bool force_single_thread_ascii_parsing
        bool allow_unsafe
        ufbx_index_error_handling index_error_handling
        bool connect_broken_elements
        bool allow_nodes_out_of_root
        bool allow_missing_vertex_position
        bool allow_empty_faces
        bool generate_missing_normals
        bool open_main_file_with_default
        char path_separator
        uint32_t node_depth_limit
        uint64_t file_size_estimate
        size_t read_buffer_size
        ufbx_string filename
        ufbx_blob raw_filename
        ufbx_progress_cb progress_cb
        uint64_t progress_interval_hint
        ufbx_open_file_cb open_file_cb
        ufbx_geometry_transform_handling geometry_transform_handling
        ufbx_inherit_mode_handling inherit_mode_handling
        ufbx_space_conversion space_conversion
        ufbx_pivot_handling pivot_handling
        bool pivot_handling_retain_empties
        ufbx_mirror_axis handedness_conversion_axis
        bool handedness_conversion_retain_winding
        bool reverse_winding
        ufbx_coordinate_axes target_axes
        ufbx_real target_unit_meters
        ufbx_coordinate_axes target_camera_axes
        ufbx_coordinate_axes target_light_axes
        ufbx_string geometry_transform_helper_name
        ufbx_string scale_helper_name
        bool normalize_normals
        bool normalize_tangents
        bool use_root_transform
        ufbx_transform root_transform
        double key_clamp_threshold
        ufbx_unicode_error_handling unicode_error_handling
        bool retain_vertex_attrib_w
        bool retain_dom
        ufbx_file_format file_format
        size_t file_format_lookahead
        bool no_format_from_content
        bool no_format_from_extension
        bool obj_search_mtl_by_filename
        bool obj_merge_objects
        bool obj_merge_groups
        bool obj_split_groups
        ufbx_string obj_mtl_path
        ufbx_blob obj_mtl_data
        ufbx_real obj_unit_meters
        ufbx_coordinate_axes obj_axes
        uint32_t _end_zero

    cdef struct ufbx_evaluate_opts:
        uint32_t _begin_zero
        ufbx_allocator_opts temp_allocator
        ufbx_allocator_opts result_allocator
        bool evaluate_skinning
        bool evaluate_caches
        uint32_t evaluate_flags
        bool load_external_files
        ufbx_open_file_cb open_file_cb
        uint32_t _end_zero

    cdef struct ufbx_const_uint32_list:
        const uint32_t* data
        size_t count

    cdef struct ufbx_const_real_list:
        const ufbx_real* data
        size_t count

    cdef struct ufbx_prop_override_desc:
        uint32_t element_id
        ufbx_string prop_name
        ufbx_vec4 value
        ufbx_string value_str
        int64_t value_int

    cdef struct ufbx_const_prop_override_desc_list:
        const ufbx_prop_override_desc* data
        size_t count

    cdef struct ufbx_const_transform_override_list:
        const ufbx_transform_override* data
        size_t count

    cdef struct ufbx_anim_opts:
        uint32_t _begin_zero
        ufbx_const_uint32_list layer_ids
        ufbx_const_real_list override_layer_weights
        ufbx_const_prop_override_desc_list prop_overrides
        ufbx_const_transform_override_list transform_overrides
        bool ignore_connections
        ufbx_allocator_opts result_allocator
        uint32_t _end_zero

    cpdef enum ufbx_bake_step_handling:
        UFBX_BAKE_STEP_HANDLING_DEFAULT
        UFBX_BAKE_STEP_HANDLING_CUSTOM_DURATION
        UFBX_BAKE_STEP_HANDLING_IDENTICAL_TIME
        UFBX_BAKE_STEP_HANDLING_ADJACENT_DOUBLE
        UFBX_BAKE_STEP_HANDLING_IGNORE
        ufbx_bake_step_handling_FORCE_32BIT

    cpdef enum:
        UFBX_BAKE_STEP_HANDLING_COUNT

    cdef struct ufbx_bake_opts:
        uint32_t _begin_zero
        ufbx_allocator_opts temp_allocator
        ufbx_allocator_opts result_allocator
        bool trim_start_time
        double resample_rate
        double minimum_sample_rate
        double maximum_sample_rate
        bool bake_transform_props
        bool skip_node_transforms
        bool no_resample_rotation
        bool ignore_layer_weight_animation
        size_t max_keyframe_segments
        ufbx_bake_step_handling step_handling
        double step_custom_duration
        double step_custom_epsilon
        uint32_t evaluate_flags
        bool key_reduction_enabled
        bool key_reduction_rotation
        double key_reduction_threshold
        size_t key_reduction_passes
        uint32_t _end_zero

    cdef struct ufbx_tessellate_curve_opts:
        uint32_t _begin_zero
        ufbx_allocator_opts temp_allocator
        ufbx_allocator_opts result_allocator
        size_t span_subdivision
        uint32_t _end_zero

    cdef struct ufbx_tessellate_surface_opts:
        uint32_t _begin_zero
        ufbx_allocator_opts temp_allocator
        ufbx_allocator_opts result_allocator
        size_t span_subdivision_u
        size_t span_subdivision_v
        bool skip_mesh_parts
        uint32_t _end_zero

    cdef struct ufbx_subdivide_opts:
        uint32_t _begin_zero
        ufbx_allocator_opts temp_allocator
        ufbx_allocator_opts result_allocator
        ufbx_subdivision_boundary boundary
        ufbx_subdivision_boundary uv_boundary
        bool ignore_normals
        bool interpolate_normals
        bool interpolate_tangents
        bool evaluate_source_vertices
        size_t max_source_vertices
        bool evaluate_skin_weights
        size_t max_skin_weights
        size_t skin_deformer_index
        uint32_t _end_zero

    cdef struct ufbx_geometry_cache_opts:
        uint32_t _begin_zero
        ufbx_allocator_opts temp_allocator
        ufbx_allocator_opts result_allocator
        ufbx_open_file_cb open_file_cb
        double frames_per_second
        ufbx_mirror_axis mirror_axis
        bool use_scale_factor
        ufbx_real scale_factor
        uint32_t _end_zero

    cdef struct ufbx_geometry_cache_data_opts:
        uint32_t _begin_zero
        ufbx_open_file_cb open_file_cb
        bool additive
        bool use_weight
        ufbx_real weight
        bool ignore_transform
        uint32_t _end_zero

    cdef struct ufbx_panic:
        bool did_panic
        size_t message_length
        char message[128]

    const ufbx_string ufbx_empty_string

    const ufbx_blob ufbx_empty_blob

    const ufbx_matrix ufbx_identity_matrix

    const ufbx_transform ufbx_identity_transform

    const ufbx_vec2 ufbx_zero_vec2

    const ufbx_vec3 ufbx_zero_vec3

    const ufbx_vec4 ufbx_zero_vec4

    const ufbx_quat ufbx_identity_quat

    const ufbx_coordinate_axes ufbx_axes_right_handed_y_up

    const ufbx_coordinate_axes ufbx_axes_right_handed_z_up

    const ufbx_coordinate_axes ufbx_axes_left_handed_y_up

    const ufbx_coordinate_axes ufbx_axes_left_handed_z_up

    const size_t ufbx_element_type_size[(41) + 1]

    const uint32_t ufbx_source_version

    bool ufbx_is_thread_safe()

    ufbx_scene* ufbx_load_memory(const void* data, size_t data_size, const ufbx_load_opts* opts, ufbx_error* error)

    ufbx_scene* ufbx_load_file(const char* filename, const ufbx_load_opts* opts, ufbx_error* error)

    ufbx_scene* ufbx_load_file_len(const char* filename, size_t filename_len, const ufbx_load_opts* opts, ufbx_error* error)

    ufbx_scene* ufbx_load_stdio(void* file, const ufbx_load_opts* opts, ufbx_error* error)

    ufbx_scene* ufbx_load_stdio_prefix(void* file, const void* prefix, size_t prefix_size, const ufbx_load_opts* opts, ufbx_error* error)

    ufbx_scene* ufbx_load_stream(const ufbx_stream* stream, const ufbx_load_opts* opts, ufbx_error* error)

    ufbx_scene* ufbx_load_stream_prefix(const ufbx_stream* stream, const void* prefix, size_t prefix_size, const ufbx_load_opts* opts, ufbx_error* error)

    void ufbx_free_scene(ufbx_scene* scene)

    void ufbx_retain_scene(ufbx_scene* scene)

    size_t ufbx_format_error(char* dst, size_t dst_size, const ufbx_error* error)

    ufbx_prop* ufbx_find_prop_len(const ufbx_props* props, const char* name, size_t name_len)

    ufbx_prop* ufbx_find_prop(const ufbx_props* props, const char* name)

    ufbx_real ufbx_find_real_len(const ufbx_props* props, const char* name, size_t name_len, ufbx_real def_)

    ufbx_real ufbx_find_real(const ufbx_props* props, const char* name, ufbx_real def_)

    ufbx_vec3 ufbx_find_vec3_len(const ufbx_props* props, const char* name, size_t name_len, ufbx_vec3 def_)

    ufbx_vec3 ufbx_find_vec3(const ufbx_props* props, const char* name, ufbx_vec3 def_)

    int64_t ufbx_find_int_len(const ufbx_props* props, const char* name, size_t name_len, int64_t def_)

    int64_t ufbx_find_int(const ufbx_props* props, const char* name, int64_t def_)

    bool ufbx_find_bool_len(const ufbx_props* props, const char* name, size_t name_len, bool def_)

    bool ufbx_find_bool(const ufbx_props* props, const char* name, bool def_)

    ufbx_string ufbx_find_string_len(const ufbx_props* props, const char* name, size_t name_len, ufbx_string def_)

    ufbx_string ufbx_find_string(const ufbx_props* props, const char* name, ufbx_string def_)

    ufbx_blob ufbx_find_blob_len(const ufbx_props* props, const char* name, size_t name_len, ufbx_blob def_)

    ufbx_blob ufbx_find_blob(const ufbx_props* props, const char* name, ufbx_blob def_)

    ufbx_prop* ufbx_find_prop_concat(const ufbx_props* props, const ufbx_string* parts, size_t num_parts)

    ufbx_element* ufbx_get_prop_element(const ufbx_element* element, const ufbx_prop* prop, ufbx_element_type type)

    ufbx_element* ufbx_find_prop_element_len(const ufbx_element* element, const char* name, size_t name_len, ufbx_element_type type)

    ufbx_element* ufbx_find_prop_element(const ufbx_element* element, const char* name, ufbx_element_type type)

    ufbx_element* ufbx_find_element_len(const ufbx_scene* scene, ufbx_element_type type, const char* name, size_t name_len)

    ufbx_element* ufbx_find_element(const ufbx_scene* scene, ufbx_element_type type, const char* name)

    ufbx_node* ufbx_find_node_len(const ufbx_scene* scene, const char* name, size_t name_len)

    ufbx_node* ufbx_find_node(const ufbx_scene* scene, const char* name)

    ufbx_anim_stack* ufbx_find_anim_stack_len(const ufbx_scene* scene, const char* name, size_t name_len)

    ufbx_anim_stack* ufbx_find_anim_stack(const ufbx_scene* scene, const char* name)

    ufbx_material* ufbx_find_material_len(const ufbx_scene* scene, const char* name, size_t name_len)

    ufbx_material* ufbx_find_material(const ufbx_scene* scene, const char* name)

    ufbx_anim_prop* ufbx_find_anim_prop_len(const ufbx_anim_layer* layer, const ufbx_element* element, const char* prop, size_t prop_len)

    ufbx_anim_prop* ufbx_find_anim_prop(const ufbx_anim_layer* layer, const ufbx_element* element, const char* prop)

    ufbx_anim_prop_list ufbx_find_anim_props(const ufbx_anim_layer* layer, const ufbx_element* element)

    ufbx_matrix ufbx_get_compatible_matrix_for_normals(const ufbx_node* node)

    ptrdiff_t ufbx_inflate(void* dst, size_t dst_size, const ufbx_inflate_input* input, ufbx_inflate_retain* retain)

    bool ufbx_default_open_file(void* user, ufbx_stream* stream, const char* path, size_t path_len, const ufbx_open_file_info* info)

    bool ufbx_open_file(ufbx_stream* stream, const char* path, size_t path_len, const ufbx_open_file_opts* opts, ufbx_error* error)

    bool ufbx_open_file_ctx(ufbx_stream* stream, ufbx_open_file_context ctx, const char* path, size_t path_len, const ufbx_open_file_opts* opts, ufbx_error* error)

    bool ufbx_open_memory(ufbx_stream* stream, const void* data, size_t data_size, const ufbx_open_memory_opts* opts, ufbx_error* error)

    bool ufbx_open_memory_ctx(ufbx_stream* stream, ufbx_open_file_context ctx, const void* data, size_t data_size, const ufbx_open_memory_opts* opts, ufbx_error* error)

    ufbx_real ufbx_evaluate_curve(const ufbx_anim_curve* curve, double time, ufbx_real default_value)

    ufbx_real ufbx_evaluate_curve_flags(const ufbx_anim_curve* curve, double time, ufbx_real default_value, uint32_t flags)

    ufbx_real ufbx_evaluate_anim_value_real(const ufbx_anim_value* anim_value, double time)

    ufbx_vec3 ufbx_evaluate_anim_value_vec3(const ufbx_anim_value* anim_value, double time)

    ufbx_real ufbx_evaluate_anim_value_real_flags(const ufbx_anim_value* anim_value, double time, uint32_t flags)

    ufbx_vec3 ufbx_evaluate_anim_value_vec3_flags(const ufbx_anim_value* anim_value, double time, uint32_t flags)

    ufbx_prop ufbx_evaluate_prop_len(const ufbx_anim* anim, const ufbx_element* element, const char* name, size_t name_len, double time)

    ufbx_prop ufbx_evaluate_prop(const ufbx_anim* anim, const ufbx_element* element, const char* name, double time)

    ufbx_prop ufbx_evaluate_prop_flags_len(const ufbx_anim* anim, const ufbx_element* element, const char* name, size_t name_len, double time, uint32_t flags)

    ufbx_prop ufbx_evaluate_prop_flags(const ufbx_anim* anim, const ufbx_element* element, const char* name, double time, uint32_t flags)

    ufbx_props ufbx_evaluate_props(const ufbx_anim* anim, const ufbx_element* element, double time, ufbx_prop* buffer, size_t buffer_size)

    ufbx_props ufbx_evaluate_props_flags(const ufbx_anim* anim, const ufbx_element* element, double time, ufbx_prop* buffer, size_t buffer_size, uint32_t flags)

    cpdef enum ufbx_transform_flags:
        UFBX_TRANSFORM_FLAG_IGNORE_SCALE_HELPER
        UFBX_TRANSFORM_FLAG_IGNORE_COMPONENTWISE_SCALE
        UFBX_TRANSFORM_FLAG_EXPLICIT_INCLUDES
        UFBX_TRANSFORM_FLAG_INCLUDE_TRANSLATION
        UFBX_TRANSFORM_FLAG_INCLUDE_ROTATION
        UFBX_TRANSFORM_FLAG_INCLUDE_SCALE
        UFBX_TRANSFORM_FLAG_NO_EXTRAPOLATION
        UFBX_TRANSFORM_FLAGS_FORCE_32BIT

    ufbx_transform ufbx_evaluate_transform(const ufbx_anim* anim, const ufbx_node* node, double time)

    ufbx_transform ufbx_evaluate_transform_flags(const ufbx_anim* anim, const ufbx_node* node, double time, uint32_t flags)

    ufbx_real ufbx_evaluate_blend_weight(const ufbx_anim* anim, const ufbx_blend_channel* channel, double time)

    ufbx_real ufbx_evaluate_blend_weight_flags(const ufbx_anim* anim, const ufbx_blend_channel* channel, double time, uint32_t flags)

    ufbx_scene* ufbx_evaluate_scene(const ufbx_scene* scene, const ufbx_anim* anim, double time, const ufbx_evaluate_opts* opts, ufbx_error* error)

    ufbx_anim* ufbx_create_anim(const ufbx_scene* scene, const ufbx_anim_opts* opts, ufbx_error* error)

    void ufbx_free_anim(ufbx_anim* anim)

    void ufbx_retain_anim(ufbx_anim* anim)

    ufbx_baked_anim* ufbx_bake_anim(const ufbx_scene* scene, const ufbx_anim* anim, const ufbx_bake_opts* opts, ufbx_error* error)

    void ufbx_retain_baked_anim(ufbx_baked_anim* bake)

    void ufbx_free_baked_anim(ufbx_baked_anim* bake)

    ufbx_baked_node* ufbx_find_baked_node_by_typed_id(ufbx_baked_anim* bake, uint32_t typed_id)

    ufbx_baked_node* ufbx_find_baked_node(ufbx_baked_anim* bake, ufbx_node* node)

    ufbx_baked_element* ufbx_find_baked_element_by_element_id(ufbx_baked_anim* bake, uint32_t element_id)

    ufbx_baked_element* ufbx_find_baked_element(ufbx_baked_anim* bake, ufbx_element* element)

    ufbx_vec3 ufbx_evaluate_baked_vec3(ufbx_baked_vec3_list keyframes, double time)

    ufbx_quat ufbx_evaluate_baked_quat(ufbx_baked_quat_list keyframes, double time)

    ufbx_bone_pose* ufbx_get_bone_pose(const ufbx_pose* pose, const ufbx_node* node)

    ufbx_texture* ufbx_find_prop_texture_len(const ufbx_material* material, const char* name, size_t name_len)

    ufbx_texture* ufbx_find_prop_texture(const ufbx_material* material, const char* name)

    ufbx_string ufbx_find_shader_prop_len(const ufbx_shader* shader, const char* name, size_t name_len)

    ufbx_string ufbx_find_shader_prop(const ufbx_shader* shader, const char* name)

    ufbx_shader_prop_binding_list ufbx_find_shader_prop_bindings_len(const ufbx_shader* shader, const char* name, size_t name_len)

    ufbx_shader_prop_binding_list ufbx_find_shader_prop_bindings(const ufbx_shader* shader, const char* name)

    ufbx_shader_texture_input* ufbx_find_shader_texture_input_len(const ufbx_shader_texture* shader, const char* name, size_t name_len)

    ufbx_shader_texture_input* ufbx_find_shader_texture_input(const ufbx_shader_texture* shader, const char* name)

    bool ufbx_coordinate_axes_valid(ufbx_coordinate_axes axes)

    ufbx_vec3 ufbx_vec3_normalize(ufbx_vec3 v)

    ufbx_real ufbx_quat_dot(ufbx_quat a, ufbx_quat b)

    ufbx_quat ufbx_quat_mul(ufbx_quat a, ufbx_quat b)

    ufbx_quat ufbx_quat_normalize(ufbx_quat q)

    ufbx_quat ufbx_quat_fix_antipodal(ufbx_quat q, ufbx_quat reference)

    ufbx_quat ufbx_quat_slerp(ufbx_quat a, ufbx_quat b, ufbx_real t)

    ufbx_vec3 ufbx_quat_rotate_vec3(ufbx_quat q, ufbx_vec3 v)

    ufbx_vec3 ufbx_quat_to_euler(ufbx_quat q, ufbx_rotation_order order)

    ufbx_quat ufbx_euler_to_quat(ufbx_vec3 v, ufbx_rotation_order order)

    ufbx_matrix ufbx_matrix_mul(const ufbx_matrix* a, const ufbx_matrix* b)

    ufbx_real ufbx_matrix_determinant(const ufbx_matrix* m)

    ufbx_matrix ufbx_matrix_invert(const ufbx_matrix* m)

    ufbx_matrix ufbx_matrix_for_normals(const ufbx_matrix* m)

    ufbx_vec3 ufbx_transform_position(const ufbx_matrix* m, ufbx_vec3 v)

    ufbx_vec3 ufbx_transform_direction(const ufbx_matrix* m, ufbx_vec3 v)

    ufbx_matrix ufbx_transform_to_matrix(const ufbx_transform* t)

    ufbx_transform ufbx_matrix_to_transform(const ufbx_matrix* m)

    ufbx_matrix ufbx_catch_get_skin_vertex_matrix(ufbx_panic* panic, const ufbx_skin_deformer* skin, size_t vertex, const ufbx_matrix* fallback)

    ufbx_matrix ufbx_get_skin_vertex_matrix(const ufbx_skin_deformer* skin, size_t vertex, const ufbx_matrix* fallback)

    uint32_t ufbx_get_blend_shape_offset_index(const ufbx_blend_shape* shape, size_t vertex)

    ufbx_vec3 ufbx_get_blend_shape_vertex_offset(const ufbx_blend_shape* shape, size_t vertex)

    ufbx_vec3 ufbx_get_blend_vertex_offset(const ufbx_blend_deformer* blend, size_t vertex)

    void ufbx_add_blend_shape_vertex_offsets(const ufbx_blend_shape* shape, ufbx_vec3* vertices, size_t num_vertices, ufbx_real weight)

    void ufbx_add_blend_vertex_offsets(const ufbx_blend_deformer* blend, ufbx_vec3* vertices, size_t num_vertices, ufbx_real weight)

    size_t ufbx_evaluate_nurbs_basis(const ufbx_nurbs_basis* basis, ufbx_real u, ufbx_real* weights, size_t num_weights, ufbx_real* derivatives, size_t num_derivatives)

    ufbx_curve_point ufbx_evaluate_nurbs_curve(const ufbx_nurbs_curve* curve, ufbx_real u)

    ufbx_surface_point ufbx_evaluate_nurbs_surface(const ufbx_nurbs_surface* surface, ufbx_real u, ufbx_real v)

    ufbx_line_curve* ufbx_tessellate_nurbs_curve(const ufbx_nurbs_curve* curve, const ufbx_tessellate_curve_opts* opts, ufbx_error* error)

    ufbx_mesh* ufbx_tessellate_nurbs_surface(const ufbx_nurbs_surface* surface, const ufbx_tessellate_surface_opts* opts, ufbx_error* error)

    void ufbx_free_line_curve(ufbx_line_curve* curve)

    void ufbx_retain_line_curve(ufbx_line_curve* curve)

    uint32_t ufbx_find_face_index(ufbx_mesh* mesh, size_t index)

    uint32_t ufbx_catch_triangulate_face(ufbx_panic* panic, uint32_t* indices, size_t num_indices, const ufbx_mesh* mesh, ufbx_face face)

    uint32_t ufbx_triangulate_face(uint32_t* indices, size_t num_indices, const ufbx_mesh* mesh, ufbx_face face)

    void ufbx_catch_compute_topology(ufbx_panic* panic, const ufbx_mesh* mesh, ufbx_topo_edge* topo, size_t num_topo)

    void ufbx_compute_topology(const ufbx_mesh* mesh, ufbx_topo_edge* topo, size_t num_topo)

    uint32_t ufbx_catch_topo_next_vertex_edge(ufbx_panic* panic, const ufbx_topo_edge* topo, size_t num_topo, uint32_t index)

    uint32_t ufbx_topo_next_vertex_edge(const ufbx_topo_edge* topo, size_t num_topo, uint32_t index)

    uint32_t ufbx_catch_topo_prev_vertex_edge(ufbx_panic* panic, const ufbx_topo_edge* topo, size_t num_topo, uint32_t index)

    uint32_t ufbx_topo_prev_vertex_edge(const ufbx_topo_edge* topo, size_t num_topo, uint32_t index)

    ufbx_vec3 ufbx_catch_get_weighted_face_normal(ufbx_panic* panic, const ufbx_vertex_vec3* positions, ufbx_face face)

    ufbx_vec3 ufbx_get_weighted_face_normal(const ufbx_vertex_vec3* positions, ufbx_face face)

    size_t ufbx_catch_generate_normal_mapping(ufbx_panic* panic, const ufbx_mesh* mesh, const ufbx_topo_edge* topo, size_t num_topo, uint32_t* normal_indices, size_t num_normal_indices, bool assume_smooth)

    size_t ufbx_generate_normal_mapping(const ufbx_mesh* mesh, const ufbx_topo_edge* topo, size_t num_topo, uint32_t* normal_indices, size_t num_normal_indices, bool assume_smooth)

    void ufbx_catch_compute_normals(ufbx_panic* panic, const ufbx_mesh* mesh, const ufbx_vertex_vec3* positions, const uint32_t* normal_indices, size_t num_normal_indices, ufbx_vec3* normals, size_t num_normals)

    void ufbx_compute_normals(const ufbx_mesh* mesh, const ufbx_vertex_vec3* positions, const uint32_t* normal_indices, size_t num_normal_indices, ufbx_vec3* normals, size_t num_normals)

    ufbx_mesh* ufbx_subdivide_mesh(const ufbx_mesh* mesh, size_t level, const ufbx_subdivide_opts* opts, ufbx_error* error)

    void ufbx_free_mesh(ufbx_mesh* mesh)

    void ufbx_retain_mesh(ufbx_mesh* mesh)

    ufbx_geometry_cache* ufbx_load_geometry_cache(const char* filename, const ufbx_geometry_cache_opts* opts, ufbx_error* error)

    ufbx_geometry_cache* ufbx_load_geometry_cache_len(const char* filename, size_t filename_len, const ufbx_geometry_cache_opts* opts, ufbx_error* error)

    void ufbx_free_geometry_cache(ufbx_geometry_cache* cache)

    void ufbx_retain_geometry_cache(ufbx_geometry_cache* cache)

    size_t ufbx_read_geometry_cache_real(const ufbx_cache_frame* frame, ufbx_real* data, size_t num_data, const ufbx_geometry_cache_data_opts* opts)

    size_t ufbx_read_geometry_cache_vec3(const ufbx_cache_frame* frame, ufbx_vec3* data, size_t num_data, const ufbx_geometry_cache_data_opts* opts)

    size_t ufbx_sample_geometry_cache_real(const ufbx_cache_channel* channel, double time, ufbx_real* data, size_t num_data, const ufbx_geometry_cache_data_opts* opts)

    size_t ufbx_sample_geometry_cache_vec3(const ufbx_cache_channel* channel, double time, ufbx_vec3* data, size_t num_data, const ufbx_geometry_cache_data_opts* opts)

    ufbx_dom_node* ufbx_dom_find_len(const ufbx_dom_node* parent, const char* name, size_t name_len)

    ufbx_dom_node* ufbx_dom_find(const ufbx_dom_node* parent, const char* name)

    size_t ufbx_generate_indices(const ufbx_vertex_stream* streams, size_t num_streams, uint32_t* indices, size_t num_indices, const ufbx_allocator_opts* allocator, ufbx_error* error)

    void ufbx_thread_pool_run_task(ufbx_thread_pool_context ctx, uint32_t index)

    void ufbx_thread_pool_set_user_ptr(ufbx_thread_pool_context ctx, void* user_ptr)

    void* ufbx_thread_pool_get_user_ptr(ufbx_thread_pool_context ctx)

    ufbx_real ufbx_catch_get_vertex_real(ufbx_panic* panic, const ufbx_vertex_real* v, size_t index)

    ufbx_vec2 ufbx_catch_get_vertex_vec2(ufbx_panic* panic, const ufbx_vertex_vec2* v, size_t index)

    ufbx_vec3 ufbx_catch_get_vertex_vec3(ufbx_panic* panic, const ufbx_vertex_vec3* v, size_t index)

    ufbx_vec4 ufbx_catch_get_vertex_vec4(ufbx_panic* panic, const ufbx_vertex_vec4* v, size_t index)

    ufbx_real ufbx_get_vertex_real(const ufbx_vertex_real* v, size_t index)

    ufbx_vec2 ufbx_get_vertex_vec2(const ufbx_vertex_vec2* v, size_t index)

    ufbx_vec3 ufbx_get_vertex_vec3(const ufbx_vertex_vec3* v, size_t index)

    ufbx_vec4 ufbx_get_vertex_vec4(const ufbx_vertex_vec4* v, size_t index)

    ufbx_real ufbx_catch_get_vertex_w_vec3(ufbx_panic* panic, const ufbx_vertex_vec3* v, size_t index)

    ufbx_real ufbx_get_vertex_w_vec3(const ufbx_vertex_vec3* v, size_t index)

    ufbx_unknown* ufbx_as_unknown(const ufbx_element* element)

    ufbx_node* ufbx_as_node(const ufbx_element* element)

    ufbx_mesh* ufbx_as_mesh(const ufbx_element* element)

    ufbx_light* ufbx_as_light(const ufbx_element* element)

    ufbx_camera* ufbx_as_camera(const ufbx_element* element)

    ufbx_bone* ufbx_as_bone(const ufbx_element* element)

    ufbx_empty* ufbx_as_empty(const ufbx_element* element)

    ufbx_line_curve* ufbx_as_line_curve(const ufbx_element* element)

    ufbx_nurbs_curve* ufbx_as_nurbs_curve(const ufbx_element* element)

    ufbx_nurbs_surface* ufbx_as_nurbs_surface(const ufbx_element* element)

    ufbx_nurbs_trim_surface* ufbx_as_nurbs_trim_surface(const ufbx_element* element)

    ufbx_nurbs_trim_boundary* ufbx_as_nurbs_trim_boundary(const ufbx_element* element)

    ufbx_procedural_geometry* ufbx_as_procedural_geometry(const ufbx_element* element)

    ufbx_stereo_camera* ufbx_as_stereo_camera(const ufbx_element* element)

    ufbx_camera_switcher* ufbx_as_camera_switcher(const ufbx_element* element)

    ufbx_marker* ufbx_as_marker(const ufbx_element* element)

    ufbx_lod_group* ufbx_as_lod_group(const ufbx_element* element)

    ufbx_skin_deformer* ufbx_as_skin_deformer(const ufbx_element* element)

    ufbx_skin_cluster* ufbx_as_skin_cluster(const ufbx_element* element)

    ufbx_blend_deformer* ufbx_as_blend_deformer(const ufbx_element* element)

    ufbx_blend_channel* ufbx_as_blend_channel(const ufbx_element* element)

    ufbx_blend_shape* ufbx_as_blend_shape(const ufbx_element* element)

    ufbx_cache_deformer* ufbx_as_cache_deformer(const ufbx_element* element)

    ufbx_cache_file* ufbx_as_cache_file(const ufbx_element* element)

    ufbx_material* ufbx_as_material(const ufbx_element* element)

    ufbx_texture* ufbx_as_texture(const ufbx_element* element)

    ufbx_video* ufbx_as_video(const ufbx_element* element)

    ufbx_shader* ufbx_as_shader(const ufbx_element* element)

    ufbx_shader_binding* ufbx_as_shader_binding(const ufbx_element* element)

    ufbx_anim_stack* ufbx_as_anim_stack(const ufbx_element* element)

    ufbx_anim_layer* ufbx_as_anim_layer(const ufbx_element* element)

    ufbx_anim_value* ufbx_as_anim_value(const ufbx_element* element)

    ufbx_anim_curve* ufbx_as_anim_curve(const ufbx_element* element)

    ufbx_display_layer* ufbx_as_display_layer(const ufbx_element* element)

    ufbx_selection_set* ufbx_as_selection_set(const ufbx_element* element)

    ufbx_selection_node* ufbx_as_selection_node(const ufbx_element* element)

    ufbx_character* ufbx_as_character(const ufbx_element* element)

    ufbx_constraint* ufbx_as_constraint(const ufbx_element* element)

    ufbx_audio_layer* ufbx_as_audio_layer(const ufbx_element* element)

    ufbx_audio_clip* ufbx_as_audio_clip(const ufbx_element* element)

    ufbx_pose* ufbx_as_pose(const ufbx_element* element)

    ufbx_metadata_object* ufbx_as_metadata_object(const ufbx_element* element)

    bool ufbx_dom_is_array(const ufbx_dom_node* node)

    size_t ufbx_dom_array_size(const ufbx_dom_node* node)

    ufbx_int32_list ufbx_dom_as_int32_list(const ufbx_dom_node* node)

    ufbx_int64_list ufbx_dom_as_int64_list(const ufbx_dom_node* node)

    ufbx_float_list ufbx_dom_as_float_list(const ufbx_dom_node* node)

    ufbx_double_list ufbx_dom_as_double_list(const ufbx_dom_node* node)

    ufbx_real_list ufbx_dom_as_real_list(const ufbx_dom_node* node)

    ufbx_blob_list ufbx_dom_as_blob_list(const ufbx_dom_node* node)
