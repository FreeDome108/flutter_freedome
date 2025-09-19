import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../constants/api_constants.dart';
import '../constants/app_constants.dart';
import '../models/magento_models.dart';
import 'secure_storage_service.dart';

/// Service for integrating with Magento API
/// Handles authentication, products, cart, orders, and customer operations
class MagentoApiService {
  late final Dio _dio;
  String? _customerToken;
  String? _guestCartId;
  bool _isLoading = false;
  String? _error;

  // Singleton pattern
  static final MagentoApiService _instance = MagentoApiService._internal();
  factory MagentoApiService() => _instance;
  MagentoApiService._internal() {
    _initializeDio();
    _loadStoredTokens();
  }

  // Getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _customerToken != null;
  String? get customerToken => _customerToken;
  String? get guestCartId => _guestCartId;

  void _initializeDio() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConstants.apiV1,
      connectTimeout: AppConstants.connectionTimeout,
      receiveTimeout: AppConstants.connectionTimeout,
      headers: ApiConstants.defaultHeaders,
    ));

    // Add interceptors for logging and error handling
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (kDebugMode) {
          print('🚀 Magento API Request: ${options.method} ${options.path}');
          if (options.data != null) {
            print('📦 Request Data: ${options.data}');
          }
        }
        handler.next(options);
      },
      onResponse: (response, handler) {
        if (kDebugMode) {
          print('✅ Magento API Response: ${response.statusCode} ${response.requestOptions.path}');
        }
        handler.next(response);
      },
      onError: (error, handler) {
        if (kDebugMode) {
          print('❌ Magento API Error: ${error.message}');
          if (error.response?.data != null) {
            print('📋 Error Data: ${error.response?.data}');
          }
        }
        _handleError(error);
        handler.next(error);
      },
    ));
  }

  Future<void> _loadStoredTokens() async {
    try {
      _customerToken = await SecureStorageService.getString(AppConstants.keyAuthToken);
      _guestCartId = await SecureStorageService.getString(AppConstants.keyCartId);
      _updateAuthHeader();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading stored tokens: $e');
      }
    }
  }

  void _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        _error = AppConstants.networkErrorMessage;
        break;
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final responseData = error.response?.data;
        
        switch (statusCode) {
          case ApiConstants.unauthorized:
            _error = 'Authentication failed. Please login again.';
            _customerToken = null;
            SecureStorageService.remove(AppConstants.keyAuthToken);
            break;
          case ApiConstants.forbidden:
            _error = 'Access denied. You don\'t have permission to perform this action.';
            break;
          case ApiConstants.notFound:
            _error = 'Resource not found.';
            break;
          case 422:
            final message = responseData is Map && responseData.containsKey('message') 
                ? responseData['message'] 
                : 'Validation error.';
            _error = message;
            break;
          case ApiConstants.serverError:
          case ApiConstants.badGateway:
          case ApiConstants.serviceUnavailable:
            _error = AppConstants.serverErrorMessage;
            break;
          default:
            _error = AppConstants.unknownErrorMessage;
            break;
        }
        break;
      case DioExceptionType.cancel:
        _error = 'Request was cancelled.';
        break;
      default:
        _error = AppConstants.networkErrorMessage;
        break;
    }
  }

  void _updateAuthHeader() {
    if (_customerToken != null) {
      _dio.options.headers['Authorization'] = 'Bearer $_customerToken';
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }

  void clearError() {
    _error = null;
  }

  // Authentication Methods

  /// Create a new customer account
  Future<MagentoCustomer?> createCustomer({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final response = await _dio.post(ApiConstants.registerEndpoint, data: {
        'customer': {
          'email': email,
          'firstname': firstName,
          'lastname': lastName,
        },
        'password': password,
      });

      if (response.statusCode == 200) {
        return MagentoCustomer.fromJson(response.data);
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error creating customer: $e');
      }
      return null;
    }
  }

  /// Authenticate customer and get token
  Future<bool> authenticateCustomer({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(ApiConstants.loginEndpoint, data: {
        'username': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        _customerToken = response.data.toString().replaceAll('"', '');
        await SecureStorageService.setString(AppConstants.keyAuthToken, _customerToken!);
        _updateAuthHeader();
        return true;
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print('Error authenticating customer: $e');
      }
      return false;
    }
  }

  /// Logout customer
  Future<void> logout() async {
    try {
      if (_customerToken != null) {
        await _dio.post(ApiConstants.logoutEndpoint);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during logout: $e');
      }
    } finally {
      _customerToken = null;
      _guestCartId = null;
      await SecureStorageService.remove(AppConstants.keyAuthToken);
      await SecureStorageService.remove(AppConstants.keyCartId);
      _updateAuthHeader();
    }
  }

  // Customer Methods

  /// Get current customer information
  Future<MagentoCustomer?> getCurrentCustomer() async {
    if (!isAuthenticated) return null;

    try {
      final response = await _dio.get(ApiConstants.customerInfoEndpoint);
      
      if (response.statusCode == 200) {
        return MagentoCustomer.fromJson(response.data);
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting current customer: $e');
      }
      return null;
    }
  }

  /// Update customer information
  Future<bool> updateCustomer(MagentoCustomer customer) async {
    if (!isAuthenticated) return false;

    try {
      final response = await _dio.put(ApiConstants.updateCustomerEndpoint, data: {
        'customer': customer.toJson(),
      });

      return response.statusCode == 200;
    } catch (e) {
      if (kDebugMode) {
        print('Error updating customer: $e');
      }
      return false;
    }
  }

  // Product Methods

  /// Get products with pagination and filters
  Future<MagentoProductList?> getProducts({
    int page = 1,
    int pageSize = AppConstants.defaultPageSize,
    String? searchQuery,
    String? categoryId,
    String? sortBy,
    String? sortOrder,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'searchCriteria[pageSize]': pageSize,
        'searchCriteria[currentPage]': page,
      };

      // Add search filter
      if (searchQuery != null && searchQuery.isNotEmpty) {
        queryParams['searchCriteria[filterGroups][0][filters][0][field]'] = 'name';
        queryParams['searchCriteria[filterGroups][0][filters][0][value]'] = '%$searchQuery%';
        queryParams['searchCriteria[filterGroups][0][filters][0][conditionType]'] = 'like';
      }

      // Add category filter
      if (categoryId != null) {
        final groupIndex = searchQuery != null ? 1 : 0;
        queryParams['searchCriteria[filterGroups][$groupIndex][filters][0][field]'] = 'category_id';
        queryParams['searchCriteria[filterGroups][$groupIndex][filters][0][value]'] = categoryId;
        queryParams['searchCriteria[filterGroups][$groupIndex][filters][0][conditionType]'] = 'eq';
      }

      // Add custom filters
      if (filters != null) {
        var groupIndex = 0;
        if (searchQuery != null) groupIndex++;
        if (categoryId != null) groupIndex++;

        filters.forEach((field, value) {
          queryParams['searchCriteria[filterGroups][$groupIndex][filters][0][field]'] = field;
          queryParams['searchCriteria[filterGroups][$groupIndex][filters][0][value]'] = value;
          queryParams['searchCriteria[filterGroups][$groupIndex][filters][0][conditionType]'] = 'eq';
          groupIndex++;
        });
      }

      // Add sorting
      if (sortBy != null) {
        queryParams['searchCriteria[sortOrders][0][field]'] = sortBy;
        queryParams['searchCriteria[sortOrders][0][direction]'] = sortOrder ?? 'ASC';
      }

      final response = await _dio.get(ApiConstants.productsEndpoint, queryParameters: queryParams);
      
      if (response.statusCode == 200) {
        return MagentoProductList.fromJson(response.data);
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting products: $e');
      }
      return null;
    }
  }

  /// Get product by SKU
  Future<MagentoProduct?> getProduct(String sku) async {
    try {
      final response = await _dio.get('${ApiConstants.productsEndpoint}/$sku');
      
      if (response.statusCode == 200) {
        return MagentoProduct.fromJson(response.data);
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting product: $e');
      }
      return null;
    }
  }

  // Cart Methods

  /// Create a guest cart
  Future<String?> createGuestCart() async {
    try {
      final response = await _dio.post('${ApiConstants.apiV1}/guest-carts');
      
      if (response.statusCode == 200) {
        _guestCartId = response.data.toString().replaceAll('"', '');
        await SecureStorageService.setString(AppConstants.keyCartId, _guestCartId!);
        return _guestCartId;
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error creating guest cart: $e');
      }
      return null;
    }
  }

  /// Get cart information
  Future<MagentoCart?> getCart([String? cartId]) async {
    try {
      String? targetCartId = cartId ?? _guestCartId;
      
      if (isAuthenticated) {
        final response = await _dio.get(ApiConstants.cartEndpoint);
        if (response.statusCode == 200) {
          return MagentoCart.fromJson(response.data);
        }
      } else if (targetCartId != null) {
        final response = await _dio.get('${ApiConstants.apiV1}/guest-carts/$targetCartId');
        if (response.statusCode == 200) {
          return MagentoCart.fromJson(response.data);
        }
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting cart: $e');
      }
      return null;
    }
  }

  /// Add item to cart
  Future<bool> addToCart(String sku, int quantity, [Map<String, dynamic>? productOption]) async {
    try {
      if (!isAuthenticated && _guestCartId == null) {
        await createGuestCart();
      }

      final cartItem = {
        'cartItem': {
          'sku': sku,
          'qty': quantity,
          if (productOption != null) 'product_option': productOption,
        },
      };

      Response response;
      if (isAuthenticated) {
        response = await _dio.post(ApiConstants.addToCartEndpoint, data: cartItem);
      } else {
        response = await _dio.post('${ApiConstants.apiV1}/guest-carts/$_guestCartId/items', data: cartItem);
      }
      
      return response.statusCode == 200;
    } catch (e) {
      if (kDebugMode) {
        print('Error adding to cart: $e');
      }
      return false;
    }
  }

  /// Remove item from cart
  Future<bool> removeFromCart(String itemId) async {
    try {
      Response response;
      if (isAuthenticated) {
        response = await _dio.delete(ApiConstants.removeCartItemEndpoint.replaceAll('{itemId}', itemId));
      } else if (_guestCartId != null) {
        response = await _dio.delete('${ApiConstants.apiV1}/guest-carts/$_guestCartId/items/$itemId');
      } else {
        return false;
      }
      
      return response.statusCode == 200;
    } catch (e) {
      if (kDebugMode) {
        print('Error removing from cart: $e');
      }
      return false;
    }
  }

  /// Update cart item quantity
  Future<bool> updateCartItem(String itemId, int quantity) async {
    try {
      final cartItem = {
        'cartItem': {
          'qty': quantity,
        },
      };

      Response response;
      if (isAuthenticated) {
        response = await _dio.put(
          ApiConstants.updateCartItemEndpoint.replaceAll('{itemId}', itemId), 
          data: cartItem,
        );
      } else if (_guestCartId != null) {
        response = await _dio.put(
          '${ApiConstants.apiV1}/guest-carts/$_guestCartId/items/$itemId', 
          data: cartItem,
        );
      } else {
        return false;
      }
      
      return response.statusCode == 200;
    } catch (e) {
      if (kDebugMode) {
        print('Error updating cart item: $e');
      }
      return false;
    }
  }

  // Order Methods

  /// Get customer orders
  Future<List<MagentoOrder>?> getCustomerOrders() async {
    if (!isAuthenticated) return null;

    try {
      final response = await _dio.get(ApiConstants.customerOrdersEndpoint);
      
      if (response.statusCode == 200) {
        final data = response.data;
        if (data is Map && data.containsKey('items')) {
          final List<dynamic> ordersData = data['items'];
          return ordersData.map((json) => MagentoOrder.fromJson(json)).toList();
        }
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting customer orders: $e');
      }
      return null;
    }
  }

  /// Get order by ID
  Future<MagentoOrder?> getOrder(String orderId) async {
    if (!isAuthenticated) return null;

    try {
      final response = await _dio.get(ApiConstants.orderByIdEndpoint.replaceAll('{orderId}', orderId));
      
      if (response.statusCode == 200) {
        return MagentoOrder.fromJson(response.data);
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting order: $e');
      }
      return null;
    }
  }

  // Wishlist Methods

  /// Get customer wishlist
  Future<MagentoWishlist?> getWishlist() async {
    if (!isAuthenticated) return null;

    try {
      final response = await _dio.get(ApiConstants.wishlistEndpoint);
      
      if (response.statusCode == 200) {
        return MagentoWishlist.fromJson(response.data);
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting wishlist: $e');
      }
      return null;
    }
  }

  /// Add product to wishlist
  Future<bool> addToWishlist(String sku) async {
    if (!isAuthenticated) return false;

    try {
      final response = await _dio.post(ApiConstants.addToWishlistEndpoint, data: {
        'wishlistItem': {
          'sku': sku,
        },
      });
      
      return response.statusCode == 200;
    } catch (e) {
      if (kDebugMode) {
        print('Error adding to wishlist: $e');
      }
      return false;
    }
  }

  /// Remove product from wishlist
  Future<bool> removeFromWishlist(String itemId) async {
    if (!isAuthenticated) return false;

    try {
      final response = await _dio.delete(
        ApiConstants.removeFromWishlistEndpoint.replaceAll('{itemId}', itemId),
      );
      
      return response.statusCode == 200;
    } catch (e) {
      if (kDebugMode) {
        print('Error removing from wishlist: $e');
      }
      return false;
    }
  }
}
