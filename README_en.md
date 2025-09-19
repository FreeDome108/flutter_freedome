# Native Marketplace

A Flutter-based native marketplace application for tax lien investments.

## Features

### Core Marketplace Features
- 🛍️ **Product Catalog** - Browse tax liens with detailed property information
- 🔍 **Advanced Search & Filtering** - Find specific investment opportunities by location, amount, and risk level
- 🛒 **Shopping Cart** - Add and manage selected tax liens
- ❤️ **Wishlist** - Save interesting investment opportunities for later review
- 📱 **Responsive Design** - Works seamlessly on mobile, tablet, and desktop
- 🌐 **Multi-language Support** - Localized for global users
- 🔐 **User Authentication** - Secure login and registration system
- 📊 **Order Management** - Track your investments and purchase history

### Technical Features
- **State Management** - Riverpod for reactive state management
- **API Integration** - Dio for HTTP requests to Magento backend
- **UI Framework** - Material Design 3 for modern, accessible interface
- **Navigation** - Intuitive navigation with bottom tabs and drawer
- **Offline Support** - Basic offline functionality with local storage

## Installation

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio or VS Code
- Git

### Setup Steps
1. Clone the repository:
```bash
git clone [repository-url]
cd native-marketplace
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the application:
```bash
flutter run
```

## Development

### Project Structure
```
lib/
├── core/           # Core utilities and services
│   ├── config/     # Configuration files
│   ├── constants/  # App constants
│   ├── models/     # Data models
│   ├── providers/  # Riverpod providers
│   ├── services/   # API and business logic services
│   └── theme/      # App theming
├── features/       # Feature modules
│   ├── auth/       # Authentication
│   ├── cart/       # Shopping cart
│   ├── marketplace/# Product catalog
│   ├── orders/     # Order management
│   ├── profile/    # User profile
│   ├── search/     # Search functionality
│   └── wishlist/   # Wishlist management
├── screens/        # App screens
└── widgets/        # Reusable widgets
```

### State Management
- **Riverpod** for reactive state management
- **Dio** for HTTP API calls
- **Material Design 3** for UI components

### API Integration
The app integrates with a Magento backend for:
- Product catalog management
- User authentication
- Order processing
- Payment processing

## Testing

Run the test suite:
```bash
flutter test
```

## Building

### Android
```bash
flutter build apk
```

### iOS
```bash
flutter build ios
```

### Web
```bash
flutter build web
```

## Deployment

### Docker Support
The project includes Docker configuration for web deployment:
```bash
docker-compose up -d
```

### Production Guide
See [PRODUCTION_GUIDE.md](PRODUCTION_GUIDE.md) for detailed deployment instructions.

## Migration

For users migrating from the legacy WebView app, see [MIGRATION_GUIDE.md](MIGRATION_GUIDE.md).

## License

This project is licensed under the NativeMindNONC License - see the [LICENSE](LICENSE) file for details.

## Contributing

Please read our contributing guidelines before submitting pull requests.

## Support

For support and questions, please contact: taxlien.online
