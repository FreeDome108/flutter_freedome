import 'package:flutter/foundation.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

/// Service for handling analytics and tracking user interactions
class AnalyticsService {
  static FirebaseAnalytics? _analytics;
  static bool _isInitialized = false;

  /// Initialize analytics service
  static Future<void> initialize() async {
    if (!kReleaseMode) {
      if (kDebugMode) {
        print('📊 Analytics disabled in debug mode');
      }
      return;
    }

    try {
      _analytics = FirebaseAnalytics.instance;
      _isInitialized = true;
      
      if (kDebugMode) {
        print('📊 Analytics service initialized');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error initializing analytics: $e');
      }
    }
  }

  /// Track screen view
  static Future<void> trackScreenView(String screenName) async {
    if (!_isInitialized || _analytics == null) return;

    try {
      await _analytics!.logScreenView(screenName: screenName);
      if (kDebugMode) {
        print('📱 Screen view tracked: $screenName');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error tracking screen view: $e');
      }
    }
  }

  /// Track custom event
  static Future<void> trackEvent(
    String eventName, {
    Map<String, dynamic>? parameters,
  }) async {
    if (!_isInitialized || _analytics == null) return;

    try {
      await _analytics!.logEvent(
        name: eventName,
        parameters: parameters,
      );
      if (kDebugMode) {
        print('🎯 Event tracked: $eventName with params: $parameters');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error tracking event: $e');
      }
    }
  }

  /// Track user login
  static Future<void> trackLogin(String method) async {
    await trackEvent('login', parameters: {'method': method});
  }

  /// Track user signup
  static Future<void> trackSignUp(String method) async {
    await trackEvent('sign_up', parameters: {'method': method});
  }

  /// Track product view
  static Future<void> trackProductView({
    required String productId,
    required String productName,
    required String category,
    required double price,
  }) async {
    await trackEvent('view_item', parameters: {
      'item_id': productId,
      'item_name': productName,
      'item_category': category,
      'value': price,
      'currency': 'USD',
    });
  }

  /// Track add to cart
  static Future<void> trackAddToCart({
    required String productId,
    required String productName,
    required String category,
    required double price,
    required int quantity,
  }) async {
    await trackEvent('add_to_cart', parameters: {
      'item_id': productId,
      'item_name': productName,
      'item_category': category,
      'value': price * quantity,
      'currency': 'USD',
      'quantity': quantity,
    });
  }

  /// Track remove from cart
  static Future<void> trackRemoveFromCart({
    required String productId,
    required String productName,
    required String category,
    required double price,
    required int quantity,
  }) async {
    await trackEvent('remove_from_cart', parameters: {
      'item_id': productId,
      'item_name': productName,
      'item_category': category,
      'value': price * quantity,
      'currency': 'USD',
      'quantity': quantity,
    });
  }

  /// Track purchase
  static Future<void> trackPurchase({
    required String transactionId,
    required double value,
    required String currency,
    required List<Map<String, dynamic>> items,
  }) async {
    await trackEvent('purchase', parameters: {
      'transaction_id': transactionId,
      'value': value,
      'currency': currency,
      'items': items,
    });
  }

  /// Track search
  static Future<void> trackSearch(String searchTerm) async {
    await trackEvent('search', parameters: {
      'search_term': searchTerm,
    });
  }

  /// Track wishlist add
  static Future<void> trackAddToWishlist({
    required String productId,
    required String productName,
    required String category,
    required double price,
  }) async {
    await trackEvent('add_to_wishlist', parameters: {
      'item_id': productId,
      'item_name': productName,
      'item_category': category,
      'value': price,
      'currency': 'USD',
    });
  }

  /// Track share
  static Future<void> trackShare({
    required String contentType,
    required String itemId,
    required String method,
  }) async {
    await trackEvent('share', parameters: {
      'content_type': contentType,
      'item_id': itemId,
      'method': method,
    });
  }

  /// Track filter usage
  static Future<void> trackFilterUsage({
    required String filterType,
    required String filterValue,
  }) async {
    await trackEvent('filter_used', parameters: {
      'filter_type': filterType,
      'filter_value': filterValue,
    });
  }

  /// Track sort usage
  static Future<void> trackSortUsage({
    required String sortType,
    required String sortOrder,
  }) async {
    await trackEvent('sort_used', parameters: {
      'sort_type': sortType,
      'sort_order': sortOrder,
    });
  }

  /// Set user properties
  static Future<void> setUserProperty(String name, String value) async {
    if (!_isInitialized || _analytics == null) return;

    try {
      await _analytics!.setUserProperty(name: name, value: value);
      if (kDebugMode) {
        print('👤 User property set: $name = $value');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error setting user property: $e');
      }
    }
  }

  /// Set user ID
  static Future<void> setUserId(String userId) async {
    if (!_isInitialized || _analytics == null) return;

    try {
      await _analytics!.setUserId(id: userId);
      if (kDebugMode) {
        print('👤 User ID set: $userId');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error setting user ID: $e');
      }
    }
  }

  /// Reset analytics data
  static Future<void> resetAnalyticsData() async {
    if (!_isInitialized || _analytics == null) return;

    try {
      await _analytics!.resetAnalyticsData();
      if (kDebugMode) {
        print('🔄 Analytics data reset');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error resetting analytics data: $e');
      }
    }
  }

  /// Check if analytics is initialized
  static bool get isInitialized => _isInitialized;

  /// Get analytics instance
  static FirebaseAnalytics? get instance => _analytics;
}
