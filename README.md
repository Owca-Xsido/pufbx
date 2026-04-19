# pyufbx

[![CI](https://github.com/Owca-Xsido/pyufbx/actions/workflows/build.yml/badge.svg)](https://github.com/Owca-Xsido/pyufbx/actions/workflows/build.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Python 3.9+](https://img.shields.io/badge/python-3.9%2B-blue.svg)](https://www.python.org/downloads/)

Fast, Pythonic bindings for the [ufbx](https://github.com/ufbx/ufbx) FBX file loader by [Samuli Raivio (@bqqbarbhg)](https://github.com/bqqbarbhg).

**pyufbx** wraps the battle-tested C library *ufbx* via Cython, giving you
high-performance access to FBX scene data — nodes, meshes, bones, animations,
materials, and more — without writing a single line of C.

## Features

- **Fast** — thin Cython layer over native C; loads large FBX files in milliseconds
- **Pythonic API** — scene-graph traversal, properties, iteration, `len()`, and numpy arrays
- **Animation baking** — `bake_anim()` composites full transform chains into quaternion keyframes
- **Dense export** — `anim_to_array()` returns `(nodes × frames × 10)` numpy arrays ready for ML pipelines
- **Raw curves** — access original Euler-angle keyframes with Bezier tangent handles
- **Cross-platform** — Linux, macOS, and Windows wheels for Python 3.9–3.13

## Installation

### From PyPI

```bash
pip install pyufbx
```

### From source

```bash
git clone https://github.com/Owca-Xsido/pyufbx.git
cd pyufbx
uv sync --extra dev
```

> **Note:** Building from source requires a C compiler and Python development
> headers (`python3-dev` / `python3.x-dev` on Debian/Ubuntu).

## Quick start

### Load a scene and traverse nodes

```python
import pyufbx

scene = pyufbx.load_fbx("character.fbx")

print(f"Nodes: {len(scene.nodes)}")

for node in scene.nodes:
    indent = "  " * node.node_depth
    print(f"{indent}{node.name}  type={node.attrib_type}")
```

### Bake animation to quaternion keyframes

```python
import pyufbx

scene = pyufbx.load_fbx("character.fbx")
baked = pyufbx.bake_anim(scene)

for node in baked.modified_nodes:
    r = node.rotation_keys
    print(f"Node {node.typed_id}: {len(r)} rotation keyframes")
```

### Export dense numpy array (ML-ready)

```python
import pyufbx

data, times, names = pyufbx.anim_to_array("character.fbx")
# data.shape  → (num_nodes, num_frames, 10)
# channels: [tx, ty, tz, rx, ry, rz, rw, sx, sy, sz]
```

## Examples

See the [`examples/`](examples/) directory for complete, runnable scripts:

| Script | Description |
|--------|-------------|
| [`01_load_scene.py`](examples/01_load_scene.py) | Load a scene and print the node hierarchy |
| [`02_bake_rotation.py`](examples/02_bake_rotation.py) | Bake animation and read rotation quaternions |
| [`03_anim_to_array.py`](examples/03_anim_to_array.py) | Export animation to a dense numpy array |
| [`04_raw_curves.py`](examples/04_raw_curves.py) | Access raw Euler-angle curves with Bezier tangents |

## Development

Install [uv](https://docs.astral.sh/uv/), then:

```bash
git clone https://github.com/Owca-Xsido/pyufbx.git
cd pyufbx
uv sync --extra dev
uv run pytest tests/
```

### Formatting & linting

```bash
uv run black pyufbx/ tests/
uv run isort pyufbx/ tests/
```

## How it works

pyufbx vendors the [ufbx](https://github.com/ufbx/ufbx) C source (by
[Samuli Raivio](https://github.com/bqqbarbhg)) and compiles it into a shared
Cython extension. On Linux/macOS, `ufbx_wrapper` is loaded with `RTLD_GLOBAL`
so all extension modules share a single copy of the ufbx C symbols (required
for ufbx string interning via pointer identity).

## License

[MIT](LICENSE) — see the license file for details.

The vendored [ufbx](https://github.com/ufbx/ufbx) library is Copyright (c) 2020
[Samuli Raivio (@bqqbarbhg)](https://github.com/bqqbarbhg), available under the
MIT License or the Unlicense (public domain) at your option.
