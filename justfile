set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]

alias b := build
default: autoformat lint generate_list generate_wrappers build_dev run
build_release: autoformat lint build test



test:
	@echo "Running tests..."
	
	uv run --no-sync python -m pytest tests/ --maxfail=1 -s
	
lint:
	@echo "Linting code..."
	uv run --no-sync black pufbx/ tests/
	uv run --no-sync isort pufbx/ tests/
# 	uv run flake8 pufbx/ tests/

autoformat:
	@echo "Autoformatting code..."
	uv run --no-sync autopep8 --in-place --recursive pufbx/

generate_list:
	@echo "Generating type list..."
	uv run --no-sync pufbx/utils/generate_list.py

generate_wrappers:
	@echo "Generating wrappers..."
	uv run --no-sync pufbx/utils/generate_wrappers.py
build_dev:
	@echo "Building pufbx..."
	uv pip install -e .

build:
	@echo "Building pufbx for release..."
	uv run --no-sync pufbx/utils/generate_list.py
	uv run --no-sync pufbx/utils/generate_wrappers.py
	uv pip install .
	
run:
	@echo "Running pufbx..."
	uv run test.test.py
# 	uv run --no-sync test2.test.py
