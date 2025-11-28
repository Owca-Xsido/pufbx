from libc.stddef cimport size_t
from libc.stdint cimport int32_t, int64_t, uint32_t, uint64_t


cdef extern from "ufbx.h":

    # Basic types 

    ctypedef double ufbx_real 
    

    # Null-terminated UTF-8 encoded string within an FBX file
    cdef struct ufbx_string:
        const char *data
        size_t length

    # Opaque byte buffer blob
    cdef struct ufbx_blob:
        const void *data
        size_t size

    # 2d Vector
    cdef struct ufbx_vec2:
            ufbx_real x
            ufbx_real y

    # 3d Vector
    cdef struct ufbx_vec3:
        ufbx_real x
        ufbx_real y
        ufbx_real z

    # 4d Vector
    cdef struct ufbx_vec4:
        ufbx_real x
        ufbx_real y
        ufbx_real z
        ufbx_real w

    # Quaterion
    cdef struct ufbx_quat:

        ufbx_real x
        ufbx_real y
        ufbx_real z
        ufbx_real w

    # Declare the ufbx_rotation_order enumeration
    cdef enum ufbx_rotation_order:
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

    # Explicit translation+rotation+scale transformation.
    # Rotation represented as a quaterion
    cdef struct ufbx_transform:
        ufbx_vec3 translation
        ufbx_quat rotation 
        ufbx_vec3 scale



    # 4x3 matrix encoding an affine transformation.
    # `cols[0..2]` are the X/Y/Z basis vectors, `cols[3]` is the translation

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

    
    # Void list
    cdef struct ufbx_void_list:
        void *data
        size_t count

    cdef struct ufbx_bool_list:
        bool *data  
        size_t count

    # ufbx_uint32_list
    cdef struct ufbx_uint32_list:
        uint32_t *data
        size_t count

    # ufbx_real_list
    cdef struct ufbx_real_list:
        ufbx_real *data
        size_t count

    # ufbx_vec2_list
    cdef struct ufbx_vec2_list:
        ufbx_vec2 *data
        size_t count

    # ufbx_vec3_list
    cdef struct ufbx_vec3_list:
        ufbx_vec3 *data
        size_t count

    # ufbx_vec4_list
    cdef struct ufbx_vec4_list:
        ufbx_vec4 *data
        size_t count

    # ufbx_string_list
    cdef struct ufbx_string_list:
        ufbx_string *data
        size_t count


    # Declare the ufbx_dom_value_type enumeration
    cdef enum ufbx_dom_value_type:
        UFBX_DOM_VALUE_NUMBER
        UFBX_DOM_VALUE_STRING
        UFBX_DOM_VALUE_BLOB
        UFBX_DOM_VALUE_ARRAY_I32
        UFBX_DOM_VALUE_ARRAY_I64
        UFBX_DOM_VALUE_ARRAY_F32
        UFBX_DOM_VALUE_ARRAY_F64
        UFBX_DOM_VALUE_ARRAY_BLOB
        UFBX_DOM_VALUE_ARRAY_IGNORED  

    cpdef enum:
        UFBX_DOM_VALUE_TYPE_COUNT

    cdef struct ufbx_dom_node:        
        pass

    cdef struct ufbx_int32_list:
        int32_t *data
        uint32_t count
        uint32_t capacity

    cdef struct ufbx_int64_list:
        int64_t *data
        uint32_t count
        uint32_t capacity

    # UFBX_LIST_TYPE(ufbx_float_list, float)
    cdef struct ufbx_float_list:
        float *data
        uint32_t count
        uint32_t capacity

    # UFBX_LIST_TYPE(ufbx_double_list, double)
    cdef struct ufbx_double_list:
        double *data
        uint32_t count
        uint32_t capacity

    # UFBX_LIST_TYPE(ufbx_blob_list, ufbx_blob)
    cdef struct ufbx_blob_list:
        ufbx_blob *data
        uint32_t count
        uint32_t capacity


    # Error types
    cdef enum ufbx_error_type:
        UFBX_ERROR_NONE
        UFBX_ERROR_UNKNOWN
        UFBX_ERROR_FILE_NOT_FOUND
        UFBX_ERROR_EMPTY_FILE

    cdef struct ufbx_dom_value:
        ufbx_dom_value_type type
        ufbx_string value_str
        ufbx_blob value_blob
        int64_t value_int
        double value_float



    # Document object model

    cdef struct ufbx_dom_node_list:
        ufbx_dom_node **data
        uint32_t count
        uint32_t capacity

    cdef struct ufbx_dom_value_list:
        ufbx_dom_value *data
        uint32_t count
        uint32_t capacity

    cdef struct ufbx_dom_node:
        ufbx_string name
        ufbx_dom_node_list children
        ufbx_dom_value_list values

    # Properties
    cdef struct ufbx_prop:
        pass
    
    cdef struct ufbx_props:
        pass
    cdef enum ufbx_prop_type:
        # Enumerators start from 0 by default
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


    cdef enum ufbx_prop_flags:
        # Supports animation.
        UFBX_PROP_FLAG_ANIMATABLE = 0x1

        # User defined (custom) property.
        UFBX_PROP_FLAG_USER_DEFINED = 0x2

        # Hidden in UI.
        UFBX_PROP_FLAG_HIDDEN = 0x4

        # Disallow modification from UI for components.
        UFBX_PROP_FLAG_LOCK_X = 0x10
        UFBX_PROP_FLAG_LOCK_Y = 0x20
        UFBX_PROP_FLAG_LOCK_Z = 0x40
        UFBX_PROP_FLAG_LOCK_W = 0x80

        # Disable animation from components.
        UFBX_PROP_FLAG_MUTE_X = 0x100
        UFBX_PROP_FLAG_MUTE_Y = 0x200
        UFBX_PROP_FLAG_MUTE_Z = 0x400
        UFBX_PROP_FLAG_MUTE_W = 0x800

        # Property created by ufbx when an element has a connected `ufbx_anim_prop`.
        UFBX_PROP_FLAG_SYNTHETIC = 0x1000

        # The property has at least one `ufbx_anim_prop` in some layer.
        UFBX_PROP_FLAG_ANIMATED = 0x2000

        # Used by `ufbx_evaluate_prop()` to indicate the property was not found.
        UFBX_PROP_FLAG_NOT_FOUND = 0x4000

        # The property is connected to another one.
        UFBX_PROP_FLAG_CONNECTED = 0x8000

        # The value of this property is undefined (represented as zero).
        UFBX_PROP_FLAG_NO_VALUE = 0x10000

        # This property has been overridden by the user.
        UFBX_PROP_FLAG_OVERRIDDEN = 0x20000

        # Value type flags.
        UFBX_PROP_FLAG_VALUE_REAL = 0x100000
        UFBX_PROP_FLAG_VALUE_VEC2 = 0x200000
        UFBX_PROP_FLAG_VALUE_VEC3 = 0x400000
        UFBX_PROP_FLAG_VALUE_VEC4 = 0x800000
        UFBX_PROP_FLAG_VALUE_INT  = 0x1000000
        UFBX_PROP_FLAG_VALUE_STR  = 0x2000000
        UFBX_PROP_FLAG_VALUE_BLOB = 0x4000000

    # Define the structure for ufbx_prop
    # Single property with name/type/value.

    cdef struct ufbx_prop:
        ufbx_string name

        uint32_t _internal_key

        ufbx_prop_type type
        ufbx_prop_flags flags

        ufbx_string value_str
        ufbx_blob value_blob
        int64_t value_int

        # Cython translation of the anonymous union.
        # We flatten the union members directly into the struct, 
        # relying on the C compiler to handle the memory overlay.
        # This is the standard way to handle anonymous unions in Cython.
        ufbx_real[4] value_real_arr
        ufbx_real value_real
        ufbx_vec2 value_vec2
        ufbx_vec3 value_vec3
        ufbx_vec4 value_vec4
    
    # List of alphabetically sorted properties with potential defaults.
    # For animated objects in as scene from `ufbx_evaluate_scene()` this list
    # only has the animated properties, the originals are stored under `defaults`.

    cdef struct ufbx_props:
        ufbx_prop_list props
        size_t num_animated
        ufbx_nullable ufbx_props *defaults
    
    cdef struct ufbx_scene:
        pass
    
    cdef struct ufbx_element:
        pass

    cdef struct ufbx_unknown:
        pass

    cdef struct ufbx_node:
        pass
