alias b := build
host := `uname -a`
default: autoformat lint build_dev test run
build_release: autoformat lint build test



test:
	@echo "Running tests..."
	
	uv run pytest tests/ --maxfail=1 -s
lint:
	@echo "Linting code..."
	uv run black pyufbx/ tests/
	uv run isort pyufbx/ tests/
# 	uv run flake8 pyufbx/ tests/

autoformat:
	@echo "Autoformatting code..."
	uv run autopep8 --in-place --recursive pyufbx/

build_dev:
	@echo "Building pyufbx..."
	uv pip install -e .

build:
	@echo "Building pyufbx for release..."
	uv run pyufbx/utils/generate_list.py
	uv run pyufbx/utils/generate_wrappers.py
	uv pip install .
	
run:
	@echo "Running pyufbx..."
	uv run test2.test.py
# 	uv run test.test.py
