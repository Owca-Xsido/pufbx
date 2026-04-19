import pathlib
from concurrent.futures import ThreadPoolExecutor, as_completed

import pufbx as fbx

_FIXTURE = pathlib.Path(__file__).resolve().parent / "fixtures" / "cube_and_bone.fbx"


def _load_and_read() -> int:
    scene = fbx.load_fbx(str(_FIXTURE))
    root = scene.root_node
    assert root is not None
    assert isinstance(root.name, str)
    _ = len(scene.nodes)
    return scene.num_nodes


def test_parallel_load_fbx_matches_reference():
    expected = _load_and_read()
    n_workers = 16
    n_tasks = 64
    with ThreadPoolExecutor(max_workers=n_workers) as pool:
        futures = [pool.submit(_load_and_read) for _ in range(n_tasks)]
        results = [f.result() for f in as_completed(futures)]
    assert results.count(expected) == n_tasks


def test_parallel_load_fbx_staggered_submit():
    expected = _load_and_read()
    n_workers = 8
    n_rounds = 4
    with ThreadPoolExecutor(max_workers=n_workers) as pool:
        all_results: list[int] = []
        for _ in range(n_rounds):
            futures = [pool.submit(_load_and_read) for _ in range(n_workers)]
            all_results.extend(f.result() for f in as_completed(futures))
    assert all(n == expected for n in all_results)
