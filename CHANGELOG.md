# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [0.1.0] - Unreleased

### Added

- Initial release of pyufbx.
- `load_fbx()` — load FBX files into a Python scene graph.
- `bake_anim()` — bake animation into quaternion keyframes via numpy structured arrays.
- `anim_to_array()` — export animation as dense `(nodes × frames × 10)` numpy arrays.
- Scene-graph traversal: `Scene`, `Node`, `Element`, `Bone`, `Transform`.
- Raw animation curve access: `Anim`, `AnimCurveList`, `KeyframeList`.
- Property access: `PropsWrapper`, `PropType`, `PropFlags`.
- Math types: `Vec2Property`, `Vec3Property`, `Vec4Property`, `QuatProperty`.
- Enums: `InheritMode`, `Interpolation`, `RotationOrder`.
- Pre-built wheels for Linux and Windows (Python 3.9–3.13).
