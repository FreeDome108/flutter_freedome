import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../constants/magento_constants.dart';

/// Utility functions for Magento integration
class MagentoUtils {
  /// Format price with currency
  static String formatPrice(double price, {String currency = 'USD'}) {
    return '\$${price.toStringAsFixed(MagentoConstants.pricePrecision)}';
  }
  
  /// Format price with custom precision
  static String formatPriceWithPrecision(double price, int precision) {
    return price.toStringAsFixed(precision);
  }
  
  /// Parse price string to double
  static double? parsePrice(String priceString) {
    try {
      // Remove currency symbols and whitespace
      final cleanPrice = priceString.replaceAll(RegExp(r'[^\d.-]'), '');
      return double.tryParse(cleanPrice);
    } catch (e) {
      if (kDebugMode) {
        print('❌ Failed to parse price: $priceString');
      }
      return null;
    }
  }
  
  /// Build search criteria for API requests
  static Map<String, dynamic> buildSearchCriteria({
    int page = 1,
    int pageSize = 20,
    List<Map<String, dynamic>>? filters,
    List<Map<String, dynamic>>? sortOrders,
  }) {
    final criteria = <String, dynamic>{
      MagentoConstants.searchCriteriaCurrentPage: page,
      MagentoConstants.searchCriteriaPageSize: pageSize,
    };
    
    if (filters != null && filters.isNotEmpty) {
      criteria[MagentoConstants.searchCriteriaFilterGroups] = filters;
    }
    
    if (sortOrders != null && sortOrders.isNotEmpty) {
      criteria[MagentoConstants.searchCriteriaSortOrders] = sortOrders;
    }
    
    return criteria;
  }
  
  /// Build filter for search criteria
  static Map<String, dynamic> buildFilter({
    required String field,
    required String value,
    required String conditionType,
  }) {
    return {
      'field': field,
      'value': value,
      'condition_type': conditionType,
    };
  }
  
  /// Build sort order for search criteria
  static Map<String, dynamic> buildSortOrder({
    required String field,
    String direction = MagentoConstants.sortDirectionAsc,
  }) {
    return {
      'field': field,
      'direction': direction,
    };
  }
  
  /// Validate email format
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
  
  /// Validate password strength
  static bool isStrongPassword(String password) {
    // At least 8 characters, 1 uppercase, 1 lowercase, 1 number
    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{8,}$');
    return passwordRegex.hasMatch(password);
  }
  
  /// Get password strength level
  static String getPasswordStrength(String password) {
    if (password.isEmpty) return 'Empty';
    
    int score = 0;
    
    if (password.length >= 8) score++;
    if (password.contains(RegExp(r'[a-z]'))) score++;
    if (password.contains(RegExp(r'[A-Z]'))) score++;
    if (password.contains(RegExp(r'[0-9]'))) score++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) score++;
    
    switch (score) {
      case 0:
      case 1:
        return 'Very Weak';
      case 2:
        return 'Weak';
      case 3:
        return 'Fair';
      case 4:
        return 'Good';
      case 5:
        return 'Strong';
      default:
        return 'Very Strong';
    }
  }
  
  /// Format date string
  static String formatDate(DateTime date, {String format = 'yyyy-MM-dd'}) {
    try {
      final year = date.year.toString().padLeft(4, '0');
      final month = date.month.toString().padLeft(2, '0');
      final day = date.day.toString().padLeft(2, '0');
      
      return format
          .replaceAll('yyyy', year)
          .replaceAll('MM', month)
          .replaceAll('dd', day);
    } catch (e) {
      if (kDebugMode) {
        print('❌ Failed to format date: $date');
      }
      return date.toIso8601String();
    }
  }
  
  /// Parse date string
  static DateTime? parseDate(String dateString) {
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      if (kDebugMode) {
        print('❌ Failed to parse date: $dateString');
      }
      return null;
    }
  }
  
  /// Format phone number
  static String formatPhoneNumber(String phone) {
    // Remove all non-digit characters
    final digits = phone.replaceAll(RegExp(r'[^\d]'), '');
    
    if (digits.length == 10) {
      return '(${digits.substring(0, 3)}) ${digits.substring(3, 6)}-${digits.substring(6)}';
    } else if (digits.length == 11 && digits.startsWith('1')) {
      return '+1 (${digits.substring(1, 4)}) ${digits.substring(4, 7)}-${digits.substring(7)}';
    }
    
    return phone;
  }
  
  /// Validate phone number
  static bool isValidPhoneNumber(String phone) {
    final digits = phone.replaceAll(RegExp(r'[^\d]'), '');
    return digits.length >= 10 && digits.length <= 15;
  }
  
  /// Generate random SKU
  static String generateSku({String prefix = 'SKU', int length = 8}) {
    final random = DateTime.now().millisecondsSinceEpoch;
    final hex = random.toRadixString(16).toUpperCase();
    return '$prefix-${hex.substring(0, length)}';
  }
  
  /// Generate random order ID
  static String generateOrderId({String prefix = 'ORD', int length = 10}) {
    final random = DateTime.now().millisecondsSinceEpoch;
    final hex = random.toRadixString(16).toUpperCase();
    return '$prefix-${hex.substring(0, length)}';
  }
  
  /// Calculate discount percentage
  static double calculateDiscountPercentage(double originalPrice, double discountedPrice) {
    if (originalPrice <= 0) return 0.0;
    return ((originalPrice - discountedPrice) / originalPrice) * 100;
  }
  
  /// Calculate tax amount
  static double calculateTaxAmount(double subtotal, double taxRate) {
    return subtotal * (taxRate / 100);
  }
  
  /// Calculate shipping cost with tax
  static double calculateShippingWithTax(double shippingCost, double taxRate) {
    return shippingCost + calculateTaxAmount(shippingCost, taxRate);
  }
  
  /// Round to currency precision
  static double roundToCurrencyPrecision(double amount) {
    return double.parse(amount.toStringAsFixed(MagentoConstants.pricePrecision));
  }
  
  /// Validate quantity
  static bool isValidQuantity(int quantity) {
    return quantity >= MagentoConstants.minQuantity && 
           quantity <= MagentoConstants.maxQuantity;
  }
  
  /// Validate page number
  static bool isValidPage(int page) {
    return page >= MagentoConstants.minPage && 
           page <= MagentoConstants.maxPage;
  }
  
  /// Validate page size
  static bool isValidPageSize(int pageSize) {
    return pageSize >= 1 && pageSize <= MagentoConstants.maxPageSize;
  }
  
  /// Sanitize search query
  static String sanitizeSearchQuery(String query) {
    // Remove special characters that might cause issues
    return query.replaceAll(RegExp(r'[^\w\s-]'), '').trim();
  }
  
  /// Build URL with query parameters
  static String buildUrl(String baseUrl, Map<String, dynamic> queryParams) {
    if (queryParams.isEmpty) return baseUrl;
    
    final uri = Uri.parse(baseUrl);
    final queryParameters = <String, String>{};
    
    for (final entry in queryParams.entries) {
      if (entry.value != null) {
        queryParameters[entry.key] = entry.value.toString();
      }
    }
    
    return uri.replace(queryParameters: queryParameters).toString();
  }
  
  /// Parse query parameters from URL
  static Map<String, String> parseQueryParameters(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.queryParameters;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Failed to parse query parameters from URL: $url');
      }
      return {};
    }
  }
  
  /// Convert map to query string
  static String mapToQueryString(Map<String, dynamic> params) {
    final queryParams = <String>[];
    
    for (final entry in params.entries) {
      if (entry.value != null) {
        queryParams.add('${entry.key}=${Uri.encodeComponent(entry.value.toString())}');
      }
    }
    
    return queryParams.join('&');
  }
  
  /// Deep merge two maps
  static Map<String, dynamic> deepMerge(
    Map<String, dynamic> target,
    Map<String, dynamic> source,
  ) {
    final result = Map<String, dynamic>.from(target);
    
    for (final entry in source.entries) {
      if (entry.value is Map && result[entry.key] is Map) {
        result[entry.key] = deepMerge(
          result[entry.key] as Map<String, dynamic>,
          entry.value as Map<String, dynamic>,
        );
      } else {
        result[entry.key] = entry.value;
      }
    }
    
    return result;
  }
  
  /// Check if two maps are equal
  static bool mapsAreEqual(Map<String, dynamic>? map1, Map<String, dynamic>? map2) {
    if (map1 == null && map2 == null) return true;
    if (map1 == null || map2 == null) return false;
    
    if (map1.length != map2.length) return false;
    
    for (final key in map1.keys) {
      if (!map2.containsKey(key)) return false;
      if (map1[key] != map2[key]) return false;
    }
    
    return true;
  }
  
  /// Convert list to paginated result
  static Map<String, dynamic> paginateList<T>(
    List<T> list,
    int page,
    int pageSize,
    int totalItems,
  ) {
    final startIndex = (page - 1) * pageSize;
    final endIndex = startIndex + pageSize;
    final items = list.sublist(
      startIndex,
      endIndex > list.length ? list.length : endIndex,
    );
    
    return {
      'items': items,
      'total_count': totalItems,
      'page_info': {
        'current_page': page,
        'page_size': pageSize,
        'total_pages': (totalItems / pageSize).ceil(),
      },
    };
  }
}
