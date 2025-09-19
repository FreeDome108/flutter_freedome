import 'package:json_annotation/json_annotation.dart';
import 'product_models.dart';

part 'wishlist_models.g.dart';

/// Wishlist model
@JsonSerializable()
class Wishlist {
  final String? id;
  final String? name;
  final int? customerId;
  final List<WishlistItem>? items;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isDefault;

  Wishlist({
    this.id,
    this.name,
    this.customerId,
    this.items,
    this.createdAt,
    this.updatedAt,
    this.isDefault,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) => _$WishlistFromJson(json);
  Map<String, dynamic> toJson() => _$WishlistToJson(this);
}

/// Wishlist item model
@JsonSerializable()
class WishlistItem {
  final int? id;
  final int? wishlistId;
  final int? productId;
  final String? sku;
  final String? name;
  final String? description;
  final double? price;
  final String? imageUrl;
  final List<Map<String, dynamic>>? options;
  final DateTime? addedAt;

  WishlistItem({
    this.id,
    this.wishlistId,
    this.productId,
    this.sku,
    this.name,
    this.description,
    this.price,
    this.imageUrl,
    this.options,
    this.addedAt,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) => _$WishlistItemFromJson(json);
  Map<String, dynamic> toJson() => _$WishlistItemToJson(this);
}

/// Wishlist analytics model
@JsonSerializable()
class WishlistAnalytics {
  final int totalItems;
  final int totalWishlists;
  final List<Product> mostWishedProducts;
  final double wishlistGrowth;

  WishlistAnalytics({
    required this.totalItems,
    required this.totalWishlists,
    required this.mostWishedProducts,
    required this.wishlistGrowth,
  });

  factory WishlistAnalytics.fromJson(Map<String, dynamic> json) => _$WishlistAnalyticsFromJson(json);
  Map<String, dynamic> toJson() => _$WishlistAnalyticsToJson(this);
}

/// Wishlist trend model
@JsonSerializable()
class WishlistTrend {
  final String period;
  final int itemCount;
  final double growthRate;

  WishlistTrend({
    required this.period,
    required this.itemCount,
    required this.growthRate,
  });

  factory WishlistTrend.fromJson(Map<String, dynamic> json) => _$WishlistTrendFromJson(json);
  Map<String, dynamic> toJson() => _$WishlistTrendToJson(this);
}

/// Wishlist creation request model
@JsonSerializable()
class WishlistCreateRequest {
  final String name;
  final String? description;

  WishlistCreateRequest({
    required this.name,
    this.description,
  });

  factory WishlistCreateRequest.fromJson(Map<String, dynamic> json) => _$WishlistCreateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$WishlistCreateRequestToJson(this);
}

/// Wishlist update request model
@JsonSerializable()
class WishlistUpdateRequest {
  final String? name;
  final String? description;

  WishlistUpdateRequest({
    this.name,
    this.description,
  });

  factory WishlistUpdateRequest.fromJson(Map<String, dynamic> json) => _$WishlistUpdateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$WishlistUpdateRequestToJson(this);
}

/// Wishlist item update request model
@JsonSerializable()
class WishlistItemUpdateRequest {
  final String? description;
  final List<Map<String, dynamic>>? options;

  WishlistItemUpdateRequest({
    this.description,
    this.options,
  });

  factory WishlistItemUpdateRequest.fromJson(Map<String, dynamic> json) => _$WishlistItemUpdateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$WishlistItemUpdateRequestToJson(this);
}

/// Wishlist sharing model
@JsonSerializable()
class WishlistSharing {
  final String wishlistId;
  final String email;
  final String? message;
  final DateTime? sharedAt;

  WishlistSharing({
    required this.wishlistId,
    required this.email,
    this.message,
    this.sharedAt,
  });

  factory WishlistSharing.fromJson(Map<String, dynamic> json) => _$WishlistSharingFromJson(json);
  Map<String, dynamic> toJson() => _$WishlistSharingToJson(this);
}

/// Shared wishlist access model
@JsonSerializable()
class SharedWishlistAccess {
  final String shareCode;
  final String wishlistId;
  final DateTime? expiresAt;
  final bool? isActive;

  SharedWishlistAccess({
    required this.shareCode,
    required this.wishlistId,
    this.expiresAt,
    this.isActive,
  });

  factory SharedWishlistAccess.fromJson(Map<String, dynamic> json) => _$SharedWishlistAccessFromJson(json);
  Map<String, dynamic> toJson() => _$SharedWishlistAccessToJson(this);
}
