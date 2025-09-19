import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_magento_method_channel.dart';

abstract class FlutterMagentoPlatform extends PlatformInterface {
  /// Constructs a FlutterMagentoPlatform.
  FlutterMagentoPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterMagentoPlatform _instance = MethodChannelFlutterMagento();

  /// The default instance of [FlutterMagentoPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterMagento].
  static FlutterMagentoPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterMagentoPlatform] when
  /// they register themselves.
  static set instance(FlutterMagentoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Get platform version.
  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  /// Initialize the Magento plugin with base URL and configuration.
  Future<bool> initialize({
    required String baseUrl,
    Map<String, String>? headers,
    int? connectionTimeout,
    int? receiveTimeout,
  }) {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  /// Authenticate customer with email and password.
  Future<bool> authenticateCustomer({
    required String email,
    required String password,
  }) {
    throw UnimplementedError('authenticateCustomer() has not been implemented.');
  }

  /// Create a new customer account.
  Future<Map<String, dynamic>?> createCustomer({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) {
    throw UnimplementedError('createCustomer() has not been implemented.');
  }

  /// Get current customer information.
  Future<Map<String, dynamic>?> getCurrentCustomer() {
    throw UnimplementedError('getCurrentCustomer() has not been implemented.');
  }

  /// Logout customer.
  Future<void> logout() {
    throw UnimplementedError('logout() has not been implemented.');
  }

  /// Get products with pagination and filters.
  Future<Map<String, dynamic>?> getProducts({
    int page = 1,
    int pageSize = 20,
    String? searchQuery,
    String? categoryId,
    String? sortBy,
    String? sortOrder,
    Map<String, dynamic>? filters,
  }) {
    throw UnimplementedError('getProducts() has not been implemented.');
  }

  /// Get product by SKU.
  Future<Map<String, dynamic>?> getProduct(String sku) {
    throw UnimplementedError('getProduct() has not been implemented.');
  }

  /// Get cart information.
  Future<Map<String, dynamic>?> getCart() {
    throw UnimplementedError('getCart() has not been implemented.');
  }

  /// Add item to cart.
  Future<bool> addToCart(String sku, int quantity, [Map<String, dynamic>? productOption]) {
    throw UnimplementedError('addToCart() has not been implemented.');
  }

  /// Remove item from cart.
  Future<bool> removeFromCart(String itemId) {
    throw UnimplementedError('removeFromCart() has not been implemented.');
  }

  /// Update cart item quantity.
  Future<bool> updateCartItem(String itemId, int quantity) {
    throw UnimplementedError('updateCartItem() has not been implemented.');
  }

  /// Get customer orders.
  Future<List<Map<String, dynamic>>?> getCustomerOrders() {
    throw UnimplementedError('getCustomerOrders() has not been implemented.');
  }

  /// Get order by ID.
  Future<Map<String, dynamic>?> getOrder(String orderId) {
    throw UnimplementedError('getOrder() has not been implemented.');
  }

  /// Get customer wishlist.
  Future<Map<String, dynamic>?> getWishlist() {
    throw UnimplementedError('getWishlist() has not been implemented.');
  }

  /// Add product to wishlist.
  Future<bool> addToWishlist(String sku) {
    throw UnimplementedError('addToWishlist() has not been implemented.');
  }

  /// Remove product from wishlist.
  Future<bool> removeFromWishlist(String itemId) {
    throw UnimplementedError('removeFromWishlist() has not been implemented.');
  }

  /// Check if customer is authenticated.
  bool get isAuthenticated => throw UnimplementedError('isAuthenticated has not been implemented.');

  /// Get current customer token.
  String? get customerToken => throw UnimplementedError('customerToken has not been implemented.');

  /// Get current error message.
  String? get error => throw UnimplementedError('error has not been implemented.');

  /// Clear current error.
  void clearError() => throw UnimplementedError('clearError() has not been implemented.');
}
