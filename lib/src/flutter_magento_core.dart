import 'package:flutter/foundation.dart';
import 'services/magento_api_service.dart';
import 'services/auth_service.dart';
import 'services/cart_service.dart';
import 'exceptions/magento_exception.dart';

/// Main class for Flutter Magento library
/// Provides access to all Magento functionality
class FlutterMagentoCore {
  static FlutterMagentoCore? _instance;
  
  late final MagentoApiService _apiService;
  late final AuthService _authService;
  late final CartService _cartService;
  
  bool _isInitialized = false;
  String? _baseUrl;
  
  FlutterMagentoCore._();
  
  /// Get singleton instance
  static FlutterMagentoCore get instance {
    _instance ??= FlutterMagentoCore._();
    return _instance!;
  }
  
  /// Get API service
  MagentoApiService get apiService => _apiService;
  
  /// Get authentication service
  AuthService get authService => _authService;
  
  /// Get cart service
  CartService get cartService => _cartService;
  
  /// Check if library is initialized
  bool get isInitialized => _isInitialized;
  
  /// Get base URL
  String? get baseUrl => _baseUrl;
  
  /// Initialize the library
  Future<bool> initialize({
    required String baseUrl,
    Map<String, String>? headers,
    int? connectionTimeout,
    int? receiveTimeout,
    String? adminToken,
  }) async {
    try {
      if (kDebugMode) {
        print('🚀 Initializing Flutter Magento...');
      }
      
      _baseUrl = baseUrl;
      
      // Initialize API service
      _apiService = MagentoApiService();
      final apiInitialized = await _apiService.initialize(
        baseUrl: baseUrl,
        headers: headers,
        connectionTimeout: connectionTimeout,
        receiveTimeout: receiveTimeout,
        adminToken: adminToken,
      );
      
      if (!apiInitialized) {
        throw MagentoException('Failed to initialize API service');
      }
      
      // Initialize other services
      _authService = AuthService(_apiService);
      _cartService = CartService(_apiService);
      
      // Initialize services
      final authInitialized = await _authService.initialize();
      final cartInitialized = await _cartService.initialize();
      
      if (!authInitialized || !cartInitialized) {
        throw MagentoException('Failed to initialize services');
      }
      
      _isInitialized = true;
      
      if (kDebugMode) {
        print('✅ Flutter Magento initialized successfully');
        print('📍 Base URL: $baseUrl');
      }
      
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Failed to initialize Flutter Magento: $e');
      }
      _isInitialized = false;
      return false;
    }
  }
  
  /// Reset library state
  void reset() {
    _isInitialized = false;
    _baseUrl = null;
    
    try {
      _authService.logout();
      _cartService.reset();
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error during reset: $e');
      }
    }
  }
  
  /// Check if user is authenticated
  bool get isAuthenticated => _authService.isAuthenticated;
  
  /// Get current customer
  get currentCustomer => _authService.currentCustomer;
  
  /// Get customer token
  String? get customerToken => _authService.customerToken;
  
  /// Get cart information
  get currentCart => _cartService.currentCart;
  
  /// Get cart items count
  int get cartItemsCount => _cartService.itemsCount;
  
  /// Get cart total
  double get cartTotal => _cartService.cartTotal;
  
  /// Check if cart is empty
  bool get isCartEmpty => _cartService.isCartEmpty;
  
  /// Authenticate customer
  Future<dynamic> authenticate({
    required String email,
    required String password,
  }) async {
    _checkInitialization();
    return await _authService.authenticate(email: email, password: password);
  }
  
  /// Create customer account
  Future<dynamic> createAccount({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    Map<String, dynamic>? additionalData,
  }) async {
    _checkInitialization();
    return await _authService.createAccount(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      additionalData: additionalData,
    );
  }
  
  /// Logout customer
  Future<void> logout() async {
    _checkInitialization();
    await _authService.logout();
    _cartService.reset();
  }
  
  /// Get products
  Future<Map<String, dynamic>> getProducts({
    int page = 1,
    int pageSize = 20,
    String? searchQuery,
    String? categoryId,
    String? sortBy,
    String? sortOrder,
    Map<String, dynamic>? filters,
  }) async {
    _checkInitialization();
    return await _apiService.getProducts(
      page: page,
      pageSize: pageSize,
      searchQuery: searchQuery,
      categoryId: categoryId,
      sortBy: sortBy,
      sortOrder: sortOrder,
      filters: filters,
    );
  }
  
  /// Get product by SKU
  Future<dynamic> getProduct(String sku) async {
    _checkInitialization();
    return await _apiService.getProduct(sku);
  }
  
  /// Search products
  Future<Map<String, dynamic>> searchProducts(
    String query, {
    int page = 1,
    int pageSize = 20,
  }) async {
    _checkInitialization();
    return await _apiService.searchProducts(query, page: page, pageSize: pageSize);
  }
  
  /// Get categories
  Future<List<Map<String, dynamic>>> getCategories() async {
    _checkInitialization();
    return await _apiService.getCategories();
  }
  
  /// Get category by ID
  Future<Map<String, dynamic>> getCategory(int categoryId) async {
    _checkInitialization();
    return await _apiService.getCategory(categoryId);
  }
  
  /// Create cart
  Future<String> createCart() async {
    _checkInitialization();
    return await _cartService.createCart();
  }
  
  /// Get cart
  Future<dynamic> getCart() async {
    _checkInitialization();
    return await _cartService.getCart();
  }
  
  /// Add product to cart
  Future<bool> addToCart({
    required String sku,
    required int quantity,
    Map<String, dynamic>? productOptions,
  }) async {
    _checkInitialization();
    return await _cartService.addToCart(
      sku: sku,
      quantity: quantity,
      productOptions: productOptions,
    );
  }
  
  /// Update cart item quantity
  Future<bool> updateCartItemQuantity({
    required int itemId,
    required int quantity,
  }) async {
    _checkInitialization();
    return await _cartService.updateQuantity(
      itemId: itemId,
      quantity: quantity,
    );
  }
  
  /// Remove item from cart
  Future<bool> removeFromCart(int itemId) async {
    _checkInitialization();
    return await _cartService.removeFromCart(itemId);
  }
  
  /// Clear cart
  Future<bool> clearCart() async {
    _checkInitialization();
    return await _cartService.clearCart();
  }
  
  /// Get customer orders
  Future<List<dynamic>> getCustomerOrders() async {
    _checkInitialization();
    return await _apiService.getCustomerOrders();
  }
  
  /// Get order by ID
  Future<dynamic> getOrder(String orderId) async {
    _checkInitialization();
    return await _apiService.getOrder(orderId);
  }
  
  /// Get wishlist
  Future<Map<String, dynamic>> getWishlist() async {
    _checkInitialization();
    return await _apiService.getWishlist();
  }
  
  /// Add product to wishlist
  Future<bool> addToWishlist(String sku) async {
    _checkInitialization();
    return await _apiService.addToWishlist(sku);
  }
  
  /// Remove product from wishlist
  Future<bool> removeFromWishlist(int itemId) async {
    _checkInitialization();
    return await _apiService.removeFromWishlist(itemId);
  }
  
  /// Estimate shipping
  Future<List<Map<String, dynamic>>> estimateShipping(Map<String, dynamic> address) async {
    _checkInitialization();
    return await _cartService.estimateShipping(address);
  }
  
  /// Get payment methods
  Future<List<Map<String, dynamic>>> getPaymentMethods() async {
    _checkInitialization();
    return await _cartService.getPaymentMethods();
  }
  
  /// Place order
  Future<Map<String, dynamic>> placeOrder(Map<String, dynamic> orderData) async {
    _checkInitialization();
    return await _cartService.placeOrder(orderData);
  }
  
  /// Check if product is in cart
  bool isProductInCart(String sku) {
    _checkInitialization();
    return _cartService.isProductInCart(sku);
  }
  
  /// Get product quantity in cart
  int getProductQuantityInCart(String sku) {
    _checkInitialization();
    return _cartService.getProductQuantity(sku);
  }
  
  /// Apply coupon code
  Future<bool> applyCoupon(String couponCode) async {
    _checkInitialization();
    return await _cartService.applyCoupon(couponCode);
  }
  
  /// Remove coupon code
  Future<bool> removeCoupon() async {
    _checkInitialization();
    return await _cartService.removeCoupon();
  }
  
  /// Check initialization
  void _checkInitialization() {
    if (!_isInitialized) {
      throw MagentoException('Flutter Magento not initialized. Call initialize() first.');
    }
  }
  
  /// Get library version
  String get version => '1.0.0';
  
  /// Get library description
  String get description => 'Flutter plugin for integrating with Magento e-commerce platform';
}
