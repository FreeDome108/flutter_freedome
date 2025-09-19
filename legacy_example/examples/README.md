# Flutter Magento Examples

This directory contains example applications demonstrating how to use the `flutter_magento` plugin in real-world scenarios.

## Available Examples

### 1. Basic Integration (`basic_integration/`)

A complete Flutter application showcasing the core features of the `flutter_magento` plugin:

- **Authentication**: Login and registration flows
- **Product Catalog**: Product listing with search and filtering
- **State Management**: Provider-based state management
- **Error Handling**: Comprehensive error handling and user feedback
- **Responsive UI**: Material Design 3 with modern UI components

**Key Features:**
- Product grid with search functionality
- Category filtering
- User authentication
- Responsive design
- Error handling and retry mechanisms

**Getting Started:**
```bash
cd basic_integration
flutter pub get
flutter run
```

## Example Structure

Each example follows a consistent structure:

```
example_name/
├── lib/
│   ├── config/           # Application configuration
│   ├── models/           # Data models
│   ├── providers/        # State management
│   ├── screens/          # UI screens
│   ├── widgets/          # Reusable components
│   └── main.dart         # Entry point
├── pubspec.yaml          # Dependencies
├── README.md             # Example-specific documentation
└── assets/               # Images, fonts, etc.
```

## Common Patterns

### 1. Configuration Management

All examples use a centralized configuration approach:

```dart
// lib/config/app_config.dart
class AppConfig {
  static const String magentoBaseUrl = 'https://your-store.com';
  static const int connectionTimeout = 30000;
  // ... other configuration
}
```

### 2. State Management

Examples use the Provider pattern for state management:

```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => MagentoProvider(magento)),
    ChangeNotifierProvider(create: (_) => AuthProvider(magento)),
  ],
  child: MaterialApp(...),
)
```

### 3. Error Handling

Consistent error handling across all examples:

```dart
if (error != null) {
  return ErrorWidget(
    error: error!,
    onRetry: () => retry(),
  );
}
```

### 4. Authentication Flow

Standard authentication wrapper pattern:

```dart
class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.isAuthenticated) {
          return HomeScreen();
        }
        return LoginScreen();
      },
    );
  }
}
```

## Customization

### Adding New Examples

1. **Create Directory**: Create a new folder in the `examples/` directory
2. **Follow Structure**: Use the standard example structure
3. **Update Dependencies**: Ensure `pubspec.yaml` includes necessary dependencies
4. **Documentation**: Create a comprehensive README.md
5. **Testing**: Test the example on multiple platforms

### Modifying Existing Examples

1. **Configuration**: Update `app_config.dart` for your Magento store
2. **API Endpoints**: Modify endpoints if using custom Magento configuration
3. **UI**: Customize colors, themes, and layouts
4. **Features**: Add or remove features based on your needs

## Best Practices

### 1. Configuration

- Use environment variables for sensitive data
- Centralize all configuration in one place
- Provide clear documentation for required settings

### 2. Error Handling

- Always handle network errors gracefully
- Provide user-friendly error messages
- Include retry mechanisms where appropriate

### 3. State Management

- Use appropriate state management patterns
- Minimize unnecessary rebuilds
- Handle loading and error states consistently

### 4. UI/UX

- Follow Material Design guidelines
- Ensure responsive design across screen sizes
- Provide clear feedback for user actions

### 5. Performance

- Implement lazy loading for large datasets
- Use appropriate image caching strategies
- Optimize state updates and rebuilds

## Testing Examples

### 1. Unit Tests

```bash
cd example_name
flutter test
```

### 2. Integration Tests

```bash
flutter drive --target=test_driver/app.dart
```

### 3. Manual Testing

- Test on different screen sizes
- Test on both iOS and Android
- Test with different network conditions

## Troubleshooting

### Common Issues

1. **Build Errors**: Ensure all dependencies are compatible
2. **Runtime Errors**: Check Magento store configuration
3. **UI Issues**: Verify Material Design implementation
4. **Performance**: Monitor state management and rebuilds

### Getting Help

1. Check the main plugin documentation
2. Review Magento REST API documentation
3. Check Flutter documentation for UI components
4. Review Provider documentation for state management

## Contributing

When contributing examples:

1. **Follow Structure**: Use the established example structure
2. **Documentation**: Provide comprehensive README files
3. **Testing**: Ensure examples work on multiple platforms
4. **Code Quality**: Follow Flutter best practices
5. **Examples**: Include realistic use cases

## License

All examples are provided under the same license as the `flutter_magento` plugin.

## Support

For questions about examples:

1. Check the example-specific README files
2. Review the main plugin documentation
3. Check Flutter documentation for UI patterns
4. Review Magento documentation for API usage
