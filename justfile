alias b := build
host := `uname -a`
default: autoformat lint build_dev test run
build_release: autoformat lint build test



test:
	@echo "Running tests..."
	
	uv run pytest tests/ --maxfail=1 -s
lint:
	@echo "Linting code..."
	uv run black src/ tests/
	uv run isort src/ tests/
# 	uv run flake8 src/ tests/

autoformat:
	@echo "Autoformatting code..."
	uv run autopep8 --in-place --recursive src/

build_dev:
	@echo "Building pyufbx..."
	uv run src/utils/generate_list.py
	uv run src/utils/generate_wrappers.py
	uv pip install -e .

build:
	@echo "Building pyufbx for release..."
	uv run src/utils/generate_list.py
	uv run src/utils/generate_wrappers.py
	uv pip install .
	
run:
	@echo "Running pyufbx..."
	uv run test2.test.py
# 	uv run test.test.py
