import 'package:dio/dio.dart';
import '../models/checkout_models.dart';
import '../models/order.dart';
import 'magento_api_client.dart';

/// API class for checkout operations
class CheckoutApi {
  final MagentoApiClient _apiClient;

  CheckoutApi(this._apiClient);

  /// Create a new checkout session
  Future<CheckoutSession> createCheckoutSession({
    required String cartId,
    String? email,
    Map<String, dynamic>? shippingAddress,
    Map<String, dynamic>? billingAddress,
    String? shippingMethod,
    String? paymentMethod,
  }) async {
    try {
      final response = await _apiClient.authenticatedRequest(
        '/rest/V1/checkout/sessions',
        data: {
          'cart_id': cartId,
          'email': email,
          'shipping_address': shippingAddress,
          'billing_address': billingAddress,
          'shipping_method': shippingMethod,
          'payment_method': paymentMethod,
        },
      );

      return CheckoutSession.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create checkout session: $e');
    }
  }

  /// Get checkout session by ID
  Future<CheckoutSession> getCheckoutSession(String sessionId) async {
    try {
      final response = await _apiClient.authenticatedRequest(
        '/rest/V1/checkout/sessions/$sessionId',
      );

      return CheckoutSession.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to get checkout session: $e');
    }
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
    try {
      final response = await _apiClient.authenticatedRequest(
        '/rest/V1/checkout/sessions/$sessionId',
        data: {
          'shipping_address': shippingAddress,
          'billing_address': billingAddress,
          'shipping_method': shippingMethod,
          'payment_method': paymentMethod,
          'additional_data': additionalData,
        },
      );

      return CheckoutSession.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update checkout session: $e');
    }
  }

  /// Get available shipping methods
  Future<List<ShippingMethod>> getShippingMethods({
    required String cartId,
    Map<String, dynamic>? address,
  }) async {
    try {
      final response = await _apiClient.authenticatedRequest(
        '/rest/V1/checkout/shipping-methods',
        queryParameters: {
          'cart_id': cartId,
          if (address != null) 'address': address,
        },
      );

      return (response.data as List)
          .map((json) => ShippingMethod.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to get shipping methods: $e');
    }
  }

  /// Get available payment methods
  Future<List<PaymentMethod>> getPaymentMethods({
    required String cartId,
    Map<String, dynamic>? address,
  }) async {
    try {
      final response = await _apiClient.authenticatedRequest(
        '/rest/V1/checkout/payment-methods',
        queryParameters: {
          'cart_id': cartId,
          if (address != null) 'address': address,
        },
      );

      return (response.data as List)
          .map((json) => PaymentMethod.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to get payment methods: $e');
    }
  }

  /// Place order
  Future<Order> placeOrder({
    required String cartId,
    Map<String, dynamic>? paymentData,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      final response = await _apiClient.authenticatedRequest(
        '/rest/V1/checkout/orders',
        data: {
          'cart_id': cartId,
          'payment_data': paymentData,
          'additional_data': additionalData,
        },
      );

      return Order.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to place order: $e');
    }
  }

  /// Validate checkout data
  Future<CheckoutValidationResult> validateCheckout({
    required String cartId,
    Map<String, dynamic>? shippingAddress,
    Map<String, dynamic>? billingAddress,
    String? shippingMethod,
    String? paymentMethod,
  }) async {
    try {
      final response = await _apiClient.authenticatedRequest(
        '/rest/V1/checkout/validate',
        data: {
          'cart_id': cartId,
          'shipping_address': shippingAddress,
          'billing_address': billingAddress,
          'shipping_method': shippingMethod,
          'payment_method': paymentMethod,
        },
      );

      return CheckoutValidationResult.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to validate checkout: $e');
    }
  }

  /// Get checkout totals
  Future<CheckoutTotals> getCheckoutTotals({
    required String cartId,
    Map<String, dynamic>? shippingAddress,
    String? shippingMethod,
    String? paymentMethod,
  }) async {
    try {
      final response = await _apiClient.authenticatedRequest(
        '/rest/V1/checkout/totals',
        queryParameters: {
          'cart_id': cartId,
          if (shippingAddress != null) 'shipping_address': shippingAddress,
          if (shippingMethod != null) 'shipping_method': shippingMethod,
          if (paymentMethod != null) 'payment_method': paymentMethod,
        },
      );

      return CheckoutTotals.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to get checkout totals: $e');
    }
  }

  /// Save shipping information
  Future<CheckoutSession> saveShippingInformation({
    required String cartId,
    required Map<String, dynamic> shippingAddress,
    String? shippingMethod,
  }) async {
    try {
      final response = await _apiClient.authenticatedRequest(
        '/rest/V1/checkout/shipping-information',
        data: {
          'cart_id': cartId,
          'shipping_address': shippingAddress,
          'shipping_method': shippingMethod,
        },
      );

      return CheckoutSession.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to save shipping information: $e');
    }
  }

  /// Save payment information
  Future<CheckoutSession> savePaymentInformation({
    required String cartId,
    required Map<String, dynamic> paymentMethod,
    Map<String, dynamic>? billingAddress,
  }) async {
    try {
      final response = await _apiClient.authenticatedRequest(
        '/rest/V1/checkout/payment-information',
        data: {
          'cart_id': cartId,
          'payment_method': paymentMethod,
          'billing_address': billingAddress,
        },
      );

      return CheckoutSession.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to save payment information: $e');
    }
  }

  /// Get guest checkout information
  Future<GuestCheckoutInfo> getGuestCheckoutInfo(String cartId) async {
    try {
      final response = await _apiClient.guestRequest(
        '/rest/V1/guest-checkout/$cartId',
      );

      return GuestCheckoutInfo.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to get guest checkout info: $e');
    }
  }

  /// Save guest checkout information
  Future<GuestCheckoutInfo> saveGuestCheckoutInfo({
    required String cartId,
    required String email,
    Map<String, dynamic>? shippingAddress,
    Map<String, dynamic>? billingAddress,
  }) async {
    try {
      final response = await _apiClient.guestRequest(
        '/rest/V1/guest-checkout/$cartId',
        data: {
          'email': email,
          'shipping_address': shippingAddress,
          'billing_address': billingAddress,
        },
      );

      return GuestCheckoutInfo.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to save guest checkout info: $e');
    }
  }
}
