"""Type stubs for ufbx_wrapper module.

Python wrapper for the ufbx library providing FBX file loading and scene graph access.
"""

from enum import IntEnum
from typing import Iterator, List, Optional, Tuple

import numpy as np
import numpy.typing as npt

class Vec3Property:
    """Wrapper for 3D vector properties with conversion methods.

    Represents a 3D vector (x, y, z) with convenient conversion methods
    to different Python data structures.
    """

    x: float
    """X component of the vector."""
    y: float
    """Y component of the vector."""
    z: float
    """Z component of the vector."""

    def __init__(self, x: float, y: float, z: float) -> None:
        """Initialize a 3D vector.

        Args:
            x: X component
            y: Y component
            z: Z component
        """
        ...

    def as_list(self) -> List[float]:
        """Returns as plain Python list [x, y, z]."""
        ...

    def as_tuple(self) -> Tuple[float, float, float]:
        """Returns as tuple (x, y, z)."""
        ...

    def as_array(self) -> npt.NDArray[np.float64]:
        """Returns as numpy array of shape (3,) with dtype float64."""
        ...

    def __repr__(self) -> str: ...
    def __iter__(self) -> Iterator[float]:
        """Allows unpacking: x, y, z = vec"""
        ...

class QuatProperty:
    """Wrapper for quaternion with conversion methods.

    Represents a quaternion (x, y, z, w) for 3D rotations with convenient
    conversion methods to different Python data structures.
    """

    x: float
    """X component of the quaternion."""
    y: float
    """Y component of the quaternion."""
    z: float
    """Z component of the quaternion."""
    w: float
    """W (scalar) component of the quaternion."""

    def __init__(self, x: float, y: float, z: float, w: float) -> None:
        """Initialize a quaternion.

        Args:
            x: X component
            y: Y component
            z: Z component
            w: W (scalar) component
        """
        ...

    def as_list(self) -> List[float]:
        """Returns as plain Python list [x, y, z, w]."""
        ...

    def as_tuple(self) -> Tuple[float, float, float, float]:
        """Returns as tuple (x, y, z, w)."""
        ...

    def as_array(self) -> npt.NDArray[np.float64]:
        """Returns as numpy array of shape (4,) with dtype float64."""
        ...

    def __repr__(self) -> str: ...
    def __iter__(self) -> Iterator[float]:
        """Allows unpacking: x, y, z, w = quat"""
        ...

class TransformWrapper:
    """Wrapper for ufbx_transform.

    Represents a 3D transformation consisting of translation, rotation, and scale.
    """

    @property
    def translation(self) -> Vec3Property:
        """Translation component of the transform."""
        ...

    @property
    def rotation(self) -> QuatProperty:
        """Rotation component as a quaternion."""
        ...

    @property
    def scale(self) -> Vec3Property:
        """Scale component of the transform."""
        ...

class Property:
    """Wrapper for ufbx_prop.

    Represents a property on an FBX element.
    """

    @property
    def name(self) -> str:
        """Name of the property."""
        ...

    @property
    def type(self) -> int:
        """Type identifier of the property."""
        ...

class Element:
    """Wrapper for ufbx_element.

    Base class for all FBX elements in the scene hierarchy.
    """

    @property
    def name(self) -> str:
        """Name of the element."""
        ...

    @property
    def element_id(self) -> int:
        """Unique identifier for this element across all element types."""
        ...

    @property
    def typed_id(self) -> int:
        """Identifier unique within elements of the same type."""
        ...

    @property
    def type(self) -> ElementType:
        """Type of the element (NODE, MESH, BONE, etc.)."""
        ...

    @property
    def instance_count(self) -> int:
        """Number of instances of this element."""
        ...

class Bone:
    """Wrapper for ufbx_bone.

    Represents a bone in a skeletal hierarchy used for animation.
    """

    @property
    def element(self) -> Optional[Element]:
        """The underlying Element for this bone."""
        ...

    @property
    def name(self) -> str:
        """Name of the bone."""
        ...

    @property
    def instance(self) -> List[Node]:
        """List of node instances associated with this bone."""
        ...

    @property
    def radius(self) -> float:
        """Radius of the bone for visualization."""
        ...

    @property
    def relative_length(self) -> float:
        """Length of the bone relative to its parent."""
        ...

    @property
    def is_root(self) -> bool:
        """True if this is a root bone in the skeleton."""
        ...

class Node:
    """Wrapper for ufbx_node.

    Represents a node in the FBX scene graph hierarchy. Nodes can contain
    meshes, lights, cameras, bones, or be empty transform nodes.

    Supports iteration over children and len() to get child count.
    """

    def __repr__(self) -> str: ...
    def __str__(self) -> str: ...
    def __len__(self) -> int:
        """Returns the number of child nodes."""
        ...

    def __iter__(self) -> Iterator[Node]:
        """Iterate over child nodes."""
        ...

    @property
    def element(self) -> Optional[Element]:
        """The underlying Element for this node."""
        ...

    @property
    def name(self) -> str:
        """Name of the node."""
        ...

    @property
    def properties(self) -> List[Property]:
        """List of properties attached to this node.

        Note: Not yet implemented.
        """
        ...

    @property
    def id(self) -> int:
        """Unique element ID across all element types."""
        ...

    @property
    def typed_id(self) -> int:
        """ID unique within node elements."""
        ...

    @property
    def parent(self) -> Optional[Node]:
        """Parent node, or None if this is the root node."""
        ...

    @property
    def children(self) -> List[Node]:
        """List of child nodes."""
        ...

    @property
    def is_root(self) -> bool:
        """True if this is the root node of the scene."""
        ...

    @property
    def num_children(self) -> int:
        """Number of child nodes."""
        ...

    @property
    def mesh(self) -> Optional[object]:
        """Attached mesh geometry, if any.

        Note: Not yet implemented.
        """
        ...

    @property
    def light(self) -> Optional[object]:
        """Attached light, if any.

        Note: Not yet implemented.
        """
        ...

    @property
    def camera(self) -> Optional[object]:
        """Attached camera, if any.

        Note: Not yet implemented.
        """
        ...

    @property
    def bone(self) -> Optional[Bone]:
        """Attached bone, if this node is part of a skeleton."""
        ...

    @property
    def attrib(self) -> Optional[Element]:
        """Generic attached element for less common types."""
        ...

    @property
    def geometry_transform_helper(self) -> Optional[Node]:
        """Helper node for geometry transforms.

        Note: Not yet implemented.
        """
        ...

    @property
    def scale_helper(self) -> Optional[Node]:
        """Helper node for scale compensation.

        Note: Not yet implemented.
        """
        ...

    @property
    def attrib_type(self) -> ElementType:
        """Type of the attached element."""
        ...

    @property
    def all_attribs(self) -> List[Element]:
        """All attached elements.

        Note: Not yet implemented.
        """
        ...

    @property
    def inherit_mode(self) -> int:
        """Transform inheritance mode."""
        ...

    @property
    def original_inherit_mode(self) -> int:
        """Original transform inheritance mode from the file."""
        ...

    @property
    def rotation_order(self) -> int:
        """Order of rotation axes application."""
        ...

    @property
    def local_transform(self) -> TransformWrapper:
        """Local transform relative to parent (translation, rotation, scale)."""
        ...

    @property
    def geometry_transform(self) -> object:
        """Additional transform applied to geometry."""
        ...

    @property
    def inherit_scale(self) -> object:
        """Scale inheritance settings.

        Note: Not yet implemented.
        """
        ...

    @property
    def inherit_scale_node(self) -> Optional[Node]:
        """Node from which scale is inherited.

        Note: Not yet implemented.
        """
        ...

    @property
    def euler_rotation(self) -> object:
        """Rotation as Euler angles."""
        ...

    @property
    def node_to_parent(self) -> object:
        """Transformation matrix from node space to parent space."""
        ...

    @property
    def node_to_world(self) -> object:
        """Transformation matrix from node space to world space."""
        ...

    @property
    def geometry_to_node(self) -> object:
        """Transformation matrix from geometry space to node space."""
        ...

    @property
    def geometry_to_world(self) -> object:
        """Transformation matrix from geometry space to world space."""
        ...

    @property
    def unscaled_node_to_world(self) -> object:
        """Node-to-world transform without scale."""
        ...

    @property
    def adjust_pre_translation(self) -> object:
        """Pre-translation adjustment for transform."""
        ...

    @property
    def adjust_pre_rotation(self) -> object:
        """Pre-rotation adjustment for transform."""
        ...

    @property
    def adjust_pre_scale(self) -> object:
        """Pre-scale adjustment for transform."""
        ...

    @property
    def adjust_post_rotation(self) -> object:
        """Post-rotation adjustment for transform."""
        ...

    @property
    def adjust_post_scale(self) -> object:
        """Post-scale adjustment for transform."""
        ...

    @property
    def adjust_translation_scale(self) -> object:
        """Scale applied to translation adjustments."""
        ...

    @property
    def adjust_mirror_axis(self) -> object:
        """Axis mirroring for adjustments."""
        ...

    @property
    def materials(self) -> List[object]:
        """Materials attached to this node.

        Note: Not yet implemented.
        """
        ...

    @property
    def bind_pose(self) -> Optional[object]:
        """Bind pose for skeletal animation.

        Note: Not yet implemented.
        """
        ...

    @property
    def is_visible(self) -> bool:
        """True if the node is visible."""
        ...

    @property
    def has_geometry_transform(self) -> bool:
        """True if the node has a geometry transform."""
        ...

    @property
    def has_adjust_transform(self) -> bool:
        """True if the node has adjustment transforms."""
        ...

    @property
    def has_root_adjust_transform(self) -> bool:
        """True if the node has root adjustment transforms."""
        ...

    @property
    def is_geometry_transform_helper(self) -> bool:
        """True if this is a geometry transform helper node."""
        ...

    @property
    def is_scale_helper(self) -> bool:
        """True if this is a scale helper node."""
        ...

    @property
    def is_scale_compensate_parent(self) -> bool:
        """True if this node compensates parent scale."""
        ...

    @property
    def node_depth(self) -> int:
        """Depth of this node in the scene hierarchy."""
        ...

class Scene:
    """Wrapper for ufbx_scene.

    Represents a complete FBX scene with all nodes, meshes, and other elements.
    This is the main entry point after loading an FBX file.
    """

    @property
    def root_node(self) -> Optional[Node]:
        """The root node of the scene hierarchy."""
        ...

    @property
    def nodes(self) -> List[Node]:
        """List of all nodes in the scene."""
        ...

    @property
    def num_nodes(self) -> int:
        """Total number of nodes in the scene."""
        ...

    @property
    def num_meshes(self) -> int:
        """Total number of meshes in the scene."""
        ...

    def get_node_names(self) -> List[str]:
        """Get a list of all node names in the scene.

        Returns:
            List of node names as strings.
        """
        ...

class ElementType(IntEnum):
    """Enum representing ufbx element types.

    Defines all possible types of elements that can exist in an FBX scene.
    """

    UNKNOWN: int
    """Unknown or unrecognized element type."""
    NODE: int
    """Scene graph node."""
    MESH: int
    """Polygonal mesh geometry."""
    LIGHT: int
    """Light source."""
    CAMERA: int
    """Camera."""
    BONE: int
    """Skeletal bone for animation."""
    EMPTY: int
    """Empty/null object."""
    LINE_CURVE: int
    """Line curve geometry."""
    NURBS_CURVE: int
    """NURBS curve geometry."""
    NURBS_SURFACE: int
    """NURBS surface geometry."""
    NURBS_TRIM_SURFACE: int
    """Trimmed NURBS surface."""
    NURBS_TRIM_BOUNDARY: int
    """NURBS trim boundary."""
    PROCEDURAL_GEOMETRY: int
    """Procedurally generated geometry."""
    STEREO_CAMERA: int
    """Stereo camera setup."""
    CAMERA_SWITCHER: int
    """Camera switching control."""
    MARKER: int
    """Motion capture or animation marker."""
    LOD_GROUP: int
    """Level of detail group."""
    SKIN_DEFORMER: int
    """Skin/skeletal deformation."""
    SKIN_CLUSTER: int
    """Skin cluster (bone influence)."""
    BLEND_DEFORMER: int
    """Blend shape deformer."""
    BLEND_CHANNEL: int
    """Blend shape channel."""
    BLEND_SHAPE: int
    """Individual blend shape target."""
    CACHE_DEFORMER: int
    """Cache-based deformation."""
    CACHE_FILE: int
    """External cache file reference."""
    MATERIAL: int
    """Material/shader definition."""
    TEXTURE: int
    """Texture map."""
    VIDEO: int
    """Video/image file reference."""
    SHADER: int
    """Shader program."""
    SHADER_BINDING: int
    """Shader parameter binding."""
    ANIM_STACK: int
    """Animation stack/take."""
    ANIM_LAYER: int
    """Animation layer."""
    ANIM_VALUE: int
    """Animated value."""
    ANIM_CURVE: int
    """Animation curve (keyframes)."""
    DISPLAY_LAYER: int
    """Display/visibility layer."""
    SELECTION_SET: int
    """Named selection set."""
    SELECTION_NODE: int
    """Selection node."""
    CHARACTER: int
    """Character definition."""
    CONSTRAINT: int
    """Animation constraint."""
    AUDIO_LAYER: int
    """Audio layer."""
    AUDIO_CLIP: int
    """Audio clip."""
    POSE: int
    """Static pose definition."""
    METADATA_OBJECT: int
    """Metadata/custom attributes."""

    def __str__(self) -> str: ...
    def __repr__(self) -> str: ...

def load_fbx(filename: str) -> Scene:
    """Load an FBX file and return a Scene object.

    Args:
        filename: Path to the FBX file to load.

    Returns:
        Scene object containing the loaded FBX data.

    Raises:
        FileNotFoundError: If the file cannot be loaded or parsed.

    Example:
        >>> scene = load_fbx("model.fbx")
        >>> print(f"Loaded {scene.num_nodes} nodes")
    """
    ...
