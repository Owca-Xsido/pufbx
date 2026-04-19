from enum import IntEnum


class ErrorType(IntEnum):
    NONE = 0
    UNKNOWN = 1
    FILE_NOT_FOUND = 2
    EMPTY_FILE = 3
    EXTERNAL_FILE_NOT_FOUND = 4
    OUT_OF_MEMORY = 5
    MEMORY_LIMIT = 6
    ALLOCATION_LIMIT = 7
    TRUNCATED_FILE = 8
    IO = 9
    CANCELLED = 10
    UNRECOGNIZED_FILE_FORMAT = 11
    UNINITIALIZED_OPTIONS = 12
    ZERO_VERTEX_SIZE = 13
    TRUNCATED_VERTEX_STREAM = 14
    INVALID_UTF8 = 15
    FEATURE_DISABLED = 16
    BAD_NURBS = 17
    BAD_INDEX = 18
    NODE_DEPTH_LIMIT = 19
    THREADED_ASCII_PARSE = 20
    UNSAFE_OPTIONS = 21
    DUPLICATE_OVERRIDE = 22
    UNSUPPORTED_VERSION = 23


class UFBXError(RuntimeError):
    def __init__(self, message: str, *, error_type: int = 0) -> None:
        super().__init__(message)
        self.error_type = error_type
