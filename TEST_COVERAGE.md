# Flutter FreeDome - Test Coverage Documentation

This document outlines the comprehensive test coverage for the Flutter FreeDome library, including testing strategies, coverage reports, and guidelines for maintaining high-quality tests.

## 📊 Coverage Overview

The Flutter FreeDome library maintains comprehensive test coverage across all major components:

### Test Categories

1. **Unit Tests** (`test/unit/`) - 🔬
   - Data models and their extensions
   - Core services (Provider, Auth, Connection, Content)
   - Business logic and state management
   - Error handling and edge cases

2. **Widget Tests** (`test/widget/`) - 🎨
   - UI components and their interactions
   - State changes and user interactions
   - Widget rendering and layout
   - Custom widget behaviors

3. **Integration Tests** (`test/integration/`) - 🔄
   - End-to-end workflows
   - Service interactions
   - API compatibility
   - Real-world usage scenarios

## 🧪 Test Structure

### Unit Tests

#### Models (`test/unit/models/`)
- **`dome_models_test.dart`** - Tests for FreeDome system models
  - DomeSystem creation, serialization, and extensions
  - ProjectorConfig and AudioChannel models
  - User roles and permissions
  - Session management models
  - Model validation and edge cases

- **`content_models_test.dart`** - Tests for content-related models
  - ProjectionContent and its variants
  - PlaybackState management
  - Playlist operations
  - Interactive and realtime content
  - Content type extensions and formatting

#### Core Services (`test/unit/core/`)
- **`freedome_provider_test.dart`** - Main provider functionality
  - Initialization and lifecycle management
  - Connection management
  - Authentication flows
  - Content operations
  - Permission management
  - Error handling

- **`auth_service_test.dart`** - Authentication service
  - Guest session creation
  - Admin authentication
  - Permission validation
  - Role management
  - Session persistence
  - Security features

### Widget Tests

- **`freedome_status_indicator_test.dart`** - Status indicator widget
  - Connection state visualization
  - Error state handling
  - User interaction callbacks
  - Visual styling and theming
  - Detailed status information

- **`freedome_connection_widget_test.dart`** - Connection management widget
  - Auto-connection functionality
  - Manual connection dialogs
  - Discovered systems display
  - Connection state transitions
  - User interaction handling

### Integration Tests

- **`flutter_freedome_integration_test.dart`** - Comprehensive integration testing
  - Full library initialization
  - Authentication workflows
  - Content management operations
  - Permission enforcement
  - Error handling across services
  - Model serialization/deserialization
  - Memory management and cleanup

## 🚀 Running Tests

### Quick Commands

```bash
# Run all tests
make test

# Run specific test categories
make test-unit          # Unit tests only
make test-widget        # Widget tests only  
make test-integration   # Integration tests only

# Generate coverage reports
make coverage          # Generate coverage
make coverage-html     # Generate and open HTML report
```

### Detailed Commands

```bash
# Run tests with verbose output
flutter test --verbose

# Run specific test file
flutter test test/unit/models/dome_models_test.dart

# Run tests with coverage
flutter test --coverage

# Run tests matching pattern
flutter test --plain-name="authentication"
```

### Coverage Analysis

```bash
# Generate comprehensive coverage report
./test_coverage.sh

# Generate and open HTML report
./test_coverage.sh --open

# Check coverage threshold (80% minimum)
make coverage-check
```

## 📈 Coverage Metrics

### Target Coverage Goals

- **Overall Coverage**: ≥ 80%
- **Unit Test Coverage**: ≥ 90%
- **Widget Test Coverage**: ≥ 85%
- **Integration Test Coverage**: ≥ 75%

### Coverage Areas

#### Core Functionality ✅
- [x] FreeDome Provider (95%+)
- [x] Authentication Service (90%+)
- [x] Connection Service (85%+)
- [x] Content Service (90%+)

#### Data Models ✅
- [x] Dome Models (95%+)
- [x] Content Models (95%+)
- [x] Calibration Models (80%+)
- [x] Model Extensions (100%)

#### UI Components ✅
- [x] Status Indicator Widget (90%+)
- [x] Connection Widget (85%+)
- [x] Content Player Widget (80%+)

#### Integration Scenarios ✅
- [x] Full Library Lifecycle (85%+)
- [x] Authentication Workflows (90%+)
- [x] Content Management (80%+)
- [x] Error Handling (85%+)

## 🎯 Test Quality Guidelines

### Unit Test Best Practices

1. **Isolation** - Each test should be independent
2. **Clarity** - Test names should describe the expected behavior
3. **Coverage** - Test both success and failure scenarios
4. **Mocking** - Use mocks for external dependencies
5. **Assertions** - Use specific, meaningful assertions

### Widget Test Best Practices

1. **User Perspective** - Test from the user's point of view
2. **Interactions** - Test user interactions and gestures
3. **State Changes** - Verify UI updates correctly
4. **Accessibility** - Include accessibility testing
5. **Performance** - Test widget performance characteristics

### Integration Test Best Practices

1. **Real Scenarios** - Test actual usage patterns
2. **End-to-End** - Test complete workflows
3. **Error Cases** - Test error recovery
4. **Data Flow** - Test data flow between components
5. **Performance** - Test performance under load

## 🔧 Test Configuration

### Dependencies

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.4
  test: ^1.24.9
  coverage: ^1.9.2
  test_coverage: ^0.5.0
```

### Coverage Configuration

The library uses a custom coverage script (`test_coverage.sh`) that:

- Runs all test categories separately
- Combines coverage data
- Excludes generated files from coverage
- Generates HTML reports
- Enforces coverage thresholds
- Provides detailed coverage metrics

### CI/CD Integration

```bash
# CI-friendly test execution
make ci-test

# Full CI pipeline
make ci-full
```

## 📊 Coverage Reports

### HTML Reports

HTML coverage reports are generated in `coverage/html/index.html` and include:

- Line-by-line coverage visualization
- Function coverage statistics
- Branch coverage analysis
- Uncovered code highlighting
- Coverage trends over time

### Text Reports

Text coverage summaries are available in `coverage/summary.txt` with:

- Overall coverage percentages
- Per-file coverage breakdown
- Coverage by test category
- Missing coverage identification

## 🚦 Coverage Enforcement

### Automated Checks

- **Pre-commit hooks** - Run coverage checks before commits
- **CI/CD pipeline** - Enforce coverage thresholds
- **Pull request checks** - Verify coverage maintenance
- **Release gates** - Require coverage for releases

### Manual Verification

```bash
# Check current coverage
make coverage-check

# View detailed coverage
make coverage-html

# Analyze uncovered code
lcov --list coverage/lcov.info
```

## 🎓 Example Test Scenarios

### Unit Test Example

```dart
test('should create FreeDomeProvider with correct initial state', () {
  final provider = FreeDomeProvider();
  
  expect(provider.isInitialized, false);
  expect(provider.isReady, false);
  expect(provider.currentRole, FreeDomeUserRole.guest);
});
```

### Widget Test Example

```dart
testWidgets('should show connected status when connected', (tester) async {
  when(mockProvider.isConnected).thenReturn(true);
  
  await tester.pumpWidget(createTestWidget());
  
  expect(find.text('Подключен'), findsOneWidget);
  expect(find.byIcon(Icons.wifi), findsOneWidget);
});
```

### Integration Test Example

```dart
test('should complete full authentication workflow', () async {
  final provider = await FlutterFreeDome.initializeGuest();
  
  expect(provider.currentRole, FreeDomeUserRole.guest);
  
  final success = await provider.authenticateAsAdmin(
    username: 'admin',
    password: 'admin123',
  );
  
  expect(success, true);
  expect(provider.currentRole, FreeDomeUserRole.admin);
});
```

## 📝 Contributing to Tests

### Adding New Tests

1. **Identify test category** - Unit, Widget, or Integration
2. **Follow naming conventions** - `feature_test.dart`
3. **Use appropriate test patterns** - Based on test type
4. **Include edge cases** - Test error conditions
5. **Update coverage goals** - Maintain coverage standards

### Test Maintenance

1. **Regular updates** - Keep tests current with code changes
2. **Refactoring** - Improve test quality and readability
3. **Performance** - Optimize test execution time
4. **Documentation** - Update test documentation
5. **Coverage monitoring** - Track coverage trends

## 🔍 Debugging Tests

### Common Issues

1. **Mock setup** - Ensure mocks are properly configured
2. **Async operations** - Handle async code correctly
3. **Widget pumping** - Use appropriate pump methods
4. **State management** - Reset state between tests
5. **Resource cleanup** - Dispose resources properly

### Debugging Tools

```bash
# Run tests with debugging
make test-debug

# Run single test file
make test-single FILE=test/unit/models/dome_models_test.dart

# Verbose test output
flutter test --verbose
```

## 📋 Coverage Checklist

### Before Release

- [ ] All tests passing
- [ ] Coverage ≥ 80% overall
- [ ] No critical uncovered paths
- [ ] Integration tests cover main workflows
- [ ] Widget tests cover UI interactions
- [ ] Unit tests cover business logic
- [ ] Error scenarios tested
- [ ] Performance tests passing
- [ ] Documentation updated

### Continuous Monitoring

- [ ] Coverage trends tracked
- [ ] Test execution time monitored
- [ ] Flaky tests identified and fixed
- [ ] Coverage gaps addressed
- [ ] New features have tests
- [ ] Deprecated code tests removed
- [ ] Test documentation current

---

## 📚 Additional Resources

- [Flutter Testing Documentation](https://flutter.dev/docs/testing)
- [Mockito Documentation](https://pub.dev/packages/mockito)
- [Test Coverage Best Practices](https://martinfowler.com/bliki/TestCoverage.html)
- [Flutter Widget Testing Guide](https://flutter.dev/docs/cookbook/testing/widget)

For questions about testing or coverage, please refer to the development team or create an issue in the project repository.
