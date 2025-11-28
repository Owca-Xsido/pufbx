alias b := build
host := `uname -a`

build:
	@echo "Building pyufbx..."
	uv run src/utils/generate_list.py
	uv run src/utils/generate_wrappers.py
	uv pip install -e .