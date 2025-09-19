import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../models/customer.dart';
import '../models/product.dart';
import '../models/cart.dart';
import '../models/order.dart';
import '../exceptions/magento_exception.dart';

/// Service for interacting with Magento REST API
class MagentoApiService {
  late final Dio _dio;
  String? _baseUrl;
  String? _customerToken;
  String? _adminToken;
  
  // Configuration
  static const int _defaultConnectionTimeout = 30000;
  static const int _defaultReceiveTimeout = 30000;
  static const String _apiVersion = 'V1';
  
  /// Initialize the API service
  Future<bool> initialize({
    required String baseUrl,
    Map<String, String>? headers,
    int? connectionTimeout,
    int? receiveTimeout,
    String? adminToken,
  }) async {
    try {
      _baseUrl = baseUrl.endsWith('/') ? baseUrl : '$baseUrl/';
      _adminToken = adminToken;
      
      _dio = Dio(BaseOptions(
        baseUrl: '${_baseUrl}rest/$_apiVersion/',
        connectTimeout: Duration(milliseconds: connectionTimeout ?? _defaultConnectionTimeout),
        receiveTimeout: Duration(milliseconds: receiveTimeout ?? _defaultReceiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          ...?headers,
        },
      ));
      
      // Add interceptors for logging and error handling
      _dio.interceptors.add(LogInterceptor(
        requestBody: kDebugMode,
        responseBody: kDebugMode,
        logPrint: (obj) => kDebugMode ? print('🌐 Magento API: $obj') : null,
      ));
      
      _dio.interceptors.add(InterceptorsWrapper(
        onError: (error, handler) {
          if (kDebugMode) {
            print('❌ Magento API Error: ${error.message}');
          }
          handler.next(error);
        },
      ));
      
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Failed to initialize Magento API service: $e');
      }
      return false;
    }
  }
  
  /// Set customer authentication token
  void setCustomerToken(String token) {
    _customerToken = token;
    _updateAuthHeaders();
  }
  
  /// Clear customer authentication token
  void clearCustomerToken() {
    _customerToken = null;
    _updateAuthHeaders();
  }
  
  /// Update authentication headers
  void _updateAuthHeaders() {
    if (_customerToken != null) {
      _dio.options.headers['Authorization'] = 'Bearer $_customerToken';
    } else if (_adminToken != null) {
      _dio.options.headers['Authorization'] = 'Bearer $_adminToken';
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }
  
  /// Make authenticated request
  Future<Response<T>> _authenticatedRequest<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.request<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      throw MagentoException.fromDioException(e);
    } catch (e) {
      throw MagentoException('Unexpected error: $e');
    }
  }
  
  /// Customer Authentication
  Future<Map<String, dynamic>> authenticateCustomer({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post('integration/customer/token', data: {
      'username': email,
      'password': password,
    });
    
    if (response.data is String) {
      final token = response.data as String;
      setCustomerToken(token);
      return {'token': token};
    }
    
    throw MagentoException('Invalid authentication response');
  }
  
  /// Create customer account
  Future<Customer> createCustomer({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    Map<String, dynamic>? additionalData,
  }) async {
    final data = {
      'customer': {
        'email': email,
        'firstname': firstName,
        'lastname': lastName,
        'password': password,
        ...?additionalData,
      },
    };
    
    final response = await _dio.post('customers', data: data);
    return Customer.fromJson(response.data);
  }
  
  /// Get current customer information
  Future<Customer> getCurrentCustomer() async {
    final response = await _authenticatedRequest<Map<String, dynamic>>('customers/me');
    return Customer.fromJson(response.data);
  }
  
  /// Update customer information
  Future<Customer> updateCustomer(Map<String, dynamic> customerData) async {
    final response = await _authenticatedRequest<Map<String, dynamic>>(
      'customers/me',
      data: {'customer': customerData},
    );
    return Customer.fromJson(response.data);
  }
  
  /// Get customer addresses
  Future<List<Address>> getCustomerAddresses() async {
    final response = await _authenticatedRequest<List<dynamic>>('customers/me/addresses');
    return response.data.map((json) => Address.fromJson(json)).toList();
  }
  
  /// Products
  Future<Map<String, dynamic>> getProducts({
    int page = 1,
    int pageSize = 20,
    String? searchQuery,
    String? categoryId,
    String? sortBy,
    String? sortOrder,
    Map<String, dynamic>? filters,
  }) async {
    final queryParams = <String, dynamic>{
      'searchCriteria[currentPage]': page,
      'searchCriteria[pageSize]': pageSize,
    };
    
    if (searchQuery != null) {
      queryParams['searchCriteria[filterGroups][0][filters][0][field]'] = 'name';
      queryParams['searchCriteria[filterGroups][0][filters][0][value]'] = '%$searchQuery%';
      queryParams['searchCriteria[filterGroups][0][filters][0][conditionType]'] = 'like';
    }
    
    if (categoryId != null) {
      queryParams['searchCriteria[filterGroups][1][filters][0][field]'] = 'category_id';
      queryParams['searchCriteria[filterGroups][1][filters][0][value]'] = categoryId;
      queryParams['searchCriteria[filterGroups][1][filters][0][conditionType]'] = 'eq';
    }
    
    if (sortBy != null) {
      queryParams['searchCriteria[sortOrders][0][field]'] = sortBy;
      queryParams['searchCriteria[sortOrders][0][direction]'] = sortOrder ?? 'ASC';
    }
    
    final response = await _dio.get<Map<String, dynamic>>('products', queryParameters: queryParams);
    return response.data;
  }
  
  /// Get product by SKU
  Future<Product> getProduct(String sku) async {
    final response = await _dio.get<Map<String, dynamic>>('products/$sku');
    return Product.fromJson(response.data);
  }
  
  /// Cart operations
  Future<String> createCart() async {
    final response = await _authenticatedRequest<Map<String, dynamic>>('guest-carts');
    return response.data['quote_id'];
  }
  
  Future<Cart> getCart(String cartId) async {
    final response = await _authenticatedRequest<Map<String, dynamic>>('guest-carts/$cartId');
    return Cart.fromJson(response.data);
  }
  
  Future<bool> addToCart(String cartId, String sku, int quantity, [Map<String, dynamic>? productOption]) async {
    final data = {
      'cartItem': {
        'sku': sku,
        'qty': quantity,
        'quote_id': cartId,
        ...?productOption,
      },
    };
    
    try {
      await _authenticatedRequest('guest-carts/$cartId/items', data: data);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  Future<bool> updateCartItem(String cartId, int itemId, int quantity) async {
    final data = {
      'cartItem': {
        'qty': quantity,
        'quote_id': cartId,
      },
    };
    
    try {
      await _authenticatedRequest('guest-carts/$cartId/items/$itemId', data: data);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  Future<bool> removeFromCart(String cartId, int itemId) async {
    try {
      await _authenticatedRequest('guest-carts/$cartId/items/$itemId', options: Options(method: 'DELETE'));
      return true;
    } catch (e) {
      return false;
    }
  }
  
  /// Orders
  Future<List<Order>> getCustomerOrders() async {
    final response = await _authenticatedRequest<List<dynamic>>('customers/me/orders');
    return response.data.map((json) => Order.fromJson(json)).toList();
  }
  
  Future<Order> getOrder(String orderId) async {
    final response = await _authenticatedRequest<Map<String, dynamic>>('orders/$orderId');
    return Order.fromJson(response.data);
  }
  
  /// Wishlist
  Future<Map<String, dynamic>> getWishlist() async {
    final response = await _authenticatedRequest<Map<String, dynamic>>('customers/me/wishlist');
    return response.data;
  }
  
  Future<bool> addToWishlist(String sku) async {
    try {
      await _authenticatedRequest('customers/me/wishlist/add', data: {'sku': sku});
      return true;
    } catch (e) {
      return false;
    }
  }
  
  Future<bool> removeFromWishlist(int itemId) async {
    try {
      await _authenticatedRequest('customers/me/wishlist/remove/$itemId', options: Options(method: 'DELETE'));
      return true;
    } catch (e) {
      return false;
    }
  }
  
  /// Categories
  Future<List<Map<String, dynamic>>> getCategories() async {
    final response = await _dio.get<List<dynamic>>('categories');
    return response.data.map((json) => json as Map<String, dynamic>).toList();
  }
  
  Future<Map<String, dynamic>> getCategory(int categoryId) async {
    final response = await _dio.get<Map<String, dynamic>>('categories/$categoryId');
    return response.data;
  }
  
  /// Search
  Future<Map<String, dynamic>> searchProducts(String query, {int page = 1, int pageSize = 20}) async {
    final queryParams = {
      'searchCriteria[requestName]': 'quick_search_container',
      'searchCriteria[filterGroups][0][filters][0][field]': 'search_term',
      'searchCriteria[filterGroups][0][filters][0][value]': query,
      'searchCriteria[filterGroups][0][filters][0][conditionType]': 'like',
      'searchCriteria[currentPage]': page,
      'searchCriteria[pageSize]': pageSize,
    };
    
    final response = await _dio.get<Map<String, dynamic>>('search', queryParameters: queryParams);
    return response.data;
  }
  
  /// Checkout
  Future<Map<String, dynamic>> estimateShippingMethods(String cartId, Map<String, dynamic> address) async {
    final response = await _authenticatedRequest<Map<String, dynamic>>(
      'guest-carts/$cartId/estimate-shipping-methods',
      data: {'address': address},
    );
    return response.data;
  }
  
  Future<Map<String, dynamic>> estimatePaymentMethods(String cartId) async {
    final response = await _authenticatedRequest<Map<String, dynamic>>('guest-carts/$cartId/payment-methods');
    return response.data;
  }
  
  Future<Map<String, dynamic>> placeOrder(String cartId, Map<String, dynamic> orderData) async {
    final response = await _authenticatedRequest<Map<String, dynamic>>(
      'guest-carts/$cartId/order',
      data: orderData,
    );
    return response.data;
  }
}
