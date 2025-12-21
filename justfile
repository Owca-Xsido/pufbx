alias b := build
host := `uname -a`
default: autoformat lint generate_list generate_wrappers build_dev test run
build_release: autoformat lint build test



test:
	@echo "Running tests..."
	
	uv run --no-sync pytest tests/ --maxfail=1 -s
	
lint:
	@echo "Linting code..."
	uv run --no-sync black pyufbx/ tests/
	uv run --no-sync isort pyufbx/ tests/
# 	uv run flake8 pyufbx/ tests/

autoformat:
	@echo "Autoformatting code..."
	uv run --no-sync autopep8 --in-place --recursive pyufbx/

generate_list:
	@echo "Generating type list..."
	uv run --no-sync pyufbx/utils/generate_list.py

generate_wrappers:
	@echo "Generating wrappers..."
	uv run --no-sync pyufbx/utils/generate_wrappers.py
build_dev:
	@echo "Building pyufbx..."
	uv pip install -e .

build:
	@echo "Building pyufbx for release..."
	uv run --no-sync pyufbx/utils/generate_list.py
	uv run --no-sync pyufbx/utils/generate_wrappers.py
	uv pip install .
	
run:
	@echo "Running pyufbx..."
	uv run --no-sync test2.test.py
# 	uv run test.test.py
