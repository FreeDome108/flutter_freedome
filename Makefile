# Flutter FreeDome Library - Makefile
# Provides convenient commands for development, testing, and coverage

.PHONY: help test test-unit test-widget test-integration coverage coverage-html clean deps gen lint format analyze build example-build example-run

# Default target
help: ## Show this help message
	@echo "Flutter FreeDome Library - Available Commands:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# Dependencies
deps: ## Install dependencies
	@echo "📦 Installing dependencies..."
	flutter pub get
	cd example && flutter pub get

# Code generation
gen: ## Generate code (JSON serialization, etc.)
	@echo "🔧 Running code generation..."
	flutter packages pub run build_runner build --delete-conflicting-outputs

# Testing
test: ## Run all tests
	@echo "🧪 Running all tests..."
	flutter test

test-unit: ## Run unit tests only
	@echo "🔬 Running unit tests..."
	flutter test test/unit/

test-widget: ## Run widget tests only
	@echo "🎨 Running widget tests..."
	flutter test test/widget/

test-integration: ## Run integration tests only
	@echo "🔄 Running integration tests..."
	flutter test test/integration/

test-verbose: ## Run all tests with verbose output
	@echo "🧪 Running all tests (verbose)..."
	flutter test --verbose

# Coverage
coverage: ## Generate test coverage report
	@echo "📊 Generating test coverage..."
	./test_coverage.sh

coverage-html: ## Generate test coverage with HTML report and open it
	@echo "📋 Generating HTML coverage report..."
	./test_coverage.sh --open

coverage-simple: ## Simple coverage report using Flutter built-in
	@echo "📈 Running simple coverage..."
	flutter test --coverage
	@if command -v lcov >/dev/null 2>&1; then \
		lcov --list coverage/lcov.info; \
	else \
		echo "Install lcov for detailed coverage analysis"; \
	fi

# Code quality
lint: ## Run linter
	@echo "🔍 Running linter..."
	flutter analyze

format: ## Format code
	@echo "✨ Formatting code..."
	flutter format lib/ test/ example/lib/

format-check: ## Check code formatting
	@echo "📝 Checking code formatting..."
	flutter format --set-exit-if-changed lib/ test/ example/lib/

analyze: ## Run static analysis
	@echo "🔬 Running static analysis..."
	flutter analyze --fatal-infos

# Build
build: ## Build library
	@echo "🏗️  Building library..."
	flutter packages pub publish --dry-run

# Example app
example-deps: ## Install example app dependencies
	@echo "📦 Installing example dependencies..."
	cd example && flutter pub get

example-build: ## Build example app
	@echo "🏗️  Building example app..."
	cd example && flutter build apk --debug

example-run: ## Run example app
	@echo "🚀 Running example app..."
	cd example && flutter run

example-test: ## Test example app
	@echo "🧪 Testing example app..."
	cd example && flutter test

# Cleanup
clean: ## Clean build artifacts
	@echo "🧹 Cleaning build artifacts..."
	flutter clean
	cd example && flutter clean
	rm -rf coverage/
	rm -rf .dart_tool/
	rm -rf build/

clean-deps: ## Clean and reinstall dependencies
	@echo "🔄 Cleaning and reinstalling dependencies..."
	make clean
	make deps

# CI/CD helpers
ci-test: ## Run tests suitable for CI environment
	@echo "🤖 Running CI tests..."
	flutter test --coverage --reporter=github
	@if [ -f coverage/lcov.info ]; then \
		echo "Coverage data generated"; \
	fi

ci-analyze: ## Run analysis suitable for CI environment
	@echo "🤖 Running CI analysis..."
	flutter analyze --fatal-infos --fatal-warnings

ci-format-check: ## Check formatting for CI
	@echo "🤖 Checking formatting for CI..."
	flutter format --set-exit-if-changed lib/ test/ example/lib/

ci-full: deps gen ci-format-check ci-analyze ci-test ## Run full CI pipeline

# Development helpers
dev-setup: ## Set up development environment
	@echo "🛠️  Setting up development environment..."
	make deps
	make gen
	@echo "✅ Development environment ready!"

quick-check: ## Quick development check (format, analyze, test)
	@echo "⚡ Running quick development check..."
	make format
	make analyze
	make test-unit
	@echo "✅ Quick check completed!"

# Documentation
docs: ## Generate documentation
	@echo "📚 Generating documentation..."
	dartdoc --output docs/
	@echo "Documentation generated in docs/ directory"

# Release helpers
version-check: ## Check current version
	@echo "📋 Current version information:"
	@grep "version:" pubspec.yaml
	@grep "static String get version" lib/flutter_freedome.dart

# Performance testing
test-performance: ## Run performance-focused tests
	@echo "⚡ Running performance tests..."
	flutter test test/integration/ --plain-name="performance"

# Specific test categories
test-models: ## Test data models only
	@echo "📊 Testing data models..."
	flutter test test/unit/models/

test-services: ## Test core services only
	@echo "🔧 Testing core services..."
	flutter test test/unit/core/

test-widgets: ## Test UI widgets only
	@echo "🎨 Testing UI widgets..."
	flutter test test/widget/

# Debugging helpers
test-debug: ## Run tests with debugging enabled
	@echo "🐛 Running tests with debugging..."
	flutter test --start-paused

test-single: ## Run a single test file (usage: make test-single FILE=test/unit/models/dome_models_test.dart)
	@echo "🎯 Running single test file: $(FILE)"
	flutter test $(FILE)

# Coverage thresholds
coverage-check: ## Check if coverage meets minimum threshold
	@echo "📊 Checking coverage threshold..."
	./test_coverage.sh
	@echo "Coverage check completed"

# Git hooks helpers
pre-commit: ## Run pre-commit checks
	@echo "🔍 Running pre-commit checks..."
	make format-check
	make analyze
	make test-unit
	@echo "✅ Pre-commit checks passed!"

# Help for common workflows
workflow-help: ## Show common development workflows
	@echo ""
	@echo "🚀 Common Development Workflows:"
	@echo ""
	@echo "📝 Initial Setup:"
	@echo "   make dev-setup"
	@echo ""
	@echo "🔄 Daily Development:"
	@echo "   make quick-check        # Format, analyze, and test"
	@echo "   make test               # Run all tests"
	@echo "   make coverage           # Generate coverage report"
	@echo ""
	@echo "🚀 Before Committing:"
	@echo "   make pre-commit         # Run all pre-commit checks"
	@echo ""
	@echo "🎯 Testing Specific Areas:"
	@echo "   make test-models        # Test data models"
	@echo "   make test-services      # Test core services"
	@echo "   make test-widgets       # Test UI widgets"
	@echo ""
	@echo "📊 Coverage Analysis:"
	@echo "   make coverage-html      # Generate and open HTML report"
	@echo "   make coverage-check     # Check coverage threshold"
	@echo ""
	@echo "🏗️  Building:"
	@echo "   make build              # Build library"
	@echo "   make example-run        # Run example app"
	@echo ""
