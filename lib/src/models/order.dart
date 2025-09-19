import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';
part 'order.g.dart';

@freezed
class Order with _$Order {
  const factory Order({
    required int id,
    required String incrementId,
    required String status,
    required String state,
    required double grandTotal,
    required double subtotal,
    required double shippingAmount,
    required double taxAmount,
    required double discountAmount,
    required List<OrderItem> items,
    required OrderAddress billingAddress,
    required OrderAddress shippingAddress,
    required OrderPayment payment,
    OrderShipping? shipping,
    List<OrderComment>? comments,
    String? customerEmail,
    String? customerFirstname,
    String? customerLastname,
    String? couponCode,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}

@freezed
class OrderItem with _$OrderItem {
  const factory OrderItem({
    required int id,
    required String sku,
    required String name,
    required double price,
    required int quantity,
    double? rowTotal,
    String? image,
    List<OrderItemOption>? options,
    Map<String, dynamic>? customAttributes,
  }) = _OrderItem;

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);
}

@freezed
class OrderItemOption with _$OrderItemOption {
  const factory OrderItemOption({
    required String code,
    required String label,
    required String value,
    double? price,
    String? priceType,
  }) = _OrderItemOption;

  factory OrderItemOption.fromJson(Map<String, dynamic> json) => _$OrderItemOptionFromJson(json);
}

@freezed
class OrderAddress with _$OrderAddress {
  const factory OrderAddress({
    required String firstname,
    required String lastname,
    String? middlename,
    String? prefix,
    String? suffix,
    String? company,
    required String street,
    required String city,
    required String region,
    required String postcode,
    required String countryId,
    String? telephone,
    String? fax,
    String? vatId,
  }) = _OrderAddress;

  factory OrderAddress.fromJson(Map<String, dynamic> json) => _$OrderAddressFromJson(json);
}

@freezed
class OrderPayment with _$OrderPayment {
  const factory OrderPayment({
    required String method,
    required String title,
    required double amount,
    String? transactionId,
    Map<String, dynamic>? additionalData,
  }) = _OrderPayment;

  factory OrderPayment.fromJson(Map<String, dynamic> json) => _$OrderPaymentFromJson(json);
}

@freezed
class OrderShipping with _$OrderShipping {
  const factory OrderShipping({
    required String method,
    required String title,
    required double amount,
    Map<String, dynamic>? additionalData,
  }) = _OrderShipping;

  factory OrderShipping.fromJson(Map<String, dynamic> json) => _$OrderShippingFromJson(json);
}

@freezed
class OrderComment with _$OrderComment {
  const factory OrderComment({
    required String comment,
    required DateTime createdAt,
    bool? isVisibleOnFront,
  }) = _OrderComment;

  factory OrderComment.fromJson(Map<String, dynamic> json) => _$OrderCommentFromJson(json);
}
