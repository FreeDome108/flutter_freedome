import '../flutter_magento_platform_interface.dart';
import 'api/magento_api_client.dart';
import 'api/auth_api.dart';
import 'api/product_api.dart';
import 'api/cart_api.dart';
import 'api/order_api.dart';
import 'api/wishlist_api.dart';
import 'api/search_api.dart';
import 'api/checkout_api.dart';
import 'api/customer_api.dart';
import 'models/auth_models.dart';
import 'models/product_models.dart';
import 'models/cart_models.dart';
import 'models/order_models.dart';
import 'models/wishlist_models.dart';
import 'models/search_models.dart';
import 'models/checkout_models.dart';
import 'models/customer_models.dart';

/// A comprehensive Flutter plugin for Magento e-commerce platform integration.
/// 
/// This plugin provides methods to interact with Magento REST API,
/// including authentication, products, cart, orders, and customer operations.
class FlutterMagento {
  late final MagentoApiClient _apiClient;
  late final AuthApi _authApi;
  late final ProductApi _productApi;
  late final CartApi _cartApi;
  late final OrderApi _orderApi;
  late final WishlistApi _wishlistApi;
  late final SearchApi _searchApi;
  late final CheckoutApi _checkoutApi;
  late final CustomerApi _customerApi;
  bool _isInitialized = false;

  /// Get the platform version.
  Future<String?> getPlatformVersion() {
    return FlutterMagentoPlatform.instance.getPlatformVersion();
  }

  /// Initialize the Magento plugin with base URL and configuration.
  Future<bool> initialize({
    required String baseUrl,
    Map<String, String>? headers,
    int? connectionTimeout,
    int? receiveTimeout,
  }) async {
    try {
      _apiClient = MagentoApiClient.instance;
      final success = await _apiClient.initialize(
        baseUrl: baseUrl,
        headers: headers,
        connectionTimeout: connectionTimeout,
        receiveTimeout: receiveTimeout,
      );

      if (success) {
        _authApi = AuthApi(_apiClient);
        _productApi = ProductApi(_apiClient);
        _cartApi = CartApi(_apiClient);
        _orderApi = OrderApi(_apiClient);
        _wishlistApi = WishlistApi(_apiClient);
        _searchApi = SearchApi(_apiClient);
        _checkoutApi = CheckoutApi(_apiClient);
        _customerApi = CustomerApi(_apiClient);
        _isInitialized = true;
        return true;
      }
      return false;
    } catch (e) {
      print('Failed to initialize FlutterMagento: $e');
      return false;
    }
  }

  /// Check if the plugin is initialized
  bool get isInitialized => _isInitialized;

  /// Get the base URL
  String? get baseUrl => _apiClient.baseUrl;

  /// Get the API client instance
  MagentoApiClient get apiClient => _apiClient;

  /// Get the auth API instance
  AuthApi get auth => _authApi;

  /// Get the product API instance
  ProductApi get products => _productApi;

  /// Get the cart API instance
  CartApi get cart => _cartApi;

  /// Get the order API instance
  OrderApi get orders => _orderApi;

  /// Get the wishlist API instance
  WishlistApi get wishlist => _wishlistApi;

  /// Get the search API instance
  SearchApi get searchApi => _searchApi;

  /// Get the checkout API instance
  CheckoutApi get checkout => _checkoutApi;

  /// Get the customer API instance
  CustomerApi get customer => _customerApi;

  // ==================== AUTHENTICATION ====================

  /// Authenticate customer with email and password
  Future<AuthResponse> authenticateCustomer({
    required String email,
    required String password,
  }) async {
    _checkInitialization();
    return await _authApi.login(email: email, password: password);
  }

  /// Create a new customer account
  Future<Customer> createCustomer({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? middleName,
    String? prefix,
    String? suffix,
    String? dateOfBirth,
    String? taxVat,
    String? gender,
    bool? isSubscribed,
    List<Address>? addresses,
  }) async {
    _checkInitialization();
    
    final request = CustomerCreateRequest(
      email: email,
      password: password,
      firstname: firstName,
      lastname: lastName,
      middlename: middleName,
      prefix: prefix,
      suffix: suffix,
      dob: dateOfBirth,
      taxvat: taxVat,
      gender: gender,
      isSubscribed: isSubscribed,
      addresses: addresses,
    );
    
    return await _authApi.register(request: request);
  }

  /// Get current customer information
  Future<Customer> getCurrentCustomer() async {
    _checkInitialization();
    return await _authApi.getCurrentCustomer();
  }

  /// Update customer information
  Future<Customer> updateCustomer({
    String? firstName,
    String? lastName,
    String? middleName,
    String? prefix,
    String? suffix,
    String? dateOfBirth,
    String? taxVat,
    String? gender,
    bool? isSubscribed,
    List<Address>? addresses,
  }) async {
    _checkInitialization();
    
    final request = CustomerUpdateRequest(
      firstname: firstName,
      lastname: lastName,
      middlename: middleName,
      prefix: prefix,
      suffix: suffix,
      dob: dateOfBirth,
      taxvat: taxVat,
      gender: gender,
      isSubscribed: isSubscribed,
      addresses: addresses,
    );
    
    return await _authApi.updateCustomer(request: request);
  }

  /// Change customer password
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    _checkInitialization();
    
    final request = PasswordChangeRequest(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    
    return await _authApi.changePassword(request: request);
  }

  /// Reset customer password
  Future<bool> resetPassword({
    required String email,
  }) async {
    _checkInitialization();
    return await _authApi.resetPassword(email: email);
  }

  /// Social login
  Future<AuthResponse> socialLogin({
    required String provider,
    required String token,
    String? email,
    String? firstName,
    String? lastName,
  }) async {
    _checkInitialization();
    
    return await _authApi.socialLogin(
      provider: provider,
      token: token,
      email: email,
      firstname: firstName,
      lastname: lastName,
    );
  }

  /// Logout customer
  Future<void> logout() async {
    _checkInitialization();
    await _authApi.logout();
  }

  /// Check if customer is authenticated
  bool get isAuthenticated => _authApi.isAuthenticated;

  /// Get current customer ID
  int? get currentCustomerId => _authApi.currentCustomerId;

  // ==================== PRODUCTS ====================

  /// Get products with pagination and filters
  Future<ProductListResponse> getProducts({
    int page = 1,
    int pageSize = 20,
    String? searchQuery,
    String? categoryId,
    String? sortBy,
    String? sortOrder,
    Map<String, dynamic>? filters,
    double? minPrice,
    double? maxPrice,
    List<String>? attributes,
    bool? inStock,
    String? brand,
    List<String>? tags,
  }) async {
    _checkInitialization();
    
    return await _productApi.getProducts(
      page: page,
      pageSize: pageSize,
      searchQuery: searchQuery,
      categoryId: categoryId,
      sortBy: sortBy,
      sortOrder: sortOrder,
      filters: filters,
      minPrice: minPrice,
      maxPrice: maxPrice,
      attributes: attributes,
      inStock: inStock,
      brand: brand,
      tags: tags,
    );
  }

  /// Get product by SKU
  Future<Product> getProduct(String sku) async {
    _checkInitialization();
    
    return await _productApi.getProduct(sku);
  }

  /// Get categories
  Future<CategoryTree> getCategories() async {
    _checkInitialization();
    
    return await _productApi.getCategories();
  }

  /// Search products
  Future<ProductListResponse> searchProducts(
    String query, {
    int page = 1,
    int pageSize = 20,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    _checkInitialization();
    
    return await _productApi.searchProducts(
      query,
      page: page,
      pageSize: pageSize,
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  /// Get products by category
  Future<ProductListResponse> getProductsByCategory(
    int categoryId, {
    int page = 1,
    int pageSize = 20,
    String? sortBy,
    String? sortOrder,
    Map<String, dynamic>? filters,
  }) async {
    _checkInitialization();
    
    return await _productApi.getProductsByCategory(
      categoryId,
      page: page,
      pageSize: pageSize,
      sortBy: sortBy,
      sortOrder: sortOrder,
      filters: filters,
    );
  }

  /// Get product variants
  Future<List<ProductOption>> getProductVariants(String sku) async {
    _checkInitialization();
    
    return await _productApi.getProductVariants(sku);
  }

  /// Get related products
  Future<List<Product>> getRelatedProducts(String sku) async {
    _checkInitialization();
    
    return await _productApi.getRelatedProducts(sku);
  }

  /// Get cross-sell products
  Future<List<Product>> getCrossSellProducts(String sku) async {
    _checkInitialization();
    
    return await _productApi.getCrossSellProducts(sku);
  }

  /// Get up-sell products
  Future<List<Product>> getUpSellProducts(String sku) async {
    _checkInitialization();
    
    return await _productApi.getUpSellProducts(sku);
  }

  /// Get product reviews
  Future<List<Review>> getProductReviews(
    String sku, {
    int page = 1,
    int pageSize = 10,
  }) async {
    _checkInitialization();
    
    return await _productApi.getProductReviews(
      sku,
      page: page,
      pageSize: pageSize,
    );
  }

  // ==================== CART ====================

  /// Create a new cart
  Future<Cart> createCart() async {
    _checkInitialization();
    return await _cartApi.createCart();
  }

  /// Get cart information
  Future<Cart> getCart(String cartId) async {
    _checkInitialization();
    return await _cartApi.getCart(cartId);
  }

  /// Get customer cart
  Future<Cart> getCustomerCart() async {
    _checkInitialization();
    return await _cartApi.getCustomerCart();
  }

  /// Add item to cart
  Future<Cart> addToCart({
    required String cartId,
    required String sku,
    required int quantity,
    Map<String, dynamic>? productOptions,
  }) async {
    _checkInitialization();
    
    return await _cartApi.addToCart(
      cartId: cartId,
      sku: sku,
      quantity: quantity,
      productOptions: productOptions,
    );
  }

  /// Add item to customer cart
  Future<Cart> addToCustomerCart({
    required String sku,
    required int quantity,
    Map<String, dynamic>? productOptions,
  }) async {
    _checkInitialization();
    
    return await _cartApi.addToCustomerCart(
      sku: sku,
      quantity: quantity,
      productOptions: productOptions,
    );
  }

  /// Remove item from cart
  Future<Cart> removeFromCart({
    required String cartId,
    required int itemId,
  }) async {
    _checkInitialization();
    
    return await _cartApi.removeFromCart(
      cartId: cartId,
      itemId: itemId,
    );
  }

  /// Remove item from customer cart
  Future<Cart> removeFromCustomerCart(int itemId) async {
    _checkInitialization();
    
    return await _cartApi.removeFromCustomerCart(itemId);
  }

  /// Update cart item quantity
  Future<Cart> updateCartItemQuantity({
    required String cartId,
    required int itemId,
    required int quantity,
  }) async {
    _checkInitialization();
    
    return await _cartApi.updateCartItemQuantity(
      cartId: cartId,
      itemId: itemId,
      quantity: quantity,
    );
  }

  /// Update customer cart item quantity
  Future<Cart> updateCustomerCartItemQuantity({
    required int itemId,
    required int quantity,
  }) async {
    _checkInitialization();
    
    return await _cartApi.updateCustomerCartItemQuantity(
      itemId: itemId,
      quantity: quantity,
    );
  }

  /// Apply coupon to cart
  Future<Cart> applyCoupon({
    required String cartId,
    required String couponCode,
  }) async {
    _checkInitialization();
    
    return await _cartApi.applyCoupon(
      cartId: cartId,
      couponCode: couponCode,
    );
  }

  /// Apply coupon to customer cart
  Future<Cart> applyCouponToCustomerCart(String couponCode) async {
    _checkInitialization();
    
    return await _cartApi.applyCouponToCustomerCart(couponCode);
  }

  /// Remove coupon from cart
  Future<Cart> removeCoupon(String cartId) async {
    _checkInitialization();
    
    return await _cartApi.removeCoupon(cartId);
  }

  /// Remove coupon from customer cart
  Future<Cart> removeCouponFromCustomerCart() async {
    _checkInitialization();
    
    return await _cartApi.removeCouponFromCustomerCart();
  }

  /// Get cart totals
  Future<CartTotals> getCartTotals(String cartId) async {
    _checkInitialization();
    
    return await _cartApi.getCartTotals(cartId);
  }

  /// Get customer cart totals
  Future<CartTotals> getCustomerCartTotals() async {
    _checkInitialization();
    
    return await _cartApi.getCustomerCartTotals();
  }

  /// Estimate shipping for cart
  Future<List<ShippingMethod>> estimateShipping({
    required String cartId,
    required Address address,
  }) async {
    _checkInitialization();
    
    return await _cartApi.estimateShipping(
      cartId: cartId,
      address: address,
    );
  }

  /// Estimate shipping for customer cart
  Future<List<ShippingMethod>> estimateCustomerCartShipping(Address address) async {
    _checkInitialization();
    
    return await _cartApi.estimateCustomerCartShipping(address);
  }

  // ==================== ORDERS ====================

  /// Get customer orders
  Future<OrderListResponse> getCustomerOrders({
    int page = 1,
    int pageSize = 20,
    Map<String, dynamic>? filters,
  }) async {
    _checkInitialization();
    
    return await _orderApi.getCustomerOrders(
      page: page,
      pageSize: pageSize,
      filters: filters,
    );
  }

  /// Get order by ID
  Future<Order> getOrder(String orderId) async {
    _checkInitialization();
    
    return await _orderApi.getOrder(orderId);
  }

  /// Get order by increment ID
  Future<Order> getOrderByIncrementId(String incrementId) async {
    _checkInitialization();
    
    return await _orderApi.getOrderByIncrementId(incrementId);
  }

  /// Get order items
  Future<List<OrderItem>> getOrderItems(String orderId) async {
    _checkInitialization();
    
    return await _orderApi.getOrderItems(orderId);
  }

  /// Get order totals
  Future<OrderTotals> getOrderTotals(String orderId) async {
    _checkInitialization();
    
    return await _orderApi.getOrderTotals(orderId);
  }

  /// Get order status
  Future<String> getOrderStatus(String orderId) async {
    _checkInitialization();
    
    return await _orderApi.getOrderStatus(orderId);
  }

  /// Get order comments
  Future<List<OrderComment>> getOrderComments(String orderId) async {
    _checkInitialization();
    
    return await _orderApi.getOrderComments(orderId);
  }

  /// Get order history
  Future<List<OrderHistory>> getOrderHistory(String orderId) async {
    _checkInitialization();
    
    return await _orderApi.getOrderHistory(orderId);
  }

  /// Reorder
  Future<Cart> reorder(String orderId) async {
    _checkInitialization();
    
    return await _orderApi.reorder(orderId);
  }

  /// Cancel order
  Future<bool> cancelOrder(String orderId, {String? reason}) async {
    _checkInitialization();
    
    return await _orderApi.cancelOrder(orderId, reason: reason);
  }

  /// Hold order
  Future<bool> holdOrder(String orderId) async {
    _checkInitialization();
    
    return await _orderApi.holdOrder(orderId);
  }

  /// Unhold order
  Future<bool> unholdOrder(String orderId) async {
    _checkInitialization();
    
    return await _orderApi.unholdOrder(orderId);
  }

  // ==================== WISHLIST ====================

  /// Get customer wishlist
  Future<Wishlist> getWishlist() async {
    _checkInitialization();
    
    return await _wishlistApi.getWishlist();
  }

  /// Get all wishlists
  Future<List<Wishlist>> getWishlists() async {
    _checkInitialization();
    
    return await _wishlistApi.getWishlists();
  }

  /// Create wishlist
  Future<Wishlist> createWishlist(String name) async {
    _checkInitialization();
    
    return await _wishlistApi.createWishlist(name);
  }

  /// Add product to wishlist
  Future<WishlistItem> addToWishlist({
    required String wishlistId,
    required String productId,
    List<Map<String, dynamic>>? options,
  }) async {
    _checkInitialization();
    
    return await _wishlistApi.addToWishlist(
      wishlistId: wishlistId,
      productId: productId,
      options: options,
    );
  }

  /// Add product to default wishlist
  Future<WishlistItem> addToDefaultWishlist({
    required String productId,
    List<Map<String, dynamic>>? options,
  }) async {
    _checkInitialization();
    
    return await _wishlistApi.addToDefaultWishlist(
      productId: productId,
      options: options,
    );
  }

  /// Remove product from wishlist
  Future<bool> removeFromWishlist({
    required String wishlistId,
    required int itemId,
  }) async {
    _checkInitialization();
    
    return await _wishlistApi.removeFromWishlist(
      wishlistId: wishlistId,
      itemId: itemId,
    );
  }

  /// Remove product from default wishlist
  Future<bool> removeFromDefaultWishlist(int itemId) async {
    _checkInitialization();
    
    return await _wishlistApi.removeFromDefaultWishlist(itemId);
  }

  /// Share wishlist
  Future<bool> shareWishlist({
    required String wishlistId,
    required String email,
    String? message,
  }) async {
    _checkInitialization();
    
    return await _wishlistApi.shareWishlist(
      wishlistId: wishlistId,
      email: email,
      message: message,
    );
  }

  /// Share default wishlist
  Future<bool> shareDefaultWishlist({
    required String email,
    String? message,
  }) async {
    _checkInitialization();
    
    return await _wishlistApi.shareDefaultWishlist(
      email: email,
      message: message,
    );
  }

  /// Add all wishlist items to cart
  Future<bool> addAllWishlistToCart(String wishlistId) async {
    _checkInitialization();
    
    return await _wishlistApi.addAllToCart(wishlistId);
  }

  /// Add all default wishlist items to cart
  Future<bool> addAllDefaultWishlistToCart() async {
    _checkInitialization();
    
    return await _wishlistApi.addAllDefaultWishlistToCart();
  }

  // ==================== SEARCH ====================

  /// Advanced search
  Future<SearchResponse> search({
    required String query,
    Map<String, dynamic>? filters,
    int page = 1,
    int pageSize = 20,
    String? sortBy,
    String? sortOrder,
  }) async {
    _checkInitialization();
    
    return await _searchApi.search(
      query: query,
      filters: filters,
      page: page,
      pageSize: pageSize,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  /// Search by category
  Future<SearchResponse> searchByCategory({
    required String categoryId,
    required String query,
    Map<String, dynamic>? filters,
    int page = 1,
    int pageSize = 20,
    String? sortBy,
    String? sortOrder,
  }) async {
    _checkInitialization();
    
    return await _searchApi.searchByCategory(
      categoryId: categoryId,
      query: query,
      filters: filters,
      page: page,
      pageSize: pageSize,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  /// Search by attribute
  Future<SearchResponse> searchByAttribute({
    required String attribute,
    required String value,
    Map<String, dynamic>? additionalFilters,
    int page = 1,
    int pageSize = 20,
    String? sortBy,
    String? sortOrder,
  }) async {
    _checkInitialization();
    
    return await _searchApi.searchByAttribute(
      attribute: attribute,
      value: value,
      additionalFilters: additionalFilters,
      page: page,
      pageSize: pageSize,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  /// Get search suggestions
  Future<List<SearchSuggestion>> getSearchSuggestions(String query) async {
    _checkInitialization();
    
    return await _searchApi.getSearchSuggestions(query);
  }

  /// Get popular searches
  Future<List<String>> getPopularSearches() async {
    _checkInitialization();
    
    return await _searchApi.getPopularSearches();
  }

  /// Get search history
  Future<List<String>> getSearchHistory() async {
    _checkInitialization();
    
    return await _searchApi.getSearchHistory();
  }

  /// Save search query
  Future<bool> saveSearchQuery(String query) async {
    _checkInitialization();
    
    return await _searchApi.saveSearchQuery(query);
  }

  /// Get filterable attributes
  Future<List<FilterableAttribute>> getFilterableAttributes() async {
    _checkInitialization();
    
    return await _searchApi.getFilterableAttributes();
  }

  /// Get attribute options
  Future<List<AttributeOption>> getAttributeOptions(String attributeCode) async {
    _checkInitialization();
    
    return await _searchApi.getAttributeOptions(attributeCode);
  }

  /// Apply attribute filter
  Future<SearchResponse> applyAttributeFilter({
    required String attributeCode,
    required List<String> values,
    int page = 1,
    int pageSize = 20,
  }) async {
    _checkInitialization();
    
    return await _searchApi.applyAttributeFilter(
      attributeCode: attributeCode,
      values: values,
      page: page,
      pageSize: pageSize,
    );
  }

  /// Get price range
  Future<PriceRange> getPriceRange() async {
    _checkInitialization();
    
    return await _searchApi.getPriceRange();
  }

  /// Apply price filter
  Future<SearchResponse> applyPriceFilter({
    required double minPrice,
    required double maxPrice,
    int page = 1,
    int pageSize = 20,
  }) async {
    _checkInitialization();
    
    return await _searchApi.applyPriceFilter(
      minPrice: minPrice,
      maxPrice: maxPrice,
      page: page,
      pageSize: pageSize,
    );
  }

  /// Get availability filters
  Future<List<AvailabilityFilter>> getAvailabilityFilters() async {
    _checkInitialization();
    
    return await _searchApi.getAvailabilityFilters();
  }

  /// Apply availability filter
  Future<SearchResponse> applyAvailabilityFilter({
    required String availability,
    int page = 1,
    int pageSize = 20,
  }) async {
    _checkInitialization();
    
    return await _searchApi.applyAvailabilityFilter(
      availability: availability,
      page: page,
      pageSize: pageSize,
    );
  }

  /// Combine multiple filters
  Future<SearchResponse> combineFilters({
    required List<Map<String, dynamic>> filters,
    int page = 1,
    int pageSize = 20,
  }) async {
    _checkInitialization();
    
    return await _searchApi.combineFilters(
      filters: filters,
      page: page,
      pageSize: pageSize,
    );
  }

  // ==================== CHECKOUT ====================

  /// Create checkout session
  Future<CheckoutSession> createCheckoutSession({
    required String cartId,
    String? email,
    Map<String, dynamic>? shippingAddress,
    Map<String, dynamic>? billingAddress,
    String? shippingMethod,
    String? paymentMethod,
  }) async {
    _checkInitialization();
    
    return await _checkoutApi.createCheckoutSession(
      cartId: cartId,
      email: email,
      shippingAddress: shippingAddress,
      billingAddress: billingAddress,
      shippingMethod: shippingMethod,
      paymentMethod: paymentMethod,
    );
  }

  /// Get checkout session
  Future<CheckoutSession> getCheckoutSession(String sessionId) async {
    _checkInitialization();
    
    return await _checkoutApi.getCheckoutSession(sessionId);
  }

  /// Update checkout session
  Future<CheckoutSession> updateCheckoutSession({
    required String sessionId,
    Map<String, dynamic>? shippingAddress,
    Map<String, dynamic>? billingAddress,
    String? shippingMethod,
    String? paymentMethod,
    Map<String, dynamic>? additionalData,
  }) async {
    _checkInitialization();
    
    return await _checkoutApi.updateCheckoutSession(
      sessionId: sessionId,
      shippingAddress: shippingAddress,
      billingAddress: billingAddress,
      shippingMethod: shippingMethod,
      paymentMethod: paymentMethod,
      additionalData: additionalData,
    );
  }

  /// Get available shipping methods
  Future<List<ShippingMethod>> getAvailableShippingMethods({
    required String cartId,
    Map<String, dynamic>? address,
  }) async {
    _checkInitialization();
    
    return await _checkoutApi.getShippingMethods(
      cartId: cartId,
      address: address,
    );
  }

  /// Get available payment methods
  Future<List<PaymentMethod>> getAvailablePaymentMethods({
    required String cartId,
    Map<String, dynamic>? address,
  }) async {
    _checkInitialization();
    
    return await _checkoutApi.getPaymentMethods(
      cartId: cartId,
      address: address,
    );
  }

  /// Place order
  Future<Order> placeOrder({
    required String cartId,
    Map<String, dynamic>? paymentData,
    Map<String, dynamic>? additionalData,
  }) async {
    _checkInitialization();
    
    return await _checkoutApi.placeOrder(
      cartId: cartId,
      paymentData: paymentData,
      additionalData: additionalData,
    );
  }

  /// Validate checkout
  Future<CheckoutValidationResult> validateCheckout({
    required String cartId,
    Map<String, dynamic>? shippingAddress,
    Map<String, dynamic>? billingAddress,
    String? shippingMethod,
    String? paymentMethod,
  }) async {
    _checkInitialization();
    
    return await _checkoutApi.validateCheckout(
      cartId: cartId,
      shippingAddress: shippingAddress,
      billingAddress: billingAddress,
      shippingMethod: shippingMethod,
      paymentMethod: paymentMethod,
    );
  }

  /// Get checkout totals
  Future<CheckoutTotals> getCheckoutTotals({
    required String cartId,
    Map<String, dynamic>? shippingAddress,
    String? shippingMethod,
    String? paymentMethod,
  }) async {
    _checkInitialization();
    
    return await _checkoutApi.getCheckoutTotals(
      cartId: cartId,
      shippingAddress: shippingAddress,
      shippingMethod: shippingMethod,
      paymentMethod: paymentMethod,
    );
  }

  // ==================== CUSTOMER MANAGEMENT ====================

  /// Get customer profile
  Future<Customer> getCustomerProfile() async {
    _checkInitialization();
    
    return await _customerApi.getCustomerProfile();
  }

  /// Update customer profile
  Future<Customer> updateCustomerProfile({
    String? firstName,
    String? lastName,
    String? middleName,
    String? prefix,
    String? suffix,
    String? dateOfBirth,
    String? taxVat,
    String? gender,
    bool? isSubscribed,
  }) async {
    _checkInitialization();
    
    return await _customerApi.updateCustomerProfile(
      firstName: firstName,
      lastName: lastName,
      middleName: middleName,
      prefix: prefix,
      suffix: suffix,
      dateOfBirth: dateOfBirth,
      taxVat: taxVat,
      gender: gender,
      isSubscribed: isSubscribed,
    );
  }

  /// Get customer addresses
  Future<List<CustomerAddress>> getCustomerAddresses() async {
    _checkInitialization();
    
    return await _customerApi.getCustomerAddresses();
  }

  /// Add customer address
  Future<CustomerAddress> addCustomerAddress({
    required String firstName,
    required String lastName,
    required List<String> street,
    required String city,
    required String region,
    required String postcode,
    required String countryId,
    required String telephone,
    String? middleName,
    String? prefix,
    String? suffix,
    String? company,
    String? regionId,
    String? regionCode,
    String? fax,
    bool? isDefaultShipping,
    bool? isDefaultBilling,
    Map<String, dynamic>? customAttributes,
  }) async {
    _checkInitialization();
    
    return await _customerApi.addCustomerAddress(
      firstName: firstName,
      lastName: lastName,
      street: street,
      city: city,
      region: region,
      postcode: postcode,
      countryId: countryId,
      telephone: telephone,
      middleName: middleName,
      prefix: prefix,
      suffix: suffix,
      company: company,
      regionId: regionId,
      regionCode: regionCode,
      fax: fax,
      isDefaultShipping: isDefaultShipping,
      isDefaultBilling: isDefaultBilling,
      customAttributes: customAttributes,
    );
  }

  /// Update customer address
  Future<CustomerAddress> updateCustomerAddress({
    required int addressId,
    String? firstName,
    String? lastName,
    List<String>? street,
    String? city,
    String? region,
    String? postcode,
    String? countryId,
    String? telephone,
    String? middleName,
    String? prefix,
    String? suffix,
    String? company,
    String? regionId,
    String? regionCode,
    String? fax,
    bool? isDefaultShipping,
    bool? isDefaultBilling,
    Map<String, dynamic>? customAttributes,
  }) async {
    _checkInitialization();
    
    return await _customerApi.updateCustomerAddress(
      addressId: addressId,
      firstName: firstName,
      lastName: lastName,
      street: street,
      city: city,
      region: region,
      postcode: postcode,
      countryId: countryId,
      telephone: telephone,
      middleName: middleName,
      prefix: prefix,
      suffix: suffix,
      company: company,
      regionId: regionId,
      regionCode: regionCode,
      fax: fax,
      isDefaultShipping: isDefaultShipping,
      isDefaultBilling: isDefaultBilling,
      customAttributes: customAttributes,
    );
  }

  /// Delete customer address
  Future<bool> deleteCustomerAddress(int addressId) async {
    _checkInitialization();
    
    return await _customerApi.deleteCustomerAddress(addressId);
  }

  /// Get customer groups
  Future<List<CustomerGroup>> getCustomerGroups() async {
    _checkInitialization();
    
    return await _customerApi.getCustomerGroups();
  }

  /// Get customer attributes
  Future<List<CustomerAttribute>> getCustomerAttributes() async {
    _checkInitialization();
    
    return await _customerApi.getCustomerAttributes();
  }

  /// Update customer attribute value
  Future<bool> updateCustomerAttributeValue({
    required String attributeCode,
    required dynamic value,
  }) async {
    _checkInitialization();
    
    return await _customerApi.updateCustomerAttributeValue(
      attributeCode: attributeCode,
      value: value,
    );
  }

  /// Get customer preferences
  Future<CustomerPreferences> getCustomerPreferences() async {
    _checkInitialization();
    
    return await _customerApi.getCustomerPreferences();
  }

  /// Update customer preferences
  Future<CustomerPreferences> updateCustomerPreferences({
    String? language,
    String? currency,
    String? timezone,
    bool? newsletterSubscription,
    Map<String, dynamic>? additionalPreferences,
  }) async {
    _checkInitialization();
    
    return await _customerApi.updateCustomerPreferences(
      language: language,
      currency: currency,
      timezone: timezone,
      newsletterSubscription: newsletterSubscription,
      additionalPreferences: additionalPreferences,
    );
  }

  /// Get customer activity
  Future<List<CustomerActivity>> getCustomerActivity({
    int page = 1,
    int pageSize = 20,
    String? activityType,
  }) async {
    _checkInitialization();
    
    return await _customerApi.getCustomerActivity(
      page: page,
      pageSize: pageSize,
      activityType: activityType,
    );
  }

  /// Get customer statistics
  Future<CustomerStatistics> getCustomerStatistics() async {
    _checkInitialization();
    
    return await _customerApi.getCustomerStatistics();
  }

  // ==================== UTILITY METHODS ====================

  /// Check if the plugin is initialized
  void _checkInitialization() {
    if (!_isInitialized) {
      throw StateError('FlutterMagento is not initialized. Call initialize() first.');
    }
  }

  /// Dispose the plugin and clean up resources
  void dispose() {
    _apiClient.dispose();
    _isInitialized = false;
  }

  /// Get plugin version
  String get version => '2.0.0';

  /// Get plugin description
  String get description => 'A comprehensive Flutter plugin for Magento e-commerce platform integration';
}
