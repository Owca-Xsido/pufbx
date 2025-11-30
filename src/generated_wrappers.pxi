# Auto-generated wrapper functions
from weakref import WeakValueDictionary
from threading import Lock


cdef object _element_cache_lock = Lock()
cdef object _element_cache = WeakValueDictionary()

cdef object _node_cache_lock = Lock()
cdef object _node_cache = WeakValueDictionary()

cdef object _prop_cache_lock = Lock()
cdef object _prop_cache = WeakValueDictionary()

cdef object _transform_cache_lock = Lock()
cdef object _transform_cache = WeakValueDictionary()


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

