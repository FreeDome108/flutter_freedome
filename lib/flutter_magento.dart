/// A comprehensive Flutter plugin for Magento e-commerce platform integration.
///
/// This package provides 200+ functions for building modern mobile commerce applications
/// with support for authentication, product management, cart operations, order processing,
/// wishlist functionality, and advanced search capabilities.
///
/// ## Features
///
/// - **Authentication & Customer Management**: JWT token authentication, customer registration, profile management
/// - **Product Catalog**: Advanced product listing, search with autocomplete, category management
/// - **Shopping Cart & Checkout**: Guest and customer cart management, coupon support, payment methods
/// - **Order Management**: Order history, status tracking, cancellation, returns, reorder functionality
/// - **Wishlist & Favorites**: Multiple wishlist support, sharing, analytics
/// - **Advanced Search & Filtering**: Full-text search, attribute-based filtering, price range filtering
/// - **Platform Support**: Android, iOS, Web, Windows, macOS, Linux
///
/// ## Quick Start
///
/// ```dart
/// import 'package:flutter_magento/flutter_magento.dart';
///
/// // Initialize the plugin
/// final magento = FlutterMagento();
/// await magento.initialize(
///   baseUrl: 'https://your-magento-store.com',
///   headers: {'Content-Type': 'application/json'},
/// );
///
/// // Authenticate customer
/// final authResponse = await magento.authenticateCustomer(
///   email: 'customer@example.com',
///   password: 'password123',
/// );
/// ```
library flutter_magento;

// Export core models
export 'src/models/localization_models.dart';
export 'src/models/offline_models.dart';

// Export API classes
export 'src/api/magento_api_client.dart';
export 'src/api/auth_api.dart';
export 'src/api/product_api.dart';

// Export new services
export 'src/services/network_service.dart';
export 'src/services/localization_service.dart';
export 'src/services/offline_service.dart';

// Export providers
export 'src/providers/magento_provider.dart';

// Export widgets
export 'src/widgets/widgets.dart';

// Export main plugin class
export 'src/flutter_magento_plugin.dart';

// Export core
export 'src/flutter_magento_core.dart';
