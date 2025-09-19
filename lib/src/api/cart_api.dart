import 'package:dio/dio.dart';
import '../models/cart_models.dart';
import 'magento_api_client.dart';

/// Cart API for Magento
class CartApi {
  final MagentoApiClient _client;

  CartApi(this._client);

  /// Create a new cart
  Future<Cart> createCart() async {
    try {
      final response = await _client.guestRequest<Map<String, dynamic>>(
        '/rest/V1/guest-carts',
        options: Options(method: 'POST'),
      );

      if (response.statusCode == 200) {
        return Cart.fromJson(response.data!);
      } else {
        throw Exception('Failed to create cart: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to create cart: ${e.message}');
    } catch (e) {
      throw Exception('Failed to create cart: $e');
    }
  }

  /// Get cart information
  Future<Cart> getCart(String cartId) async {
    try {
      final response = await _client.guestRequest<Map<String, dynamic>>(
        '/rest/V1/guest-carts/$cartId',
      );

      if (response.statusCode == 200) {
        return Cart.fromJson(response.data!);
      } else {
        throw Exception('Failed to get cart: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get cart: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get cart: $e');
    }
  }

  /// Get customer cart
  Future<Cart> getCustomerCart() async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/carts/mine',
      );

      if (response.statusCode == 200) {
        return Cart.fromJson(response.data!);
      } else {
        throw Exception('Failed to get customer cart: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get customer cart: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get customer cart: $e');
    }
  }

  /// Add item to cart
  Future<Cart> addToCart({
    required String cartId,
    required String sku,
    required int quantity,
    Map<String, dynamic>? productOptions,
  }) async {
    try {
      final data = {
        'cartItem': {
          'sku': sku,
          'qty': quantity,
          'quote_id': cartId,
        },
      };

      if (productOptions != null) {
        data['cartItem']!['product_option'] = productOptions;
      }

      final response = await _client.guestRequest<Map<String, dynamic>>(
        '/rest/V1/guest-carts/$cartId/items',
        data: data,
        options: Options(method: 'POST'),
      );

      if (response.statusCode == 200) {
        return Cart.fromJson(response.data!);
      } else {
        throw Exception('Failed to add item to cart: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to add item to cart: ${e.message}');
    } catch (e) {
      throw Exception('Failed to add item to cart: $e');
    }
  }

  /// Add item to customer cart
  Future<Cart> addToCustomerCart({
    required String sku,
    required int quantity,
    Map<String, dynamic>? productOptions,
  }) async {
    try {
      final data = {
        'cartItem': {
          'sku': sku,
          'qty': quantity,
        },
      };

      if (productOptions != null) {
        data['cartItem']!['product_option'] = productOptions;
      }

      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/carts/mine/items',
        options: Options(method: 'POST'),
        data: data,
      );

      if (response.statusCode == 200) {
        return Cart.fromJson(response.data!);
      } else {
        throw Exception('Failed to add item to customer cart: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to add item to customer cart: ${e.message}');
    } catch (e) {
      throw Exception('Failed to add item to customer cart: $e');
    }
  }

  /// Update cart item quantity
  Future<Cart> updateCartItemQuantity({
    required String cartId,
    required int itemId,
    required int quantity,
  }) async {
    try {
      final data = {
        'cartItem': {
          'qty': quantity,
          'quote_id': cartId,
        },
      };

      final response = await _client.guestRequest<Map<String, dynamic>>(
        '/rest/V1/guest-carts/$cartId/items/$itemId',
        options: Options(method: 'PUT'),
        data: data,
      );

      if (response.statusCode == 200) {
        return Cart.fromJson(response.data!);
      } else {
        throw Exception('Failed to update cart item: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to update cart item: ${e.message}');
    } catch (e) {
      throw Exception('Failed to update cart item: $e');
    }
  }

  /// Update customer cart item quantity
  Future<Cart> updateCustomerCartItemQuantity({
    required int itemId,
    required int quantity,
  }) async {
    try {
      final data = {
        'cartItem': {
          'qty': quantity,
        },
      };

      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/carts/mine/items/$itemId',
        options: Options(method: 'PUT'),
        data: data,
      );

      if (response.statusCode == 200) {
        return Cart.fromJson(response.data!);
      } else {
        throw Exception('Failed to update customer cart item: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to update customer cart item: ${e.message}');
    } catch (e) {
      throw Exception('Failed to update customer cart item: $e');
    }
  }

  /// Remove item from cart
  Future<Cart> removeFromCart({
    required String cartId,
    required int itemId,
  }) async {
    try {
      final response = await _client.guestRequest<Map<String, dynamic>>(
        '/rest/V1/guest-carts/$cartId/items/$itemId',
        options: Options(method: 'DELETE'),
      );

      if (response.statusCode == 200) {
        return Cart.fromJson(response.data!);
      } else {
        throw Exception('Failed to remove item from cart: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to remove item from cart: ${e.message}');
    } catch (e) {
      throw Exception('Failed to remove item from cart: $e');
    }
  }

  /// Remove item from customer cart
  Future<Cart> removeFromCustomerCart(int itemId) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/carts/mine/items/$itemId',
        options: Options(method: 'DELETE'),
      );

      if (response.statusCode == 200) {
        return Cart.fromJson(response.data!);
      } else {
        throw Exception('Failed to remove item from customer cart: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to remove item from customer cart: ${e.message}');
    } catch (e) {
      throw Exception('Failed to remove item from customer cart: $e');
    }
  }

  /// Apply coupon to cart
  Future<Cart> applyCoupon({
    required String cartId,
    required String couponCode,
  }) async {
    try {
      final response = await _client.guestRequest<Map<String, dynamic>>(
        '/rest/V1/guest-carts/$cartId/coupons/$couponCode',
        options: Options(method: 'PUT'),
      );

      if (response.statusCode == 200) {
        return Cart.fromJson(response.data!);
      } else {
        throw Exception('Failed to apply coupon: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to apply coupon: ${e.message}');
    } catch (e) {
      throw Exception('Failed to apply coupon: $e');
    }
  }

  /// Apply coupon to customer cart
  Future<Cart> applyCouponToCustomerCart(String couponCode) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/carts/mine/coupons/$couponCode',
        options: Options(method: 'PUT'),
      );

      if (response.statusCode == 200) {
        return Cart.fromJson(response.data!);
      } else {
        throw Exception('Failed to apply coupon to customer cart: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to apply coupon to customer cart: ${e.message}');
    } catch (e) {
      throw Exception('Failed to apply coupon to customer cart: $e');
    }
  }

  /// Remove coupon from cart
  Future<Cart> removeCoupon(String cartId) async {
    try {
      final response = await _client.guestRequest<Map<String, dynamic>>(
        '/rest/V1/guest-carts/$cartId/coupons',
        options: Options(method: 'DELETE'),
      );

      if (response.statusCode == 200) {
        return Cart.fromJson(response.data!);
      } else {
        throw Exception('Failed to remove coupon: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to remove coupon: ${e.message}');
    } catch (e) {
      throw Exception('Failed to remove coupon: $e');
    }
  }

  /// Remove coupon from customer cart
  Future<Cart> removeCouponFromCustomerCart() async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/carts/mine/coupons',
        options: Options(method: 'DELETE'),
      );

      if (response.statusCode == 200) {
        return Cart.fromJson(response.data!);
      } else {
        throw Exception('Failed to remove coupon from customer cart: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to remove coupon from customer cart: ${e.message}');
    } catch (e) {
      throw Exception('Failed to remove coupon from customer cart: $e');
    }
  }

  /// Get cart totals
  Future<CartTotals> getCartTotals(String cartId) async {
    try {
      final response = await _client.guestRequest<Map<String, dynamic>>(
        '/rest/V1/guest-carts/$cartId/totals',
      );

      if (response.statusCode == 200) {
        return CartTotals.fromJson(response.data!);
      } else {
        throw Exception('Failed to get cart totals: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get cart totals: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get cart totals: $e');
    }
  }

  /// Get customer cart totals
  Future<CartTotals> getCustomerCartTotals() async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/carts/mine/totals',
      );

      if (response.statusCode == 200) {
        return CartTotals.fromJson(response.data!);
      } else {
        throw Exception('Failed to get customer cart totals: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get customer cart totals: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get customer cart totals: $e');
    }
  }

  /// Estimate shipping for cart
  Future<List<ShippingMethod>> estimateShipping({
    required String cartId,
    required Address address,
  }) async {
    try {
      final response = await _client.guestRequest<Map<String, dynamic>>(
        '/rest/V1/guest-carts/$cartId/estimate-shipping-methods',
        options: Options(method: 'POST'),
        data: {
          'address': address.toJson(),
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> methods = response.data!['shipping_methods'] ?? [];
        return methods.map((method) => ShippingMethod.fromJson(method)).toList();
      } else {
        throw Exception('Failed to estimate shipping: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to estimate shipping: ${e.message}');
    } catch (e) {
      throw Exception('Failed to estimate shipping: $e');
    }
  }

  /// Estimate shipping for customer cart
  Future<List<ShippingMethod>> estimateCustomerCartShipping(Address address) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/carts/mine/estimate-shipping-methods',
        options: Options(method: 'POST'),
        data: {
          'address': address.toJson(),
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> methods = response.data!['shipping_methods'] ?? [];
        return methods.map((method) => ShippingMethod.fromJson(method)).toList();
      } else {
        throw Exception('Failed to estimate customer cart shipping: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to estimate customer cart shipping: ${e.message}');
    } catch (e) {
      throw Exception('Failed to estimate customer cart shipping: $e');
    }
  }

  /// Set shipping information for cart
  Future<Cart> setShippingInformation({
    required String cartId,
    required Address address,
    required String methodCode,
    required String carrierCode,
  }) async {
    try {
      final response = await _client.guestRequest<Map<String, dynamic>>(
        '/rest/V1/guest-carts/$cartId/shipping-information',
        options: Options(method: 'POST'),
        data: {
          'addressInformation': {
            'shipping_address': address.toJson(),
            'billing_address': address.toJson(),
            'shipping_method_code': methodCode,
            'shipping_carrier_code': carrierCode,
          },
        },
      );

      if (response.statusCode == 200) {
        return Cart.fromJson(response.data!);
      } else {
        throw Exception('Failed to set shipping information: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to set shipping information: ${e.message}');
    } catch (e) {
      throw Exception('Failed to set shipping information: $e');
    }
  }

  /// Set shipping information for customer cart
  Future<Cart> setCustomerCartShippingInformation({
    required Address address,
    required String methodCode,
    required String carrierCode,
  }) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/carts/mine/shipping-information',
        options: Options(method: 'POST'),
        data: {
          'addressInformation': {
            'shipping_address': address.toJson(),
            'billing_address': address.toJson(),
            'shipping_method_code': methodCode,
            'shipping_carrier_code': carrierCode,
          },
        },
      );

      if (response.statusCode == 200) {
        return Cart.fromJson(response.data!);
      } else {
        throw Exception('Failed to set customer cart shipping information: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to set customer cart shipping information: ${e.message}');
    } catch (e) {
      throw Exception('Failed to set customer cart shipping information: $e');
    }
  }

  /// Move item from cart to wishlist
  Future<bool> moveToWishlist({
    required String cartId,
    required int itemId,
  }) async {
    try {
      // First remove from cart
      await removeFromCart(cartId: cartId, itemId: itemId);
      
      // TODO: Implement wishlist API integration
      // For now, just return success
      return true;
    } catch (e) {
      throw Exception('Failed to move item to wishlist: $e');
    }
  }

  /// Merge guest cart with customer cart
  Future<Cart> mergeGuestCart(String customerId) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/carts/mine/merge',
        options: Options(method: 'POST'),
        data: {
          'customer_id': customerId,
        },
      );

      if (response.statusCode == 200) {
        return Cart.fromJson(response.data!);
      } else {
        throw Exception('Failed to merge guest cart: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to merge guest cart: ${e.message}');
    } catch (e) {
      throw Exception('Failed to merge guest cart: $e');
    }
  }

  /// Delete cart
  Future<bool> deleteCart(String cartId) async {
    try {
      final response = await _client.guestRequest<Map<String, dynamic>>(
        '/rest/V1/guest-carts/$cartId',
        options: Options(method: 'DELETE'),
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw Exception('Failed to delete cart: ${e.message}');
    } catch (e) {
      throw Exception('Failed to delete cart: $e');
    }
  }

  /// Clear customer cart
  Future<bool> clearCustomerCart() async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/carts/mine',
        options: Options(method: 'DELETE'),
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw Exception('Failed to clear customer cart: ${e.message}');
    } catch (e) {
      throw Exception('Failed to clear customer cart: $e');
    }
  }
}
