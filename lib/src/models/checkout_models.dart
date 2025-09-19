import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_models.freezed.dart';
part 'checkout_models.g.dart';

/// Checkout session model
@freezed
class CheckoutSession with _$CheckoutSession {
  const factory CheckoutSession({
    required String id,
    required String cartId,
    String? email,
    Map<String, dynamic>? shippingAddress,
    Map<String, dynamic>? billingAddress,
    String? shippingMethod,
    String? paymentMethod,
    Map<String, dynamic>? additionalData,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _CheckoutSession;

  factory CheckoutSession.fromJson(Map<String, dynamic> json) =>
      _$CheckoutSessionFromJson(json);
}

/// Shipping method model
@freezed
class ShippingMethod with _$ShippingMethod {
  const factory ShippingMethod({
    required String code,
    required String title,
    required double amount,
    required String currency,
    String? carrierCode,
    String? carrierTitle,
    String? methodCode,
    String? methodTitle,
    Map<String, dynamic>? extensionAttributes,
  }) = _ShippingMethod;

  factory ShippingMethod.fromJson(Map<String, dynamic> json) =>
      _$ShippingMethodFromJson(json);
}

/// Payment method model
@freezed
class PaymentMethod with _$PaymentMethod {
  const factory PaymentMethod({
    required String code,
    required String title,
    String? description,
    Map<String, dynamic>? config,
    Map<String, dynamic>? extensionAttributes,
  }) = _PaymentMethod;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodFromJson(json);
}

/// Checkout validation result model
@freezed
class CheckoutValidationResult with _$CheckoutValidationResult {
  const factory CheckoutValidationResult({
    required bool isValid,
    List<String>? errors,
    List<String>? warnings,
    Map<String, dynamic>? additionalData,
  }) = _CheckoutValidationResult;

  factory CheckoutValidationResult.fromJson(Map<String, dynamic> json) =>
      _$CheckoutValidationResultFromJson(json);
}

/// Checkout totals model
@freezed
class CheckoutTotals with _$CheckoutTotals {
  const factory CheckoutTotals({
    required double grandTotal,
    required double subtotal,
    required double subtotalInclTax,
    required double shippingAmount,
    required double shippingInclTax,
    required double taxAmount,
    required double discountAmount,
    required String currency,
    List<CheckoutTotalItem>? items,
    Map<String, dynamic>? extensionAttributes,
  }) = _CheckoutTotals;

  factory CheckoutTotals.fromJson(Map<String, dynamic> json) =>
      _$CheckoutTotalsFromJson(json);
}

/// Checkout total item model
@freezed
class CheckoutTotalItem with _$CheckoutTotalItem {
  const factory CheckoutTotalItem({
    required String code,
    required String title,
    required double value,
    required String currency,
    Map<String, dynamic>? extensionAttributes,
  }) = _CheckoutTotalItem;

  factory CheckoutTotalItem.fromJson(Map<String, dynamic> json) =>
      _$CheckoutTotalItemFromJson(json);
}

/// Guest checkout information model
@freezed
class GuestCheckoutInfo with _$GuestCheckoutInfo {
  const factory GuestCheckoutInfo({
    required String cartId,
    String? email,
    Map<String, dynamic>? shippingAddress,
    Map<String, dynamic>? billingAddress,
    List<ShippingMethod>? availableShippingMethods,
    List<PaymentMethod>? availablePaymentMethods,
    CheckoutTotals? totals,
    Map<String, dynamic>? extensionAttributes,
  }) = _GuestCheckoutInfo;

  factory GuestCheckoutInfo.fromJson(Map<String, dynamic> json) =>
      _$GuestCheckoutInfoFromJson(json);
}

/// Checkout address model
@freezed
class CheckoutAddress with _$CheckoutAddress {
  const factory CheckoutAddress({
    String? id,
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
    bool? sameAsBilling,
    bool? saveInAddressBook,
    Map<String, dynamic>? customAttributes,
    Map<String, dynamic>? extensionAttributes,
  }) = _CheckoutAddress;

  factory CheckoutAddress.fromJson(Map<String, dynamic> json) =>
      _$CheckoutAddressFromJson(json);
}

/// Checkout payment information model
@freezed
class CheckoutPaymentInfo with _$CheckoutPaymentInfo {
  const factory CheckoutPaymentInfo({
    required String method,
    Map<String, dynamic>? additionalData,
    Map<String, dynamic>? extensionAttributes,
  }) = _CheckoutPaymentInfo;

  factory CheckoutPaymentInfo.fromJson(Map<String, dynamic> json) =>
      _$CheckoutPaymentInfoFromJson(json);
}

/// Checkout shipping information model
@freezed
class CheckoutShippingInfo with _$CheckoutShippingInfo {
  const factory CheckoutShippingInfo({
    required String method,
    CheckoutAddress? address,
    Map<String, dynamic>? extensionAttributes,
  }) = _CheckoutShippingInfo;

  factory CheckoutShippingInfo.fromJson(Map<String, dynamic> json) =>
      _$CheckoutShippingInfoFromJson(json);
}
