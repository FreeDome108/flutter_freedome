# Development Guide

This document provides comprehensive guidance for developers working on the Flutter Magento library.

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.10.0 or higher
- Dart SDK 3.2.3 or higher
- Git
- IDE (VS Code, Android Studio, or IntelliJ IDEA)
- Magento 2.x development environment

### Development Environment Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/flutter_magento.git
   cd flutter_magento
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Install development dependencies**
   ```bash
   flutter pub get --dev
   ```

4. **Generate code**
   ```bash
   flutter packages pub run build_runner build
   ```

## 🏗️ Project Structure

```
lib/
├── src/
│   ├── models/           # Data models using Freezed
│   │   ├── customer.dart
│   │   ├── product.dart
│   │   ├── cart.dart
│   │   └── order.dart
│   ├── services/         # Business logic services
│   │   ├── magento_api_service.dart
│   │   ├── auth_service.dart
│   │   └── cart_service.dart
│   ├── exceptions/       # Custom exceptions
│   │   └── magento_exception.dart
│   ├── constants/        # API constants
│   │   └── magento_constants.dart
│   ├── utils/            # Utility functions
│   │   └── magento_utils.dart
│   └── examples/         # Usage examples
│       └── usage_examples.dart
├── flutter_magento.dart  # Main library entry point
└── flutter_magento_core.dart # Core implementation

example/
├── lib/
│   ├── examples/         # Integration examples
│   │   └── integration_example.dart
│   └── main.dart         # Example app
└── pubspec.yaml

test/
├── flutter_magento_test.dart
└── integration_test/

build.yaml                 # Build configuration
```

## 🔧 Development Workflow

### 1. Code Generation

The library uses code generation for models. After modifying model files, run:

```bash
# Generate code once
flutter packages pub run build_runner build

# Watch for changes and regenerate automatically
flutter packages pub run build_runner watch

# Clean and regenerate
flutter packages pub run build_runner clean
flutter packages pub run build_runner build
```

### 2. Testing

Run tests to ensure code quality:

```bash
# Run unit tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/flutter_magento_test.dart

# Run integration tests
flutter test integration_test/
```

### 3. Code Quality

```bash
# Analyze code
flutter analyze

# Format code
dart format .

# Fix linting issues
dart fix --apply
```

## 📝 Coding Standards

### Dart/Flutter Standards

- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use [Flutter Lints](https://dart.dev/tools/linter-rules)
- Maximum line length: 80 characters
- Use meaningful variable and function names
- Add comprehensive documentation

### Model Classes

- Use Freezed for immutable data classes
- Include JSON serialization
- Add validation where appropriate
- Use proper types (avoid `dynamic` when possible)

Example:
```dart
@freezed
class Customer with _$Customer {
  const factory Customer({
    required int id,
    required String email,
    required String firstname,
    required String lastname,
    String? telephone,
    DateTime? createdAt,
  }) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);
}
```

### Service Classes

- Single responsibility principle
- Proper error handling
- Async/await for asynchronous operations
- Comprehensive logging in debug mode

Example:
```dart
class AuthService {
  Future<Customer> authenticate({
    required String email,
    required String password,
  }) async {
    try {
      // Implementation
    } catch (e) {
      if (e is MagentoException) {
        rethrow;
      }
      throw MagentoException('Authentication failed: $e');
    }
  }
}
```

### Exception Handling

- Use custom `MagentoException` class
- Provide meaningful error messages
- Include error codes and details
- Handle different types of errors appropriately

Example:
```dart
try {
  await apiService.authenticate(email, password);
} on MagentoException catch (e) {
  if (e.isAuthenticationError) {
    // Handle authentication errors
  } else if (e.isNetworkError) {
    // Handle network errors
  }
}
```

## 🧪 Testing Strategy

### Unit Tests

- Test all public methods
- Mock external dependencies
- Test error scenarios
- Use descriptive test names

Example:
```dart
test('should authenticate customer with valid credentials', () async {
  // Arrange
  final authService = AuthService(mockApiService);
  
  // Act
  final customer = await authService.authenticate(
    email: 'test@example.com',
    password: 'password123',
  );
  
  // Assert
  expect(customer, isNotNull);
  expect(customer.email, equals('test@example.com'));
});
```

### Integration Tests

- Test complete workflows
- Test API integration
- Test error handling
- Use test Magento instance

### Test Data

- Use factories for test data
- Create realistic test scenarios
- Test edge cases
- Use consistent test data

## 🔍 Debugging

### Logging

The library includes comprehensive logging in debug mode:

```dart
if (kDebugMode) {
  print('🌐 Magento API: $message');
  print('❌ Error: $error');
  print('✅ Success: $result');
}
```

### Debug Mode Features

- API request/response logging
- Error details
- Performance metrics
- State changes

### Common Issues

1. **Code Generation Errors**
   - Run `flutter packages pub run build_runner clean`
   - Check model annotations
   - Verify import statements

2. **Dependency Issues**
   - Run `flutter pub deps`
   - Check version conflicts
   - Update dependencies

3. **Platform-Specific Issues**
   - Test on multiple platforms
   - Check platform-specific code
   - Verify native dependencies

## 📚 Documentation

### Code Documentation

- Document all public APIs
- Include usage examples
- Document parameters and return values
- Add examples for complex operations

Example:
```dart
/// Authenticates a customer with email and password.
/// 
/// Returns a [Customer] object on successful authentication.
/// Throws [MagentoException] if authentication fails.
/// 
/// Example:
/// ```dart
/// final customer = await authService.authenticate(
///   email: 'user@example.com',
///   password: 'password123',
/// );
/// ```
Future<Customer> authenticate({
  required String email,
  required String password,
}) async {
  // Implementation
}
```

### README Updates

- Keep README.md current
- Include all new features
- Update usage examples
- Maintain changelog

## 🚀 Release Process

### 1. Version Update

- Update version in `pubspec.yaml`
- Update version in `lib/src/flutter_magento_core.dart`
- Update changelog

### 2. Testing

- Run all tests
- Test on multiple platforms
- Verify example app works
- Check documentation

### 3. Release

- Create git tag
- Push to repository
- Publish to pub.dev (if applicable)
- Update release notes

### 4. Post-Release

- Monitor for issues
- Respond to feedback
- Plan next release
- Update roadmap

## 🤝 Contributing

### Pull Request Process

1. Fork the repository
2. Create feature branch
3. Make changes following coding standards
4. Add tests for new functionality
5. Update documentation
6. Submit pull request

### Code Review

- All code must be reviewed
- Address review comments
- Ensure tests pass
- Verify documentation updates

### Issue Reporting

- Use GitHub issues
- Provide detailed descriptions
- Include reproduction steps
- Add relevant logs

## 🔧 Development Tools

### Recommended Extensions

- **VS Code**: Dart, Flutter, Error Lens
- **Android Studio**: Flutter, Dart
- **IntelliJ IDEA**: Flutter, Dart

### Useful Commands

```bash
# Check dependencies
flutter pub deps

# Analyze code
flutter analyze

# Format code
dart format .

# Run tests with coverage
flutter test --coverage

# Generate code
flutter packages pub run build_runner build

# Clean project
flutter clean
flutter pub get
```

### Debugging Tools

- Flutter Inspector
- Dart DevTools
- VS Code Debugger
- Logging and print statements

## 📖 Resources

### Official Documentation

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [Magento Developer Documentation](https://devdocs.magento.com/)

### Community Resources

- [Flutter Community](https://flutter.dev/community)
- [Dart Community](https://dart.dev/community)
- [Magento Community](https://community.magento.com/)

### Learning Resources

- [Flutter Codelabs](https://flutter.dev/docs/codelabs)
- [Dart Tutorials](https://dart.dev/tutorials)
- [Magento Tutorials](https://devdocs.magento.com/guides/v2.4/tutorials/)

## 🆘 Getting Help

### Internal Resources

- Check existing documentation
- Review similar implementations
- Look at test examples
- Check issue tracker

### External Help

- Stack Overflow
- Flutter Discord
- Magento Forums
- GitHub Discussions

### Team Communication

- Use project communication channels
- Ask questions early
- Share progress updates
- Collaborate on solutions

---

**Happy Coding! 🎉**
