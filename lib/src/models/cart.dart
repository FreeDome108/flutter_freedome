import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart.freezed.dart';
part 'cart.g.dart';

@freezed
class Cart with _$Cart {
  const factory Cart({
    required String id,
    required int customerId,
    required List<CartItem> items,
    required double subtotal,
    required double grandTotal,
    double? shippingAmount,
    double? taxAmount,
    double? discountAmount,
    String? couponCode,
    List<CartDiscount>? discounts,
    CartTotals? totals,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Cart;

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
}

@freezed
class CartItem with _$CartItem {
  const factory CartItem({
    required int id,
    required String sku,
    required String name,
    required double price,
    required int quantity,
    double? rowTotal,
    String? image,
    List<CartItemOption>? options,
    Map<String, dynamic>? customAttributes,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);
}

@freezed
class CartItemOption with _$CartItemOption {
  const factory CartItemOption({
    required String code,
    required String label,
    required String value,
    double? price,
    String? priceType,
  }) = _CartItemOption;

  factory CartItemOption.fromJson(Map<String, dynamic> json) => _$CartItemOptionFromJson(json);
}

@freezed
class CartDiscount with _$CartDiscount {
  const factory CartDiscount({
    required String code,
    required String label,
    required double amount,
    String? type,
  }) = _CartDiscount;

  factory CartDiscount.fromJson(Map<String, dynamic> json) => _$CartDiscountFromJson(json);
}

@freezed
class CartTotals with _$CartTotals {
  const factory CartTotals({
    required double subtotal,
    required double grandTotal,
    double? shippingAmount,
    double? taxAmount,
    double? discountAmount,
    double? subtotalInclTax,
    double? shippingInclTax,
    Map<String, double>? taxBreakdown,
  }) = _CartTotals;

  factory CartTotals.fromJson(Map<String, dynamic> json) => _$CartTotalsFromJson(json);
}
