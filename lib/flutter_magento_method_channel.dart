import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_magento_platform_interface.dart';

/// An implementation of [FlutterMagentoPlatform] that uses method channels.
class MethodChannelFlutterMagento extends FlutterMagentoPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_magento');

  String? _customerToken;
  String? _error;

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool> initialize({
    required String baseUrl,
    Map<String, String>? headers,
    int? connectionTimeout,
    int? receiveTimeout,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<bool>('initialize', {
        'baseUrl': baseUrl,
        'headers': headers,
        'connectionTimeout': connectionTimeout,
        'receiveTimeout': receiveTimeout,
      });
      return result ?? false;
    } catch (e) {
      _error = e.toString();
      return false;
    }
  }

  @override
  Future<bool> authenticateCustomer({
    required String email,
    required String password,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<bool>('authenticateCustomer', {
        'email': email,
        'password': password,
      });
      
      if (result == true) {
        // Get token after successful authentication
        _customerToken = await methodChannel.invokeMethod<String>('getCustomerToken');
      }
      
      return result ?? false;
    } catch (e) {
      _error = e.toString();
      return false;
    }
  }

  @override
  Future<Map<String, dynamic>?> createCustomer({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<Map<String, dynamic>>('createCustomer', {
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
      });
      return result;
    } catch (e) {
      _error = e.toString();
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>?> getCurrentCustomer() async {
    try {
      final result = await methodChannel.invokeMethod<Map<String, dynamic>>('getCurrentCustomer');
      return result;
    } catch (e) {
      _error = e.toString();
      return null;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await methodChannel.invokeMethod('logout');
      _customerToken = null;
    } catch (e) {
      _error = e.toString();
    }
  }

  @override
  Future<Map<String, dynamic>?> getProducts({
    int page = 1,
    int pageSize = 20,
    String? searchQuery,
    String? categoryId,
    String? sortBy,
    String? sortOrder,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<Map<String, dynamic>>('getProducts', {
        'page': page,
        'pageSize': pageSize,
        'searchQuery': searchQuery,
        'categoryId': categoryId,
        'sortBy': sortBy,
        'sortOrder': sortOrder,
        'filters': filters,
      });
      return result;
    } catch (e) {
      _error = e.toString();
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>?> getProduct(String sku) async {
    try {
      final result = await methodChannel.invokeMethod<Map<String, dynamic>>('getProduct', {
        'sku': sku,
      });
      return result;
    } catch (e) {
      _error = e.toString();
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>?> getCart() async {
    try {
      final result = await methodChannel.invokeMethod<Map<String, dynamic>>('getCart');
      return result;
    } catch (e) {
      _error = e.toString();
      return null;
    }
  }

  @override
  Future<bool> addToCart(String sku, int quantity, [Map<String, dynamic>? productOption]) async {
    try {
      final result = await methodChannel.invokeMethod<bool>('addToCart', {
        'sku': sku,
        'quantity': quantity,
        'productOption': productOption,
      });
      return result ?? false;
    } catch (e) {
      _error = e.toString();
      return false;
    }
  }

  @override
  Future<bool> removeFromCart(String itemId) async {
    try {
      final result = await methodChannel.invokeMethod<bool>('removeFromCart', {
        'itemId': itemId,
      });
      return result ?? false;
    } catch (e) {
      _error = e.toString();
      return false;
    }
  }

  @override
  Future<bool> updateCartItem(String itemId, int quantity) async {
    try {
      final result = await methodChannel.invokeMethod<bool>('updateCartItem', {
        'itemId': itemId,
        'quantity': quantity,
      });
      return result ?? false;
    } catch (e) {
      _error = e.toString();
      return false;
    }
  }

  @override
  Future<List<Map<String, dynamic>>?> getCustomerOrders() async {
    try {
      final result = await methodChannel.invokeMethod<List<dynamic>>('getCustomerOrders');
      if (result != null) {
        return result.cast<Map<String, dynamic>>();
      }
      return null;
    } catch (e) {
      _error = e.toString();
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>?> getOrder(String orderId) async {
    try {
      final result = await methodChannel.invokeMethod<Map<String, dynamic>>('getOrder', {
        'orderId': orderId,
      });
      return result;
    } catch (e) {
      _error = e.toString();
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>?> getWishlist() async {
    try {
      final result = await methodChannel.invokeMethod<Map<String, dynamic>>('getWishlist');
      return result;
    } catch (e) {
      _error = e.toString();
      return null;
    }
  }

  @override
  Future<bool> addToWishlist(String sku) async {
    try {
      final result = await methodChannel.invokeMethod<bool>('addToWishlist', {
        'sku': sku,
      });
      return result ?? false;
    } catch (e) {
      _error = e.toString();
      return false;
    }
  }

  @override
  Future<bool> removeFromWishlist(String itemId) async {
    try {
      final result = await methodChannel.invokeMethod<bool>('removeFromWishlist', {
        'itemId': itemId,
      });
      return result ?? false;
    } catch (e) {
      _error = e.toString();
      return false;
    }
  }

  @override
  bool get isAuthenticated => _customerToken != null;

  @override
  String? get customerToken => _customerToken;

  @override
  String? get error => _error;

  @override
  void clearError() {
    _error = null;
  }
}
