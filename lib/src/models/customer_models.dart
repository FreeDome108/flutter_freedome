import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_models.freezed.dart';
part 'customer_models.g.dart';

/// Customer address model
@freezed
class CustomerAddress with _$CustomerAddress {
  const factory CustomerAddress({
    required int id,
    String? customerId,
    String? customerAddressId,
    String? email,
    String? firstName,
    String? lastName,
    String? middleName,
    String? prefix,
    String? suffix,
    String? company,
    List<String>? street,
    String? city,
    String? region,
    String? regionId,
    String? regionCode,
    String? postcode,
    String? countryId,
    String? telephone,
    String? fax,
    bool? isDefaultShipping,
    bool? isDefaultBilling,
    Map<String, dynamic>? customAttributes,
    Map<String, dynamic>? extensionAttributes,
  }) = _CustomerAddress;

  factory CustomerAddress.fromJson(Map<String, dynamic> json) =>
      _$CustomerAddressFromJson(json);
}

/// Customer group model
@freezed
class CustomerGroup with _$CustomerGroup {
  const factory CustomerGroup({
    required int id,
    required String code,
    required String taxClassName,
    Map<String, dynamic>? extensionAttributes,
  }) = _CustomerGroup;

  factory CustomerGroup.fromJson(Map<String, dynamic> json) =>
      _$CustomerGroupFromJson(json);
}

/// Customer attribute model
@freezed
class CustomerAttribute with _$CustomerAttribute {
  const factory CustomerAttribute({
    required String attributeCode,
    required String frontendInput,
    required String frontendLabel,
    required bool isRequired,
    required bool isUserDefined,
    required bool isVisible,
    required bool isSystem,
    required int sortOrder,
    String? defaultValue,
    List<CustomerAttributeOption>? options,
    Map<String, dynamic>? validationRules,
    Map<String, dynamic>? extensionAttributes,
  }) = _CustomerAttribute;

  factory CustomerAttribute.fromJson(Map<String, dynamic> json) =>
      _$CustomerAttributeFromJson(json);
}

/// Customer attribute option model
@freezed
class CustomerAttributeOption with _$CustomerAttributeOption {
  const factory CustomerAttributeOption({
    required String value,
    required String label,
    Map<String, dynamic>? extensionAttributes,
  }) = _CustomerAttributeOption;

  factory CustomerAttributeOption.fromJson(Map<String, dynamic> json) =>
      _$CustomerAttributeOptionFromJson(json);
}

/// Customer preferences model
@freezed
class CustomerPreferences with _$CustomerPreferences {
  const factory CustomerPreferences({
    String? language,
    String? currency,
    String? timezone,
    bool? newsletterSubscription,
    Map<String, dynamic>? additionalPreferences,
    Map<String, dynamic>? extensionAttributes,
  }) = _CustomerPreferences;

  factory CustomerPreferences.fromJson(Map<String, dynamic> json) =>
      _$CustomerPreferencesFromJson(json);
}

/// Customer activity model
@freezed
class CustomerActivity with _$CustomerActivity {
  const factory CustomerActivity({
    required String id,
    required String type,
    required String description,
    required DateTime timestamp,
    Map<String, dynamic>? metadata,
    Map<String, dynamic>? extensionAttributes,
  }) = _CustomerActivity;

  factory CustomerActivity.fromJson(Map<String, dynamic> json) =>
      _$CustomerActivityFromJson(json);
}

/// Customer statistics model
@freezed
class CustomerStatistics with _$CustomerStatistics {
  const factory CustomerStatistics({
    required int totalOrders,
    required double totalSpent,
    required int totalProductsPurchased,
    required DateTime firstOrderDate,
    DateTime? lastOrderDate,
    required double averageOrderValue,
    required int wishlistItems,
    required int cartItems,
    Map<String, dynamic>? extensionAttributes,
  }) = _CustomerStatistics;

  factory CustomerStatistics.fromJson(Map<String, dynamic> json) =>
      _$CustomerStatisticsFromJson(json);
}

/// Customer notification preferences model
@freezed
class CustomerNotificationPreferences with _$CustomerNotificationPreferences {
  const factory CustomerNotificationPreferences({
    required bool emailNotifications,
    required bool smsNotifications,
    required bool pushNotifications,
    required bool orderUpdates,
    required bool promotionalOffers,
    required bool productRecommendations,
    required bool priceAlerts,
    Map<String, dynamic>? extensionAttributes,
  }) = _CustomerNotificationPreferences;

  factory CustomerNotificationPreferences.fromJson(Map<String, dynamic> json) =>
      _$CustomerNotificationPreferencesFromJson(json);
}

/// Customer loyalty points model
@freezed
class CustomerLoyaltyPoints with _$CustomerLoyaltyPoints {
  const factory CustomerLoyaltyPoints({
    required int currentPoints,
    required int totalEarned,
    required int totalRedeemed,
    required int pointsToExpire,
    DateTime? expirationDate,
    Map<String, dynamic>? extensionAttributes,
  }) = _CustomerLoyaltyPoints;

  factory CustomerLoyaltyPoints.fromJson(Map<String, dynamic> json) =>
      _$CustomerLoyaltyPointsFromJson(json);
}

/// Customer subscription model
@freezed
class CustomerSubscription with _$CustomerSubscription {
  const factory CustomerSubscription({
    required String id,
    required String status,
    required String type,
    required DateTime startDate,
    DateTime? endDate,
    required double amount,
    required String currency,
    String? frequency,
    Map<String, dynamic>? extensionAttributes,
  }) = _CustomerSubscription;

  factory CustomerSubscription.fromJson(Map<String, dynamic> json) =>
      _$CustomerSubscriptionFromJson(json);
}

/// Customer review model
@freezed
class CustomerReview with _$CustomerReview {
  const factory CustomerReview({
    required String id,
    required String productId,
    required String productName,
    required String title,
    required String detail,
    required int rating,
    required DateTime createdAt,
    DateTime? updatedAt,
    String? status,
    Map<String, dynamic>? extensionAttributes,
  }) = _CustomerReview;

  factory CustomerReview.fromJson(Map<String, dynamic> json) =>
      _$CustomerReviewFromJson(json);
}
