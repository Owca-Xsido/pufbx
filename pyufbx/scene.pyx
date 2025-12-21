# scene_skeleton.pyx
# Extended Scene class with all ufbx_scene properties
from pyufbx.pyufbx cimport *
from pyufbx.pyufbx cimport ufbx_free_scene, ufbx_scene

from .core.transform cimport Transform
from .elements.bone cimport Bone
from .elements.element cimport Element
from .elements.node cimport Node
from .props.props cimport Prop, PropsWrapper

from .enums.element_types import ElementType
from .enums.enums import InheritMode, RotationOrder
from .enums.property_types import PropType

from .generated.lists cimport BoneList, NodeList
from .generated.wrappers cimport wrap_node


cdef class Scene:

    def __cinit__(self):
        self._scene = NULL

    cdef void _set_scene(self, ufbx_scene* scene) noexcept:
        self._scene = scene

    # def __dealloc__(self):
    #     if self._scene != NULL:
    #         ufbx_free_scene(self._scene)
    #         self._scene = NULL

    # ========================================================================
    # Core Properties
    # ========================================================================

    @property
    def metadata(self):
        """Scene metadata information."""
        if self._scene == NULL:
            return None
        # TODO: Wrap ufbx_metadata
        raise NotImplementedError("metadata is not implemented yet.")

    @property
    def settings(self):
        """Global scene settings."""
        if self._scene == NULL:
            return None
        # TODO: Wrap ufbx_scene_settings
        raise NotImplementedError("settings is not implemented yet.")

    @property
    def root_node(self):
        """Returns the root node of the scene."""
        if self._scene == NULL or self._scene.root_node == NULL:
            return None
        return wrap_node(self._scene.root_node)

    @property
    def anim(self):
        """Default animation descriptor."""
        if self._scene == NULL or self._scene.anim == NULL:
            return None
        # TODO: Wrap ufbx_anim
        raise NotImplementedError("anim is not implemented yet.")

    # # ========================================================================
    # # Elements - Nodes
    # # ========================================================================

    @property
    def unknowns(self):
        """List of unknown elements."""
        if self._scene == NULL:
            return []
        # TODO: Wrap ufbx_unknown_list
        raise NotImplementedError("unknowns is not implemented yet.")

    @property
    def nodes(self):
        """Get list of all nodes in the scene, wrapped as Node objects."""
        if self._scene == NULL:
            return []
        
        cdef list result = []
        cdef size_t i
        cdef ufbx_node *node
        cdef ufbx_node **nodes_data = <ufbx_node**>self._scene.nodes.data
        cdef Node node_obj

        for i in range(self._scene.nodes.count):
            node = nodes_data[i]
            node_obj = wrap_node(node)
            result.append(node_obj)

        return result

    @property
    def num_nodes(self):
        """Number of nodes in the scene."""
        if self._scene == NULL:
            return 0
        return self._scene.nodes.count

    # ========================================================================
    # Node Attributes - Common
    # ========================================================================

    # @property
    # def meshes(self):
    #     """List of mesh objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return MeshList.create(self._scene.meshes.data, self._scene.meshes.count)

    # @property
    # def num_meshes(self):
    #     """Number of meshes in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.meshes.count

    # @property
    # def lights(self):
    #     """List of light objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return LightList.create(self._scene.lights.data, self._scene.lights.count)

    # @property
    # def num_lights(self):
    #     """Number of lights in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.lights.count

    # @property
    # def cameras(self):
    #     """List of camera objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return CameraList.create(self._scene.cameras.data, self._scene.cameras.count)

    # @property
    # def num_cameras(self):
    #     """Number of cameras in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.cameras.count

    @property
    def bones(self):
        """List of bone objects in the scene."""
        if self._scene == NULL:
            return []
        return BoneList.create(self._scene.bones.data, self._scene.bones.count)

    @property
    def num_bones(self):
        """Number of bones in the scene."""
        if self._scene == NULL:
            return 0
        return self._scene.bones.count

    # @property
    # def empties(self):
    #     """List of empty/null objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return EmptyList.create(self._scene.empties.data, self._scene.empties.count)

    # @property
    # def num_empties(self):
    #     """Number of empty objects in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.empties.count

    # # ========================================================================
    # # Node Attributes - Curves/Surfaces
    # # ========================================================================

    # @property
    # def line_curves(self):
    #     """List of line curve objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return LineCurveList.create(self._scene.line_curves.data, self._scene.line_curves.count)

    # @property
    # def num_line_curves(self):
    #     """Number of line curves in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.line_curves.count

    # @property
    # def nurbs_curves(self):
    #     """List of NURBS curve objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return NurbsCurveList.create(self._scene.nurbs_curves.data, self._scene.nurbs_curves.count)

    # @property
    # def num_nurbs_curves(self):
    #     """Number of NURBS curves in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.nurbs_curves.count

    # @property
    # def nurbs_surfaces(self):
    #     """List of NURBS surface objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return NurbsSurfaceList.create(self._scene.nurbs_surfaces.data, self._scene.nurbs_surfaces.count)

    # @property
    # def num_nurbs_surfaces(self):
    #     """Number of NURBS surfaces in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.nurbs_surfaces.count

    # @property
    # def nurbs_trim_surfaces(self):
    #     """List of NURBS trim surface objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return NurbsTrimSurfaceList.create(self._scene.nurbs_trim_surfaces.data, self._scene.nurbs_trim_surfaces.count)

    # @property
    # def num_nurbs_trim_surfaces(self):
    #     """Number of NURBS trim surfaces in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.nurbs_trim_surfaces.count

    # @property
    # def nurbs_trim_boundaries(self):
    #     """List of NURBS trim boundary objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return NurbsTrimBoundaryList.create(self._scene.nurbs_trim_boundaries.data, self._scene.nurbs_trim_boundaries.count)

    # @property
    # def num_nurbs_trim_boundaries(self):
    #     """Number of NURBS trim boundaries in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.nurbs_trim_boundaries.count

    # # ========================================================================
    # # Node Attributes - Advanced
    # # ========================================================================

    # @property
    # def procedural_geometries(self):
    #     """List of procedural geometry objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return ProceduralGeometryList.create(self._scene.procedural_geometries.data, self._scene.procedural_geometries.count)

    # @property
    # def num_procedural_geometries(self):
    #     """Number of procedural geometries in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.procedural_geometries.count

    # @property
    # def stereo_cameras(self):
    #     """List of stereo camera objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return StereoCameraList.create(self._scene.stereo_cameras.data, self._scene.stereo_cameras.count)

    # @property
    # def num_stereo_cameras(self):
    #     """Number of stereo cameras in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.stereo_cameras.count

    # @property
    # def camera_switchers(self):
    #     """List of camera switcher objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return CameraSwitcherList.create(self._scene.camera_switchers.data, self._scene.camera_switchers.count)

    # @property
    # def num_camera_switchers(self):
    #     """Number of camera switchers in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.camera_switchers.count

    # @property
    # def markers(self):
    #     """List of marker objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return MarkerList.create(self._scene.markers.data, self._scene.markers.count)

    # @property
    # def num_markers(self):
    #     """Number of markers in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.markers.count

    # @property
    # def lod_groups(self):
    #     """List of LOD group objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return LodGroupList.create(self._scene.lod_groups.data, self._scene.lod_groups.count)

    # @property
    # def num_lod_groups(self):
    #     """Number of LOD groups in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.lod_groups.count

    # # ========================================================================
    # # Deformers
    # # ========================================================================

    # @property
    # def skin_deformers(self):
    #     """List of skin deformer objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return SkinDeformerList.create(self._scene.skin_deformers.data, self._scene.skin_deformers.count)

    # @property
    # def num_skin_deformers(self):
    #     """Number of skin deformers in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.skin_deformers.count

    # @property
    # def skin_clusters(self):
    #     """List of skin cluster objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return SkinClusterList.create(self._scene.skin_clusters.data, self._scene.skin_clusters.count)

    # @property
    # def num_skin_clusters(self):
    #     """Number of skin clusters in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.skin_clusters.count

    # @property
    # def blend_deformers(self):
    #     """List of blend deformer objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return BlendDeformerList.create(self._scene.blend_deformers.data, self._scene.blend_deformers.count)

    # @property
    # def num_blend_deformers(self):
    #     """Number of blend deformers in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.blend_deformers.count

    # @property
    # def blend_channels(self):
    #     """List of blend channel objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return BlendChannelList.create(self._scene.blend_channels.data, self._scene.blend_channels.count)

    # @property
    # def num_blend_channels(self):
    #     """Number of blend channels in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.blend_channels.count

    # @property
    # def blend_shapes(self):
    #     """List of blend shape objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return BlendShapeList.create(self._scene.blend_shapes.data, self._scene.blend_shapes.count)

    # @property
    # def num_blend_shapes(self):
    #     """Number of blend shapes in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.blend_shapes.count

    # @property
    # def cache_deformers(self):
    #     """List of cache deformer objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return CacheDeformerList.create(self._scene.cache_deformers.data, self._scene.cache_deformers.count)

    # @property
    # def num_cache_deformers(self):
    #     """Number of cache deformers in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.cache_deformers.count

    # @property
    # def cache_files(self):
    #     """List of cache file objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return CacheFileList.create(self._scene.cache_files.data, self._scene.cache_files.count)

    # @property
    # def num_cache_files(self):
    #     """Number of cache files in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.cache_files.count

    # # ========================================================================
    # # Materials
    # # ========================================================================

    # @property
    # def materials(self):
    #     """List of material objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return MaterialList.create(self._scene.materials.data, self._scene.materials.count)

    # @property
    # def num_materials(self):
    #     """Number of materials in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.materials.count

    # @property
    # def textures(self):
    #     """List of texture objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return TextureList.create(self._scene.textures.data, self._scene.textures.count)

    # @property
    # def num_textures(self):
    #     """Number of textures in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.textures.count

    # @property
    # def videos(self):
    #     """List of video objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return VideoList.create(self._scene.videos.data, self._scene.videos.count)

    # @property
    # def num_videos(self):
    #     """Number of videos in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.videos.count

    # @property
    # def shaders(self):
    #     """List of shader objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return ShaderList.create(self._scene.shaders.data, self._scene.shaders.count)

    # @property
    # def num_shaders(self):
    #     """Number of shaders in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.shaders.count

    # @property
    # def shader_bindings(self):
    #     """List of shader binding objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return ShaderBindingList.create(self._scene.shader_bindings.data, self._scene.shader_bindings.count)

    # @property
    # def num_shader_bindings(self):
    #     """Number of shader bindings in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.shader_bindings.count

    # # ========================================================================
    # # Animation
    # # ========================================================================

    # @property
    # def anim_stacks(self):
    #     """List of animation stack objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return AnimStackList.create(self._scene.anim_stacks.data, self._scene.anim_stacks.count)

    # @property
    # def num_anim_stacks(self):
    #     """Number of animation stacks in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.anim_stacks.count

    # @property
    # def anim_layers(self):
    #     """List of animation layer objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return AnimLayerList.create(self._scene.anim_layers.data, self._scene.anim_layers.count)

    # @property
    # def num_anim_layers(self):
    #     """Number of animation layers in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.anim_layers.count

    # @property
    # def anim_values(self):
    #     """List of animation value objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return AnimValueList.create(self._scene.anim_values.data, self._scene.anim_values.count)

    # @property
    # def num_anim_values(self):
    #     """Number of animation values in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.anim_values.count

    # @property
    # def anim_curves(self):
    #     """List of animation curve objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return AnimCurveList.create(self._scene.anim_curves.data, self._scene.anim_curves.count)

    # @property
    # def num_anim_curves(self):
    #     """Number of animation curves in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.anim_curves.count

    # # ========================================================================
    # # Collections
    # # ========================================================================

    # @property
    # def display_layers(self):
    #     """List of display layer objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return DisplayLayerList.create(self._scene.display_layers.data, self._scene.display_layers.count)

    # @property
    # def num_display_layers(self):
    #     """Number of display layers in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.display_layers.count

    # @property
    # def selection_sets(self):
    #     """List of selection set objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return SelectionSetList.create(self._scene.selection_sets.data, self._scene.selection_sets.count)

    # @property
    # def num_selection_sets(self):
    #     """Number of selection sets in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.selection_sets.count

    # @property
    # def selection_nodes(self):
    #     """List of selection node objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return SelectionNodeList.create(self._scene.selection_nodes.data, self._scene.selection_nodes.count)

    # @property
    # def num_selection_nodes(self):
    #     """Number of selection nodes in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.selection_nodes.count

    # # ========================================================================
    # # Constraints
    # # ========================================================================

    # @property
    # def characters(self):
    #     """List of character objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return CharacterList.create(self._scene.characters.data, self._scene.characters.count)

    # @property
    # def num_characters(self):
    #     """Number of characters in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.characters.count

    # @property
    # def constraints(self):
    #     """List of constraint objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return ConstraintList.create(self._scene.constraints.data, self._scene.constraints.count)

    # @property
    # def num_constraints(self):
    #     """Number of constraints in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.constraints.count

    # # ========================================================================
    # # Audio
    # # ========================================================================

    # @property
    # def audio_layers(self):
    #     """List of audio layer objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return AudioLayerList.create(self._scene.audio_layers.data, self._scene.audio_layers.count)

    # @property
    # def num_audio_layers(self):
    #     """Number of audio layers in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.audio_layers.count

    # @property
    # def audio_clips(self):
    #     """List of audio clip objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return AudioClipList.create(self._scene.audio_clips.data, self._scene.audio_clips.count)

    # @property
    # def num_audio_clips(self):
    #     """Number of audio clips in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.audio_clips.count

    # # ========================================================================
    # # Miscellaneous
    # # ========================================================================

    # @property
    # def poses(self):
    #     """List of pose objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return PoseList.create(self._scene.poses.data, self._scene.poses.count)

    # @property
    # def num_poses(self):
    #     """Number of poses in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.poses.count

    # @property
    # def metadata_objects(self):
    #     """List of metadata object objects in the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return MetadataObjectList.create(self._scene.metadata_objects.data, self._scene.metadata_objects.count)

    # @property
    # def num_metadata_objects(self):
    #     """Number of metadata objects in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.metadata_objects.count

    # # ========================================================================
    # # Indexed Collections
    # # ========================================================================

    # @property
    # def elements_by_type(self):
    #     """
    #     Elements organized by type.
    #     Returns a dictionary mapping ElementType to lists of elements.
    #     """
    #     if self._scene == NULL:
    #         return {}
        
    #     # TODO: Implement proper wrapping for elements_by_type array
    #     raise NotImplementedError("elements_by_type is not implemented yet.")

    # def get_elements_by_type(self, element_type):
    #     """
    #     Get all elements of a specific type.
        
    #     Args:
    #         element_type: ElementType enum value
        
    #     Returns:
    #         List of elements of the specified type
    #     """
    #     if self._scene == NULL:
    #         return []
        
    #     cdef int type_index = <int>element_type
    #     if type_index < 0 or type_index >= UFBX_ELEMENT_TYPE_COUNT:
    #         raise ValueError(f"Invalid element type: {element_type}")
        
    #     # TODO: Implement proper wrapping
    #     raise NotImplementedError("get_elements_by_type is not implemented yet.")

    # # ========================================================================
    # # Texture Files
    # # ========================================================================

    # @property
    # def texture_files(self):
    #     """Unique texture files referenced by the scene."""
    #     if self._scene == NULL:
    #         return []
    #     return TextureFileList.create(self._scene.texture_files.data, self._scene.texture_files.count)

    # @property
    # def num_texture_files(self):
    #     """Number of unique texture files in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.texture_files.count

    # # ========================================================================
    # # All Elements
    # # ========================================================================

    # @property
    # def elements(self):
    #     """All elements in the scene, sorted by id."""
    #     if self._scene == NULL:
    #         return []
    #     return ElementList.create(self._scene.elements.data, self._scene.elements.count)

    # @property
    # def num_elements(self):
    #     """Total number of elements in the scene."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.elements.count

    # # ========================================================================
    # # Connections
    # # ========================================================================

    # @property
    # def connections_src(self):
    #     """Connections sorted by source element and source property."""
    #     if self._scene == NULL:
    #         return []
    #     # TODO: Wrap ufbx_connection_list
    #     raise NotImplementedError("connections_src is not implemented yet.")

    # @property
    # def num_connections_src(self):
    #     """Number of source connections."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.connections_src.count

    # @property
    # def connections_dst(self):
    #     """Connections sorted by destination element and destination property."""
    #     if self._scene == NULL:
    #         return []
    #     # TODO: Wrap ufbx_connection_list
    #     raise NotImplementedError("connections_dst is not implemented yet.")

    # @property
    # def num_connections_dst(self):
    #     """Number of destination connections."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.connections_dst.count

    # # ========================================================================
    # # Named Elements
    # # ========================================================================

    # @property
    # def elements_by_name(self):
    #     """Elements sorted by name and type."""
    #     if self._scene == NULL:
    #         return []
    #     # TODO: Wrap ufbx_name_element_list
    #     raise NotImplementedError("elements_by_name is not implemented yet.")

    # @property
    # def num_elements_by_name(self):
    #     """Number of named elements."""
    #     if self._scene == NULL:
    #         return 0
    #     return self._scene.elements_by_name.count

    # # ========================================================================
    # # DOM (Document Object Model)
    # # ========================================================================

    # @property
    # def dom_root(self):
    #     """
    #     Root of the DOM tree.
    #     Only available if ufbx_load_opts.retain_dom was set to true.
    #     """
    #     if self._scene == NULL or self._scene.dom_root == NULL:
    #         return None
    #     # TODO: Wrap ufbx_dom_node
    #     raise NotImplementedError("dom_root is not implemented yet.")

    # # ========================================================================
    # # Convenience Methods
    # # ========================================================================

    # def get_node_names(self):
    #     """Returns a list of all node names in the scene."""
    #     if self._scene == NULL:
    #         return []
        
    #     cdef list names = []
    #     cdef size_t i
    #     cdef ufbx_node *node
    #     cdef ufbx_node **nodes_data = <ufbx_node**>self._scene.nodes.data

    #     for i in range(self._scene.nodes.count):
    #         node = nodes_data[i]
    #         names.append(to_py_string(node.name))

    #     return names

    # def find_node(self, name: str):
    #     """
    #     Find a node by name.
        
    #     Args:
    #         name: Name of the node to find
            
    #     Returns:
    #         Node object if found, None otherwise
    #     """
    #     if self._scene == NULL:
    #         return None
        
    #     cdef bytes name_bytes = name.encode('utf-8')
    #     cdef const char *c_name = name_bytes
    #     cdef ufbx_string name_str
    #     name_str.data = c_name
    #     name_str.length = len(name_bytes)
        
    #     # TODO: Use ufbx_find_element_by_name or similar
    #     # For now, iterate manually
    #     for node in self.nodes:
    #         if node.name == name:
    #             return node
        
    #     return None

    # def summary(self):
    #     """
    #     Returns a summary dictionary with counts of major scene components.
    #     """
    #     return {
    #         'nodes': self.num_nodes,
    #         'meshes': self.num_meshes,
    #         'lights': self.num_lights,
    #         'cameras': self.num_cameras,
    #         'bones': self.num_bones,
    #         'materials': self.num_materials,
    #         'textures': self.num_textures,
    #         'animations': self.num_anim_stacks,
    #         'constraints': self.num_constraints,
    #         'elements': self.num_elements,
    #     }
