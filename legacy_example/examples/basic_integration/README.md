# Flutter Magento Basic Integration Example

This example demonstrates how to integrate the `flutter_magento` plugin into a Flutter application with basic e-commerce functionality.

## Features

- **Authentication**: Login and registration with Magento store
- **Product Catalog**: Display products in a grid layout with search functionality
- **Categories**: Show product categories as filter chips
- **State Management**: Uses Provider pattern for state management
- **Error Handling**: Comprehensive error handling and user feedback
- **Responsive UI**: Material Design 3 with responsive layout

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- A running Magento store with REST API enabled

### Configuration

1. **Update Magento Store URL**: Edit `lib/config/app_config.dart` and update the `magentoBaseUrl` to point to your Magento store:

```dart
static const String magentoBaseUrl = 'https://your-magento-store.com';
```

2. **Configure API Endpoints**: If your Magento store uses custom API endpoints, update them in the same file.

### Installation

1. **Install Dependencies**: Run the following command in the example directory:

```bash
flutter pub get
```

2. **Run the Example**: Execute the example app:

```bash
flutter run
```

## Project Structure

```
lib/
├── config/
│   └── app_config.dart          # Application configuration
├── models/
│   ├── product.dart             # Product data model
│   ├── customer.dart            # Customer data model
│   └── category.dart            # Category data model
├── providers/
│   ├── magento_provider.dart    # Product and category state management
│   └── auth_provider.dart       # Authentication state management
├── screens/
│   ├── home_screen.dart         # Main product catalog screen
│   └── login_screen.dart        # Authentication screen
├── widgets/
│   └── auth_wrapper.dart        # Authentication state wrapper
└── main.dart                    # Application entry point
```

## Key Components

### Authentication Flow

The app uses an `AuthWrapper` to manage authentication state:

- **Unauthenticated**: Shows `LoginScreen` with login/register options
- **Authenticated**: Shows `HomeScreen` with product catalog
- **Loading**: Shows loading indicator during authentication checks

### State Management

- **MagentoProvider**: Manages product and category data, search functionality
- **AuthProvider**: Handles authentication state, login/logout operations

### Data Models

- **Product**: Represents product information with pricing and discount calculations
- **Customer**: Customer profile information
- **Category**: Product category hierarchy

## Customization

### Adding New Features

1. **New API Endpoints**: Add them to `app_config.dart`
2. **New Models**: Create model classes in the `models/` directory
3. **New Screens**: Add screen widgets in the `screens/` directory
4. **New Providers**: Create state management providers as needed

### UI Customization

- **Theme**: Modify the `ThemeData` in `main.dart`
- **Colors**: Update the color scheme seed color
- **Layout**: Adjust grid parameters in `app_config.dart`

## API Integration

The example demonstrates integration with Magento REST API endpoints:

- **Authentication**: Customer token generation
- **Products**: Product listing and search
- **Categories**: Category hierarchy
- **Cart**: Shopping cart operations (placeholder)
- **Wishlist**: Wishlist management (placeholder)

## Error Handling

The app includes comprehensive error handling:

- **Network Errors**: Connection timeout and network issues
- **API Errors**: Server responses and authentication failures
- **User Feedback**: SnackBar notifications and error displays
- **Retry Mechanisms**: Retry buttons for failed operations

## Performance Considerations

- **Lazy Loading**: Products are loaded on demand
- **Image Caching**: Network images with error handling
- **State Persistence**: Authentication state is maintained
- **Efficient Rebuilds**: Provider-based state management

## Testing

To test the example:

1. **Unit Tests**: Run `flutter test` for unit tests
2. **Integration Tests**: Use `flutter drive` for integration tests
3. **Manual Testing**: Test on different devices and screen sizes

## Troubleshooting

### Common Issues

1. **Connection Failed**: Check your Magento store URL and network connectivity
2. **Authentication Errors**: Verify API credentials and endpoint configuration
3. **Build Errors**: Ensure all dependencies are properly installed

### Debug Mode

Enable debug logging in `app_config.dart`:

```dart
static const bool enableDebugLogging = true;
```

## Next Steps

This basic example can be extended with:

- **Shopping Cart**: Full cart functionality with checkout
- **Product Details**: Detailed product view with options
- **User Profile**: Customer profile management
- **Order History**: Customer order tracking
- **Payment Integration**: Payment gateway integration
- **Push Notifications**: Order updates and promotions

## Support

For issues and questions:

1. Check the main `flutter_magento` plugin documentation
2. Review Magento REST API documentation
3. Check Flutter documentation for UI components
4. Review Provider package documentation for state management

## License

This example is provided under the same license as the `flutter_magento` plugin.





