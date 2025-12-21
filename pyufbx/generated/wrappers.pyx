# cython: language_level=3
from weakref import WeakValueDictionary
from threading import Lock
from pyufbx.pyufbx cimport ufbx_element, ufbx_node, ufbx_prop, ufbx_transform, ufbx_bone, ufbx_anim
from pyufbx.elements.element cimport Element
from pyufbx.elements.node cimport Node
from pyufbx.props.prop cimport Prop
from pyufbx.core.transform cimport Transform
from pyufbx.elements.bone cimport Bone
from pyufbx.animation.anim cimport Anim

# Cache for Element
cdef object _element_cache_lock = Lock()
cdef object _element_cache = WeakValueDictionary()
# Cache for Node
cdef object _node_cache_lock = Lock()
cdef object _node_cache = WeakValueDictionary()
# Cache for Prop
cdef object _prop_cache_lock = Lock()
cdef object _prop_cache = WeakValueDictionary()
# Cache for Transform
cdef object _transform_cache_lock = Lock()
cdef object _transform_cache = WeakValueDictionary()
# Cache for Bone
cdef object _bone_cache_lock = Lock()
cdef object _bone_cache = WeakValueDictionary()
# Cache for Anim
cdef object _anim_cache_lock = Lock()
cdef object _anim_cache = WeakValueDictionary()


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
