import 'package:dio/dio.dart';
import '../models/customer_models.dart';
import '../models/customer.dart';
import 'magento_api_client.dart';

/// API class for customer management operations
class CustomerApi {
  final MagentoApiClient _apiClient;

  CustomerApi(this._apiClient);

  /// Get customer profile
  Future<Customer> getCustomerProfile() async {
    try {
      final response = await _apiClient.authenticatedRequest(
        '/rest/V1/customers/me',
      );

      return Customer.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to get customer profile: $e');
    }
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
    try {
      final response = await _apiClient.authenticatedRequest(
        '/rest/V1/customers/me',
        data: {
          if (firstName != null) 'firstname': firstName,
          if (lastName != null) 'lastname': lastName,
          if (middleName != null) 'middlename': middleName,
          if (prefix != null) 'prefix': prefix,
          if (suffix != null) 'suffix': suffix,
          if (dateOfBirth != null) 'dob': dateOfBirth,
          if (taxVat != null) 'taxvat': taxVat,
          if (gender != null) 'gender': gender,
          if (isSubscribed != null) 'is_subscribed': isSubscribed,
        },
      );

      return Customer.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update customer profile: $e');
    }
  }

  /// Get customer addresses
  Future<List<CustomerAddress>> getCustomerAddresses() async {
    try {
      final response = await _apiClient.authenticatedRequest(
        '/rest/V1/customers/me/addresses',
      );

      return (response.data as List)
          .map((json) => CustomerAddress.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to get customer addresses: $e');
    }
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
    try {
      final response = await _apiClient.authenticatedRequest(
        '/rest/V1/customers/me/addresses',
        data: {
          'firstname': firstName,
          'lastname': lastName,
          'street': street,
          'city': city,
          'region': region,
          'postcode': postcode,
          'country_id': countryId,
          'telephone': telephone,
          if (middleName != null) 'middlename': middleName,
          if (prefix != null) 'prefix': prefix,
          if (suffix != null) 'suffix': suffix,
          if (company != null) 'company': company,
          if (regionId != null) 'region_id': regionId,
          if (regionCode != null) 'region_code': regionCode,
          if (fax != null) 'fax': fax,
          if (isDefaultShipping != null) 'default_shipping': isDefaultShipping,
          if (isDefaultBilling != null) 'default_billing': isDefaultBilling,
          if (customAttributes != null) 'custom_attributes': customAttributes,
        },
      );

      return CustomerAddress.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to add customer address: $e');
    }
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
    try {
      final response = await _apiClient.authenticatedRequest(
        '/rest/V1/customers/me/addresses/$addressId',
        data: {
          if (firstName != null) 'firstname': firstName,
          if (lastName != null) 'lastname': lastName,
          if (street != null) 'street': street,
          if (city != null) 'city': city,
          if (region != null) 'region': region,
          if (postcode != null) 'postcode': postcode,
          if (countryId != null) 'country_id': countryId,
          if (telephone != null) 'telephone': telephone,
          if (middleName != null) 'middlename': middleName,
          if (prefix != null) 'prefix': prefix,
          if (suffix != null) 'suffix': suffix,
          if (company != null) 'company': company,
          if (regionId != null) 'region_id': regionId,
          if (regionCode != null) 'region_code': regionCode,
          if (fax != null) 'fax': fax,
          if (isDefaultShipping != null) 'default_shipping': isDefaultShipping,
          if (isDefaultBilling != null) 'default_billing': isDefaultBilling,
          if (customAttributes != null) 'custom_attributes': customAttributes,
        },
      );

      return CustomerAddress.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update customer address: $e');
    }
  }

  /// Delete customer address
  Future<bool> deleteCustomerAddress(int addressId) async {
    try {
      await _apiClient.authenticatedRequest(
        '/rest/V1/customers/me/addresses/$addressId',
        options: Options(method: 'DELETE'),
      );

      return true;
    } catch (e) {
      throw Exception('Failed to delete customer address: $e');
    }
  }

  /// Get customer groups
  Future<List<CustomerGroup>> getCustomerGroups() async {
    try {
      final response = await _apiClient.authenticatedRequest(
        '/rest/V1/customerGroups/search',
      );

      return (response.data['items'] as List)
          .map((json) => CustomerGroup.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to get customer groups: $e');
    }
  }

  /// Get customer attributes
  Future<List<CustomerAttribute>> getCustomerAttributes() async {
    try {
      final response = await _apiClient.authenticatedRequest(
        '/rest/V1/attributes/customer',
      );

      return (response.data as List)
          .map((json) => CustomerAttribute.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to get customer attributes: $e');
    }
  }

  /// Update customer attribute value
  Future<bool> updateCustomerAttributeValue({
    required String attributeCode,
    required dynamic value,
  }) async {
    try {
      await _apiClient.authenticatedRequest(
        '/rest/V1/customers/me/attributes/$attributeCode',
        data: {'value': value},
      );

      return true;
    } catch (e) {
      throw Exception('Failed to update customer attribute: $e');
    }
  }

  /// Get customer preferences
  Future<CustomerPreferences> getCustomerPreferences() async {
    try {
      final response = await _apiClient.authenticatedRequest(
        '/rest/V1/customers/me/preferences',
      );

      return CustomerPreferences.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to get customer preferences: $e');
    }
  }

  /// Update customer preferences
  Future<CustomerPreferences> updateCustomerPreferences({
    String? language,
    String? currency,
    String? timezone,
    bool? newsletterSubscription,
    Map<String, dynamic>? additionalPreferences,
  }) async {
    try {
      final response = await _apiClient.authenticatedRequest(
        '/rest/V1/customers/me/preferences',
        data: {
          if (language != null) 'language': language,
          if (currency != null) 'currency': currency,
          if (timezone != null) 'timezone': timezone,
          if (newsletterSubscription != null) 'newsletter_subscription': newsletterSubscription,
          if (additionalPreferences != null) 'additional_preferences': additionalPreferences,
        },
      );

      return CustomerPreferences.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update customer preferences: $e');
    }
  }

  /// Get customer activity
  Future<List<CustomerActivity>> getCustomerActivity({
    int page = 1,
    int pageSize = 20,
    String? activityType,
  }) async {
    try {
      final response = await _apiClient.authenticatedRequest(
        '/rest/V1/customers/me/activity',
        queryParameters: {
          'page': page,
          'page_size': pageSize,
          if (activityType != null) 'activity_type': activityType,
        },
      );

      return (response.data['items'] as List)
          .map((json) => CustomerActivity.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to get customer activity: $e');
    }
  }

  /// Get customer statistics
  Future<CustomerStatistics> getCustomerStatistics() async {
    try {
      final response = await _apiClient.authenticatedRequest(
        '/rest/V1/customers/me/statistics',
      );

      return CustomerStatistics.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to get customer statistics: $e');
    }
  }
}
