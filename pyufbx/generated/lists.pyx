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

from .wrappers cimport (
    wrap_anim,
    wrap_anim_curve,
    wrap_anim_layer,
    wrap_anim_prop,
    wrap_anim_stack,
    wrap_anim_value,
    wrap_audio_clip,
    wrap_audio_layer,
    wrap_baked_anim,
    wrap_baked_node,
    wrap_blend_channel,
    wrap_blend_deformer,
    wrap_blend_shape,
    wrap_bone,
    wrap_cache_deformer,
    wrap_cache_file,
    wrap_camera,
    wrap_camera_switcher,
    wrap_character,
    wrap_constraint,
    wrap_display_layer,
    wrap_element,
    wrap_empty,
    wrap_keyframe,
    wrap_light,
    wrap_line_curve,
    wrap_lod_group,
    wrap_marker,
    wrap_material,
    wrap_mesh,
    wrap_metadata_object,
    wrap_node,
    wrap_nurbs_curve,
    wrap_nurbs_surface,
    wrap_nurbs_trim_boundary,
    wrap_nurbs_trim_surface,
    wrap_pose,
    wrap_procedural_geometry,
    wrap_prop,
    wrap_selection_node,
    wrap_selection_set,
    wrap_shader,
    wrap_shader_binding,
    wrap_skin_cluster,
    wrap_skin_deformer,
    wrap_stereo_camera,
    wrap_texture,
    wrap_texture_file,
    wrap_transform,
    wrap_video,
)


cdef class ElementList:
    """A list-like wrapper for ufbx_element pointers."""

    @staticmethod
    cdef ElementList create(ufbx_element **data, size_t count):
        cdef ElementList obj = ElementList.__new__(ElementList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_element(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_element(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_element(self._data[i])

    def __repr__(self):
        return f"<ElementList count={self._count}>"


cdef class NodeList:
    """A list-like wrapper for ufbx_node pointers."""

    @staticmethod
    cdef NodeList create(ufbx_node **data, size_t count):
        cdef NodeList obj = NodeList.__new__(NodeList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_node(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_node(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_node(self._data[i])

    def __repr__(self):
        return f"<NodeList count={self._count}>"


cdef class PropList:
    """A list-like wrapper for ufbx_prop pointers."""

    @staticmethod
    cdef PropList create(ufbx_prop *data, size_t count):
        cdef PropList obj = PropList.__new__(PropList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_prop(&self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_prop(&self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_prop(&self._data[i])

    def __repr__(self):
        return f"<PropList count={self._count}>"


cdef class TransformList:
    """A list-like wrapper for ufbx_transform pointers."""

    @staticmethod
    cdef TransformList create(ufbx_transform **data, size_t count):
        cdef TransformList obj = TransformList.__new__(TransformList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_transform(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_transform(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_transform(self._data[i])

    def __repr__(self):
        return f"<TransformList count={self._count}>"


cdef class BoneList:
    """A list-like wrapper for ufbx_bone pointers."""

    @staticmethod
    cdef BoneList create(ufbx_bone **data, size_t count):
        cdef BoneList obj = BoneList.__new__(BoneList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_bone(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_bone(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_bone(self._data[i])

    def __repr__(self):
        return f"<BoneList count={self._count}>"


cdef class AnimList:
    """A list-like wrapper for ufbx_anim pointers."""

    @staticmethod
    cdef AnimList create(ufbx_anim **data, size_t count):
        cdef AnimList obj = AnimList.__new__(AnimList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_anim(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_anim(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_anim(self._data[i])

    def __repr__(self):
        return f"<AnimList count={self._count}>"


cdef class AnimValueList:
    """A list-like wrapper for ufbx_anim_value pointers."""

    @staticmethod
    cdef AnimValueList create(ufbx_anim_value **data, size_t count):
        cdef AnimValueList obj = AnimValueList.__new__(AnimValueList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_anim_value(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_anim_value(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_anim_value(self._data[i])

    def __repr__(self):
        return f"<AnimValueList count={self._count}>"


cdef class AnimCurveList:
    """A list-like wrapper for ufbx_anim_curve pointers."""

    @staticmethod
    cdef AnimCurveList create(ufbx_anim_curve **data, size_t count):
        cdef AnimCurveList obj = AnimCurveList.__new__(AnimCurveList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_anim_curve(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_anim_curve(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_anim_curve(self._data[i])

    def __repr__(self):
        return f"<AnimCurveList count={self._count}>"


cdef class KeyframeList:
    """A list-like wrapper for ufbx_keyframe pointers."""

    @staticmethod
    cdef KeyframeList create(ufbx_keyframe *data, size_t count):
        cdef KeyframeList obj = KeyframeList.__new__(KeyframeList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_keyframe(&self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_keyframe(&self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_keyframe(&self._data[i])

    def __repr__(self):
        return f"<KeyframeList count={self._count}>"


cdef class AnimPropList:
    """A list-like wrapper for ufbx_anim_prop pointers."""

    @staticmethod
    cdef AnimPropList create(ufbx_anim_prop *data, size_t count):
        cdef AnimPropList obj = AnimPropList.__new__(AnimPropList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_anim_prop(&self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_anim_prop(&self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_anim_prop(&self._data[i])

    def __repr__(self):
        return f"<AnimPropList count={self._count}>"


cdef class AnimLayerList:
    """A list-like wrapper for ufbx_anim_layer pointers."""

    @staticmethod
    cdef AnimLayerList create(ufbx_anim_layer **data, size_t count):
        cdef AnimLayerList obj = AnimLayerList.__new__(AnimLayerList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_anim_layer(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_anim_layer(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_anim_layer(self._data[i])

    def __repr__(self):
        return f"<AnimLayerList count={self._count}>"


cdef class BakedAnimList:
    """A list-like wrapper for ufbx_baked_anim pointers."""

    @staticmethod
    cdef BakedAnimList create(ufbx_baked_anim **data, size_t count):
        cdef BakedAnimList obj = BakedAnimList.__new__(BakedAnimList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_baked_anim(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_baked_anim(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_baked_anim(self._data[i])

    def __repr__(self):
        return f"<BakedAnimList count={self._count}>"


cdef class BakedNodeList:
    """A list-like wrapper for ufbx_baked_node pointers."""

    @staticmethod
    cdef BakedNodeList create(ufbx_baked_node *data, size_t count):
        cdef BakedNodeList obj = BakedNodeList.__new__(BakedNodeList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_baked_node(&self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_baked_node(&self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_baked_node(&self._data[i])

    def __repr__(self):
        return f"<BakedNodeList count={self._count}>"


cdef class MeshList:
    """A list-like wrapper for ufbx_mesh pointers."""

    @staticmethod
    cdef MeshList create(ufbx_mesh **data, size_t count):
        cdef MeshList obj = MeshList.__new__(MeshList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_mesh(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_mesh(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_mesh(self._data[i])

    def __repr__(self):
        return f"<MeshList count={self._count}>"


cdef class LightList:
    """A list-like wrapper for ufbx_light pointers."""

    @staticmethod
    cdef LightList create(ufbx_light **data, size_t count):
        cdef LightList obj = LightList.__new__(LightList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_light(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_light(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_light(self._data[i])

    def __repr__(self):
        return f"<LightList count={self._count}>"


cdef class CameraList:
    """A list-like wrapper for ufbx_camera pointers."""

    @staticmethod
    cdef CameraList create(ufbx_camera **data, size_t count):
        cdef CameraList obj = CameraList.__new__(CameraList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_camera(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_camera(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_camera(self._data[i])

    def __repr__(self):
        return f"<CameraList count={self._count}>"


cdef class EmptyList:
    """A list-like wrapper for ufbx_empty pointers."""

    @staticmethod
    cdef EmptyList create(ufbx_empty **data, size_t count):
        cdef EmptyList obj = EmptyList.__new__(EmptyList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_empty(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_empty(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_empty(self._data[i])

    def __repr__(self):
        return f"<EmptyList count={self._count}>"


cdef class LineCurveList:
    """A list-like wrapper for ufbx_line_curve pointers."""

    @staticmethod
    cdef LineCurveList create(ufbx_line_curve **data, size_t count):
        cdef LineCurveList obj = LineCurveList.__new__(LineCurveList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_line_curve(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_line_curve(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_line_curve(self._data[i])

    def __repr__(self):
        return f"<LineCurveList count={self._count}>"


cdef class NurbsCurveList:
    """A list-like wrapper for ufbx_nurbs_curve pointers."""

    @staticmethod
    cdef NurbsCurveList create(ufbx_nurbs_curve **data, size_t count):
        cdef NurbsCurveList obj = NurbsCurveList.__new__(NurbsCurveList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_nurbs_curve(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_nurbs_curve(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_nurbs_curve(self._data[i])

    def __repr__(self):
        return f"<NurbsCurveList count={self._count}>"


cdef class NurbsSurfaceList:
    """A list-like wrapper for ufbx_nurbs_surface pointers."""

    @staticmethod
    cdef NurbsSurfaceList create(ufbx_nurbs_surface **data, size_t count):
        cdef NurbsSurfaceList obj = NurbsSurfaceList.__new__(NurbsSurfaceList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_nurbs_surface(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_nurbs_surface(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_nurbs_surface(self._data[i])

    def __repr__(self):
        return f"<NurbsSurfaceList count={self._count}>"


cdef class NurbsTrimSurfaceList:
    """A list-like wrapper for ufbx_nurbs_trim_surface pointers."""

    @staticmethod
    cdef NurbsTrimSurfaceList create(ufbx_nurbs_trim_surface **data, size_t count):
        cdef NurbsTrimSurfaceList obj = NurbsTrimSurfaceList.__new__(NurbsTrimSurfaceList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_nurbs_trim_surface(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_nurbs_trim_surface(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_nurbs_trim_surface(self._data[i])

    def __repr__(self):
        return f"<NurbsTrimSurfaceList count={self._count}>"


cdef class NurbsTrimBoundaryList:
    """A list-like wrapper for ufbx_nurbs_trim_boundary pointers."""

    @staticmethod
    cdef NurbsTrimBoundaryList create(ufbx_nurbs_trim_boundary **data, size_t count):
        cdef NurbsTrimBoundaryList obj = NurbsTrimBoundaryList.__new__(NurbsTrimBoundaryList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_nurbs_trim_boundary(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_nurbs_trim_boundary(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_nurbs_trim_boundary(self._data[i])

    def __repr__(self):
        return f"<NurbsTrimBoundaryList count={self._count}>"


cdef class ProceduralGeometryList:
    """A list-like wrapper for ufbx_procedural_geometry pointers."""

    @staticmethod
    cdef ProceduralGeometryList create(ufbx_procedural_geometry **data, size_t count):
        cdef ProceduralGeometryList obj = ProceduralGeometryList.__new__(ProceduralGeometryList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_procedural_geometry(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_procedural_geometry(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_procedural_geometry(self._data[i])

    def __repr__(self):
        return f"<ProceduralGeometryList count={self._count}>"


cdef class StereoCameraList:
    """A list-like wrapper for ufbx_stereo_camera pointers."""

    @staticmethod
    cdef StereoCameraList create(ufbx_stereo_camera **data, size_t count):
        cdef StereoCameraList obj = StereoCameraList.__new__(StereoCameraList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_stereo_camera(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_stereo_camera(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_stereo_camera(self._data[i])

    def __repr__(self):
        return f"<StereoCameraList count={self._count}>"


cdef class CameraSwitcherList:
    """A list-like wrapper for ufbx_camera_switcher pointers."""

    @staticmethod
    cdef CameraSwitcherList create(ufbx_camera_switcher **data, size_t count):
        cdef CameraSwitcherList obj = CameraSwitcherList.__new__(CameraSwitcherList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_camera_switcher(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_camera_switcher(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_camera_switcher(self._data[i])

    def __repr__(self):
        return f"<CameraSwitcherList count={self._count}>"


cdef class MarkerList:
    """A list-like wrapper for ufbx_marker pointers."""

    @staticmethod
    cdef MarkerList create(ufbx_marker **data, size_t count):
        cdef MarkerList obj = MarkerList.__new__(MarkerList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_marker(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_marker(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_marker(self._data[i])

    def __repr__(self):
        return f"<MarkerList count={self._count}>"


cdef class LodGroupList:
    """A list-like wrapper for ufbx_lod_group pointers."""

    @staticmethod
    cdef LodGroupList create(ufbx_lod_group **data, size_t count):
        cdef LodGroupList obj = LodGroupList.__new__(LodGroupList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_lod_group(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_lod_group(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_lod_group(self._data[i])

    def __repr__(self):
        return f"<LodGroupList count={self._count}>"


cdef class SkinDeformerList:
    """A list-like wrapper for ufbx_skin_deformer pointers."""

    @staticmethod
    cdef SkinDeformerList create(ufbx_skin_deformer **data, size_t count):
        cdef SkinDeformerList obj = SkinDeformerList.__new__(SkinDeformerList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_skin_deformer(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_skin_deformer(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_skin_deformer(self._data[i])

    def __repr__(self):
        return f"<SkinDeformerList count={self._count}>"


cdef class SkinClusterList:
    """A list-like wrapper for ufbx_skin_cluster pointers."""

    @staticmethod
    cdef SkinClusterList create(ufbx_skin_cluster **data, size_t count):
        cdef SkinClusterList obj = SkinClusterList.__new__(SkinClusterList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_skin_cluster(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_skin_cluster(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_skin_cluster(self._data[i])

    def __repr__(self):
        return f"<SkinClusterList count={self._count}>"


cdef class BlendDeformerList:
    """A list-like wrapper for ufbx_blend_deformer pointers."""

    @staticmethod
    cdef BlendDeformerList create(ufbx_blend_deformer **data, size_t count):
        cdef BlendDeformerList obj = BlendDeformerList.__new__(BlendDeformerList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_blend_deformer(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_blend_deformer(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_blend_deformer(self._data[i])

    def __repr__(self):
        return f"<BlendDeformerList count={self._count}>"


cdef class BlendChannelList:
    """A list-like wrapper for ufbx_blend_channel pointers."""

    @staticmethod
    cdef BlendChannelList create(ufbx_blend_channel **data, size_t count):
        cdef BlendChannelList obj = BlendChannelList.__new__(BlendChannelList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_blend_channel(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_blend_channel(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_blend_channel(self._data[i])

    def __repr__(self):
        return f"<BlendChannelList count={self._count}>"


cdef class BlendShapeList:
    """A list-like wrapper for ufbx_blend_shape pointers."""

    @staticmethod
    cdef BlendShapeList create(ufbx_blend_shape **data, size_t count):
        cdef BlendShapeList obj = BlendShapeList.__new__(BlendShapeList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_blend_shape(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_blend_shape(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_blend_shape(self._data[i])

    def __repr__(self):
        return f"<BlendShapeList count={self._count}>"


cdef class CacheDeformerList:
    """A list-like wrapper for ufbx_cache_deformer pointers."""

    @staticmethod
    cdef CacheDeformerList create(ufbx_cache_deformer **data, size_t count):
        cdef CacheDeformerList obj = CacheDeformerList.__new__(CacheDeformerList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_cache_deformer(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_cache_deformer(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_cache_deformer(self._data[i])

    def __repr__(self):
        return f"<CacheDeformerList count={self._count}>"


cdef class CacheFileList:
    """A list-like wrapper for ufbx_cache_file pointers."""

    @staticmethod
    cdef CacheFileList create(ufbx_cache_file **data, size_t count):
        cdef CacheFileList obj = CacheFileList.__new__(CacheFileList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_cache_file(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_cache_file(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_cache_file(self._data[i])

    def __repr__(self):
        return f"<CacheFileList count={self._count}>"


cdef class MaterialList:
    """A list-like wrapper for ufbx_material pointers."""

    @staticmethod
    cdef MaterialList create(ufbx_material **data, size_t count):
        cdef MaterialList obj = MaterialList.__new__(MaterialList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_material(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_material(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_material(self._data[i])

    def __repr__(self):
        return f"<MaterialList count={self._count}>"


cdef class TextureList:
    """A list-like wrapper for ufbx_texture pointers."""

    @staticmethod
    cdef TextureList create(ufbx_texture **data, size_t count):
        cdef TextureList obj = TextureList.__new__(TextureList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_texture(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_texture(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_texture(self._data[i])

    def __repr__(self):
        return f"<TextureList count={self._count}>"


cdef class VideoList:
    """A list-like wrapper for ufbx_video pointers."""

    @staticmethod
    cdef VideoList create(ufbx_video **data, size_t count):
        cdef VideoList obj = VideoList.__new__(VideoList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_video(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_video(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_video(self._data[i])

    def __repr__(self):
        return f"<VideoList count={self._count}>"


cdef class ShaderList:
    """A list-like wrapper for ufbx_shader pointers."""

    @staticmethod
    cdef ShaderList create(ufbx_shader **data, size_t count):
        cdef ShaderList obj = ShaderList.__new__(ShaderList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_shader(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_shader(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_shader(self._data[i])

    def __repr__(self):
        return f"<ShaderList count={self._count}>"


cdef class ShaderBindingList:
    """A list-like wrapper for ufbx_shader_binding pointers."""

    @staticmethod
    cdef ShaderBindingList create(ufbx_shader_binding **data, size_t count):
        cdef ShaderBindingList obj = ShaderBindingList.__new__(ShaderBindingList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_shader_binding(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_shader_binding(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_shader_binding(self._data[i])

    def __repr__(self):
        return f"<ShaderBindingList count={self._count}>"


cdef class AnimStackList:
    """A list-like wrapper for ufbx_anim_stack pointers."""

    @staticmethod
    cdef AnimStackList create(ufbx_anim_stack **data, size_t count):
        cdef AnimStackList obj = AnimStackList.__new__(AnimStackList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_anim_stack(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_anim_stack(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_anim_stack(self._data[i])

    def __repr__(self):
        return f"<AnimStackList count={self._count}>"


cdef class DisplayLayerList:
    """A list-like wrapper for ufbx_display_layer pointers."""

    @staticmethod
    cdef DisplayLayerList create(ufbx_display_layer **data, size_t count):
        cdef DisplayLayerList obj = DisplayLayerList.__new__(DisplayLayerList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_display_layer(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_display_layer(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_display_layer(self._data[i])

    def __repr__(self):
        return f"<DisplayLayerList count={self._count}>"


cdef class SelectionSetList:
    """A list-like wrapper for ufbx_selection_set pointers."""

    @staticmethod
    cdef SelectionSetList create(ufbx_selection_set **data, size_t count):
        cdef SelectionSetList obj = SelectionSetList.__new__(SelectionSetList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_selection_set(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_selection_set(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_selection_set(self._data[i])

    def __repr__(self):
        return f"<SelectionSetList count={self._count}>"


cdef class SelectionNodeList:
    """A list-like wrapper for ufbx_selection_node pointers."""

    @staticmethod
    cdef SelectionNodeList create(ufbx_selection_node **data, size_t count):
        cdef SelectionNodeList obj = SelectionNodeList.__new__(SelectionNodeList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_selection_node(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_selection_node(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_selection_node(self._data[i])

    def __repr__(self):
        return f"<SelectionNodeList count={self._count}>"


cdef class CharacterList:
    """A list-like wrapper for ufbx_character pointers."""

    @staticmethod
    cdef CharacterList create(ufbx_character **data, size_t count):
        cdef CharacterList obj = CharacterList.__new__(CharacterList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_character(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_character(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_character(self._data[i])

    def __repr__(self):
        return f"<CharacterList count={self._count}>"


cdef class ConstraintList:
    """A list-like wrapper for ufbx_constraint pointers."""

    @staticmethod
    cdef ConstraintList create(ufbx_constraint **data, size_t count):
        cdef ConstraintList obj = ConstraintList.__new__(ConstraintList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_constraint(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_constraint(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_constraint(self._data[i])

    def __repr__(self):
        return f"<ConstraintList count={self._count}>"


cdef class AudioLayerList:
    """A list-like wrapper for ufbx_audio_layer pointers."""

    @staticmethod
    cdef AudioLayerList create(ufbx_audio_layer **data, size_t count):
        cdef AudioLayerList obj = AudioLayerList.__new__(AudioLayerList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_audio_layer(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_audio_layer(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_audio_layer(self._data[i])

    def __repr__(self):
        return f"<AudioLayerList count={self._count}>"


cdef class AudioClipList:
    """A list-like wrapper for ufbx_audio_clip pointers."""

    @staticmethod
    cdef AudioClipList create(ufbx_audio_clip **data, size_t count):
        cdef AudioClipList obj = AudioClipList.__new__(AudioClipList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_audio_clip(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_audio_clip(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_audio_clip(self._data[i])

    def __repr__(self):
        return f"<AudioClipList count={self._count}>"


cdef class PoseList:
    """A list-like wrapper for ufbx_pose pointers."""

    @staticmethod
    cdef PoseList create(ufbx_pose **data, size_t count):
        cdef PoseList obj = PoseList.__new__(PoseList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_pose(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_pose(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_pose(self._data[i])

    def __repr__(self):
        return f"<PoseList count={self._count}>"


cdef class MetadataObjectList:
    """A list-like wrapper for ufbx_metadata_object pointers."""

    @staticmethod
    cdef MetadataObjectList create(ufbx_metadata_object **data, size_t count):
        cdef MetadataObjectList obj = MetadataObjectList.__new__(MetadataObjectList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_metadata_object(self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_metadata_object(self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_metadata_object(self._data[i])

    def __repr__(self):
        return f"<MetadataObjectList count={self._count}>"


cdef class TextureFileList:
    """A list-like wrapper for ufbx_texture_file pointers."""

    @staticmethod
    cdef TextureFileList create(ufbx_texture_file *data, size_t count):
        cdef TextureFileList obj = TextureFileList.__new__(TextureFileList)
        obj._data = data
        obj._count = count
        return obj

    def __len__(self):
        return self._count

    def __getitem__(self, idx):
        cdef list result
        cdef size_t i
        cdef int start, stop, step

        if isinstance(idx, slice):
            start, stop, step = idx.indices(self._count)
            result = []
            for i in range(start, stop, step):
                result.append(wrap_texture_file(&self._data[i]))
            return result

        if idx < 0:
            idx += self._count
        if idx < 0 or idx >= self._count:
            raise IndexError("Index out of range")
        return wrap_texture_file(&self._data[idx])

    def __iter__(self):
        cdef size_t i
        for i in range(self._count):
            yield wrap_texture_file(&self._data[i])

    def __repr__(self):
        return f"<TextureFileList count={self._count}>"


