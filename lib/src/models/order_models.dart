import 'package:json_annotation/json_annotation.dart';

part 'order_models.g.dart';

/// Order list response model
@JsonSerializable()
class OrderListResponse {
  final List<Order>? items;
  final int? totalCount;
  final int? currentPage;
  final int? pageSize;

  OrderListResponse({
    this.items,
    this.totalCount,
    this.currentPage,
    this.pageSize,
  });

  factory OrderListResponse.fromJson(Map<String, dynamic> json) => _$OrderListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderListResponseToJson(this);
}

/// Order model
@JsonSerializable()
class Order {
  final String? id;
  final String? incrementId;
  final String? status;
  final String? state;
  final int? customerId;
  final String? customerEmail;
  final String? customerFirstName;
  final String? customerLastName;
  final List<OrderItem>? items;
  final OrderTotals? totals;
  final String? currencyCode;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Order({
    this.id,
    this.incrementId,
    this.status,
    this.state,
    this.customerId,
    this.customerEmail,
    this.customerFirstName,
    this.customerLastName,
    this.items,
    this.totals,
    this.currencyCode,
    this.createdAt,
    this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

/// Order item model
@JsonSerializable()
class OrderItem {
  final int? itemId;
  final String? sku;
  final String? name;
  final int? qty;
  final double? price;
  final double? rowTotal;
  final String? productType;

  OrderItem({
    this.itemId,
    this.sku,
    this.name,
    this.qty,
    this.price,
    this.rowTotal,
    this.productType,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}

/// Order totals model
@JsonSerializable()
class OrderTotals {
  final double? grandTotal;
  final double? subtotal;
  final double? taxAmount;
  final double? shippingAmount;
  final double? discountAmount;

  OrderTotals({
    this.grandTotal,
    this.subtotal,
    this.taxAmount,
    this.shippingAmount,
    this.discountAmount,
  });

  factory OrderTotals.fromJson(Map<String, dynamic> json) => _$OrderTotalsFromJson(json);
  Map<String, dynamic> toJson() => _$OrderTotalsToJson(this);
}

/// Order comment model
@JsonSerializable()
class OrderComment {
  final String? id;
  final String? comment;
  final bool? isVisibleOnFront;
  final DateTime? createdAt;

  OrderComment({
    this.id,
    this.comment,
    this.isVisibleOnFront,
    this.createdAt,
  });

  factory OrderComment.fromJson(Map<String, dynamic> json) => _$OrderCommentFromJson(json);
  Map<String, dynamic> toJson() => _$OrderCommentToJson(this);
}

/// Order history model
@JsonSerializable()
class OrderHistory {
  final String? id;
  final String? status;
  final String? comment;
  final DateTime? createdAt;

  OrderHistory({
    this.id,
    this.status,
    this.comment,
    this.createdAt,
  });

  factory OrderHistory.fromJson(Map<String, dynamic> json) => _$OrderHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$OrderHistoryToJson(this);
}

/// Invoice model
@JsonSerializable()
class Invoice {
  final String? id;
  final String? incrementId;
  final String? orderId;
  final String? status;
  final double? grandTotal;
  final DateTime? createdAt;

  Invoice({
    this.id,
    this.incrementId,
    this.orderId,
    this.status,
    this.grandTotal,
    this.createdAt,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) => _$InvoiceFromJson(json);
  Map<String, dynamic> toJson() => _$InvoiceToJson(this);
}

/// Shipment model
@JsonSerializable()
class Shipment {
  final String? id;
  final String? incrementId;
  final String? orderId;
  final String? status;
  final List<ShipmentItem>? items;
  final List<ShipmentTracking>? tracks;
  final DateTime? createdAt;

  Shipment({
    this.id,
    this.incrementId,
    this.orderId,
    this.status,
    this.items,
    this.tracks,
    this.createdAt,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) => _$ShipmentFromJson(json);
  Map<String, dynamic> toJson() => _$ShipmentToJson(this);
}

/// Shipment item model
@JsonSerializable()
class ShipmentItem {
  final int? itemId;
  final String? sku;
  final String? name;
  final int? qty;

  ShipmentItem({
    this.itemId,
    this.sku,
    this.name,
    this.qty,
  });

  factory ShipmentItem.fromJson(Map<String, dynamic> json) => _$ShipmentItemFromJson(json);
  Map<String, dynamic> toJson() => _$ShipmentItemToJson(this);
}

/// Shipment tracking model
@JsonSerializable()
class ShipmentTracking {
  final String? id;
  final String? trackNumber;
  final String? title;
  final String? carrierCode;

  ShipmentTracking({
    this.id,
    this.trackNumber,
    this.title,
    this.carrierCode,
  });

  factory ShipmentTracking.fromJson(Map<String, dynamic> json) => _$ShipmentTrackingFromJson(json);
  Map<String, dynamic> toJson() => _$ShipmentTrackingToJson(this);
}

/// Credit memo model
@JsonSerializable()
class CreditMemo {
  final String? id;
  final String? incrementId;
  final String? orderId;
  final String? status;
  final double? grandTotal;
  final DateTime? createdAt;

  CreditMemo({
    this.id,
    this.incrementId,
    this.orderId,
    this.status,
    this.grandTotal,
    this.createdAt,
  });

  factory CreditMemo.fromJson(Map<String, dynamic> json) => _$CreditMemoFromJson(json);
  Map<String, dynamic> toJson() => _$CreditMemoToJson(this);
}

/// Return model
@JsonSerializable()
class Return {
  final String? id;
  final String? orderId;
  final String? status;
  final List<ReturnItem>? items;
  final String? comment;
  final DateTime? createdAt;

  Return({
    this.id,
    this.orderId,
    this.status,
    this.items,
    this.comment,
    this.createdAt,
  });

  factory Return.fromJson(Map<String, dynamic> json) => _$ReturnFromJson(json);
  Map<String, dynamic> toJson() => _$ReturnToJson(this);
}

/// Return item model
@JsonSerializable()
class ReturnItem {
  final int? itemId;
  final String? sku;
  final String? name;
  final int? qty;
  final String? reason;

  ReturnItem({
    this.itemId,
    this.sku,
    this.name,
    this.qty,
    this.reason,
  });

  factory ReturnItem.fromJson(Map<String, dynamic> json) => _$ReturnItemFromJson(json);
  Map<String, dynamic> toJson() => _$ReturnItemToJson(this);
}
