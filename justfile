alias b := build
host := `uname -a`
default: lint build test

build:
	@echo "Building pyufbx..."
	uv run src/utils/generate_list.py
	uv run src/utils/generate_wrappers.py
	uv pip install -e .
	

test:
	@echo "Running tests..."
	uv run pytest tests/ --maxfail=1 --disable-warnings -q

lint:
	@echo "Linting code..."
	uv run black src/ tests/
	uv run isort src/ tests/
	uv run flake8 src/ tests/