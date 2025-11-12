from libc.stdint cimport uint32_t, uint64_t, int32_t, int64_t
from libc.stddef cimport size_t


cdef extern from "ufbx.h":

    # Basic types 

    ctypedef double ufbx_real 
    

    # Null-terminated UTF-8 encoded string within an FBX file
    ctypedef struct ufbx_string:
        const char *data
        size_t length

    # Opaque byte buffer blob
    ctypedef struct ufbx_blob:
        const void *data
        size_t size

    # 2d Vector
    ctypedef struct ufbx_vec2:
            ufbx_real x
            ufbx_real y

    # 3d Vector
    ctypedef struct ufbx_vec3:
        ufbx_real x
        ufbx_real y
        ufbx_real z

    # 4d Vector
    ctypedef struct ufbx_vec4:
        ufbx_real x
        ufbx_real y
        ufbx_real z
        ufbx_real w

    # Quaterion
    ctypedef struct ufbx_quat:

        ufbx_real x
        ufbx_real y
        ufbx_real z
        ufbx_real w

    # Declare the ufbx_rotation_order enumeration
    ctypedef enum ufbx_rotation_order:
        UFBX_ROTATION_ORDER_XYZ
        UFBX_ROTATION_ORDER_XZY
        UFBX_ROTATION_ORDER_YZX
        UFBX_ROTATION_ORDER_YXZ
        UFBX_ROTATION_ORDER_ZXY
        UFBX_ROTATION_ORDER_ZYX
        UFBX_ROTATION_ORDER_SPHERIC
    

    # Explicit translation+rotation+scale transformation.
    # Rotation represented as a quaterion
    ctypedef struct ufbx_transform:
        ufbx_vec3 translation
        ufbx_quat rotation 
        ufbx_vec3 scale



    # 4x3 matrix encoding an affine transformation.
    # `cols[0..2]` are the X/Y/Z basis vectors, `cols[3]` is the translation

    ctypedef struct ufbx_matrix:
        # X axis
        ufbx_real m00, m10, m20
        # Y axis
        ufbx_real m01, m11, m21
        # Z axis
        ufbx_real m02, m12, m22
        # translation
        ufbx_real m03, m13, m23
    
    # Void list
    ctypedef struct ufbx_void_list:
        void *data
        size_t count

    ctypedef struct ufbx_bool_list:
        bint *data  
        size_t count

    # ufbx_uint32_list
    ctypedef struct ufbx_uint32_list:
        uint32_t *data
        size_t count

    # ufbx_real_list
    ctypedef struct ufbx_real_list:
        ufbx_real *data
        size_t count

    # ufbx_vec2_list
    ctypedef struct ufbx_vec2_list:
        ufbx_vec2 *data
        size_t count

    # ufbx_vec3_list
    ctypedef struct ufbx_vec3_list:
        ufbx_vec3 *data
        size_t count

    # ufbx_vec4_list
    ctypedef struct ufbx_vec4_list:
        ufbx_vec4 *data
        size_t count

    # ufbx_string_list
    ctypedef struct ufbx_string_list:
        ufbx_string *data
        size_t count


    # Declare the ufbx_dom_value_type enumeration
    ctypedef enum ufbx_dom_value_type:
        UFBX_DOM_VALUE_NUMBER
        UFBX_DOM_VALUE_STRING
        UFBX_DOM_VALUE_BLOB
        UFBX_DOM_VALUE_ARRAY_I32
        UFBX_DOM_VALUE_ARRAY_I64
        UFBX_DOM_VALUE_ARRAY_F32
        UFBX_DOM_VALUE_ARRAY_F64
        UFBX_DOM_VALUE_ARRAY_BLOB
        UFBX_DOM_VALUE_ARRAY_IGNORED  

    ctypedef struct ufbx_dom_node:        
        pass

    ctypedef struct ufbx_int32_list:
        int32_t *data
        uint32_t count
        uint32_t capacity

    ctypedef struct ufbx_int64_list:
        int64_t *data
        uint32_t count
        uint32_t capacity

    # UFBX_LIST_TYPE(ufbx_float_list, float)
    ctypedef struct ufbx_float_list:
        float *data
        uint32_t count
        uint32_t capacity

    # UFBX_LIST_TYPE(ufbx_double_list, double)
    ctypedef struct ufbx_double_list:
        double *data
        uint32_t count
        uint32_t capacity

    # UFBX_LIST_TYPE(ufbx_blob_list, ufbx_blob)
    ctypedef struct ufbx_blob_list:
        ufbx_blob *data
        uint32_t count
        uint32_t capacity

    # Error types
    ctypedef enum ufbx_error_type:
        UFBX_ERROR_NONE
        UFBX_ERROR_UNKNOWN
        UFBX_ERROR_FILE_NOT_FOUND
        UFBX_ERROR_EMPTY_FILE

