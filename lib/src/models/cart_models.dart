import 'package:json_annotation/json_annotation.dart';

part 'cart_models.g.dart';

/// Cart model representing a shopping cart
@JsonSerializable()
class Cart {
  final String? id;
  final int? customerId;
  final String? customerEmail;
  final List<CartItem>? items;
  final CartTotals? totals;
  final List<CartCoupon>? appliedCoupons;
  final List<CartGiftCard>? appliedGiftCards;
  final String? currencyCode;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Cart({
    this.id,
    this.customerId,
    this.customerEmail,
    this.items,
    this.totals,
    this.appliedCoupons,
    this.appliedGiftCards,
    this.currencyCode,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
  Map<String, dynamic> toJson() => _$CartToJson(this);
}

/// Cart item model
@JsonSerializable()
class CartItem {
  final int? itemId;
  final String? sku;
  final String? name;
  final int? qty;
  final double? price;
  final double? rowTotal;
  final double? taxAmount;
  final double? discountAmount;
  final String? productType;
  final Map<String, dynamic>? productOptions;
  final List<CartItemOption>? options;
  final bool? isVirtual;
  final String? imageUrl;
  final String? thumbnailUrl;

  CartItem({
    this.itemId,
    this.sku,
    this.name,
    this.qty,
    this.price,
    this.rowTotal,
    this.taxAmount,
    this.discountAmount,
    this.productType,
    this.productOptions,
    this.options,
    this.isVirtual,
    this.imageUrl,
    this.thumbnailUrl,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}

/// Cart item option model
@JsonSerializable()
class CartItemOption {
  final String? optionId;
  final String? optionValue;
  final String? optionLabel;
  final String? optionCode;

  CartItemOption({
    this.optionId,
    this.optionValue,
    this.optionLabel,
    this.optionCode,
  });

  factory CartItemOption.fromJson(Map<String, dynamic> json) => _$CartItemOptionFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemOptionToJson(this);
}

/// Cart totals model
@JsonSerializable()
class CartTotals {
  final double? grandTotal;
  final double? subtotal;
  final double? subtotalInclTax;
  final double? taxAmount;
  final double? discountAmount;
  final double? shippingAmount;
  final double? shippingInclTax;
  final List<CartTotalSegment>? totalSegments;
  final String? currencyCode;

  CartTotals({
    this.grandTotal,
    this.subtotal,
    this.subtotalInclTax,
    this.taxAmount,
    this.discountAmount,
    this.shippingAmount,
    this.shippingInclTax,
    this.totalSegments,
    this.currencyCode,
  });

  factory CartTotals.fromJson(Map<String, dynamic> json) => _$CartTotalsFromJson(json);
  Map<String, dynamic> toJson() => _$CartTotalsToJson(this);
}

/// Cart total segment model
@JsonSerializable()
class CartTotalSegment {
  final String? code;
  final String? title;
  final double? value;
  final String? area;

  CartTotalSegment({
    this.code,
    this.title,
    this.value,
    this.area,
  });

  factory CartTotalSegment.fromJson(Map<String, dynamic> json) => _$CartTotalSegmentFromJson(json);
  Map<String, dynamic> toJson() => _$CartTotalSegmentToJson(this);
}

/// Cart coupon model
@JsonSerializable()
class CartCoupon {
  final String? code;
  final String? description;
  final double? amount;
  final String? type;

  CartCoupon({
    this.code,
    this.description,
    this.amount,
    this.type,
  });

  factory CartCoupon.fromJson(Map<String, dynamic> json) => _$CartCouponFromJson(json);
  Map<String, dynamic> toJson() => _$CartCouponToJson(this);
}

/// Cart gift card model
@JsonSerializable()
class CartGiftCard {
  final String? code;
  final double? amount;
  final String? currencyCode;

  CartGiftCard({
    this.code,
    this.amount,
    this.currencyCode,
  });

  factory CartGiftCard.fromJson(Map<String, dynamic> json) => _$CartGiftCardFromJson(json);
  Map<String, dynamic> toJson() => _$CartGiftCardToJson(this);
}

/// Address model for shipping and billing
@JsonSerializable()
class Address {
  final int? id;
  final String? customerId;
  final String? regionId;
  final String? regionCode;
  final String? region;
  final String? countryId;
  final List<String>? street;
  final String? company;
  final String? telephone;
  final String? fax;
  final String? postcode;
  final String? city;
  final String? firstname;
  final String? lastname;
  final String? middlename;
  final String? prefix;
  final String? suffix;
  final String? vatId;
  final bool? isDefaultShipping;
  final bool? isDefaultBilling;

  Address({
    this.id,
    this.customerId,
    this.regionId,
    this.regionCode,
    this.region,
    this.countryId,
    this.street,
    this.company,
    this.telephone,
    this.fax,
    this.postcode,
    this.city,
    this.firstname,
    this.lastname,
    this.middlename,
    this.prefix,
    this.suffix,
    this.vatId,
    this.isDefaultShipping,
    this.isDefaultBilling,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

/// Shipping method model
@JsonSerializable()
class ShippingMethod {
  final String? methodCode;
  final String? carrierCode;
  final String? methodTitle;
  final String? carrierTitle;
  final double? amount;
  final String? currencyCode;
  final bool? available;
  final String? errorMessage;
  final double? priceExclTax;
  final double? priceInclTax;

  ShippingMethod({
    this.methodCode,
    this.carrierCode,
    this.methodTitle,
    this.carrierTitle,
    this.amount,
    this.currencyCode,
    this.available,
    this.errorMessage,
    this.priceExclTax,
    this.priceInclTax,
  });

  factory ShippingMethod.fromJson(Map<String, dynamic> json) => _$ShippingMethodFromJson(json);
  Map<String, dynamic> toJson() => _$ShippingMethodToJson(this);
}

/// Cart creation request model
@JsonSerializable()
class CartCreateRequest {
  final int? customerId;
  final String? customerEmail;
  final String? storeId;

  CartCreateRequest({
    this.customerId,
    this.customerEmail,
    this.storeId,
  });

  factory CartCreateRequest.fromJson(Map<String, dynamic> json) => _$CartCreateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CartCreateRequestToJson(this);
}

/// Cart item request model
@JsonSerializable()
class CartItemRequest {
  final String? sku;
  final int? qty;
  final String? quoteId;
  final Map<String, dynamic>? productOptions;

  CartItemRequest({
    this.sku,
    this.qty,
    this.quoteId,
    this.productOptions,
  });

  factory CartItemRequest.fromJson(Map<String, dynamic> json) => _$CartItemRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemRequestToJson(this);
}

/// Cart item update request model
@JsonSerializable()
class CartItemUpdateRequest {
  final int? qty;
  final String? quoteId;
  final Map<String, dynamic>? productOptions;

  CartItemUpdateRequest({
    this.qty,
    this.quoteId,
    this.productOptions,
  });

  factory CartItemUpdateRequest.fromJson(Map<String, dynamic> json) => _$CartItemUpdateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemUpdateRequestToJson(this);
}

/// Shipping information request model
@JsonSerializable()
class ShippingInformationRequest {
  final Address? shippingAddress;
  final Address? billingAddress;
  final String? shippingMethodCode;
  final String? shippingCarrierCode;
  final String? customAttributes;

  ShippingInformationRequest({
    this.shippingAddress,
    this.billingAddress,
    this.shippingMethodCode,
    this.shippingCarrierCode,
    this.customAttributes,
  });

  factory ShippingInformationRequest.fromJson(Map<String, dynamic> json) => _$ShippingInformationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ShippingInformationRequestToJson(this);
}

/// Payment method model
@JsonSerializable()
class PaymentMethod {
  final String? code;
  final String? title;
  final bool? available;
  final String? errorMessage;
  final Map<String, dynamic>? additionalData;

  PaymentMethod({
    this.code,
    this.title,
    this.available,
    this.errorMessage,
    this.additionalData,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => _$PaymentMethodFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentMethodToJson(this);
}

/// Cart validation result model
@JsonSerializable()
class CartValidationResult {
  final bool? isValid;
  final List<String>? errors;
  final List<String>? warnings;
  final Map<String, dynamic>? additionalData;

  CartValidationResult({
    this.isValid,
    this.errors,
    this.warnings,
    this.additionalData,
  });

  factory CartValidationResult.fromJson(Map<String, dynamic> json) => _$CartValidationResultFromJson(json);
  Map<String, dynamic> toJson() => _$CartValidationResultToJson(this);
}
