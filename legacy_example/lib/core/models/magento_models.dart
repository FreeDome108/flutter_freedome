import 'package:json_annotation/json_annotation.dart';

part 'magento_models.g.dart';

/// Magento Customer Model
@JsonSerializable()
class MagentoCustomer {
  final int id;
  final String email;
  final String firstname;
  final String lastname;
  final String? middlename;
  final String? prefix;
  final String? suffix;
  final DateTime? dob;
  final int? gender;
  final int storeId;
  final int websiteId;
  final List<MagentoAddress> addresses;
  final int? disableAutoGroupChange;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? taxvat;
  final Map<String, dynamic> customAttributes;

  const MagentoCustomer({
    required this.id,
    required this.email,
    required this.firstname,
    required this.lastname,
    this.middlename,
    this.prefix,
    this.suffix,
    this.dob,
    this.gender,
    required this.storeId,
    required this.websiteId,
    required this.addresses,
    this.disableAutoGroupChange,
    required this.createdAt,
    required this.updatedAt,
    this.taxvat,
    required this.customAttributes,
  });

  factory MagentoCustomer.fromJson(Map<String, dynamic> json) => _$MagentoCustomerFromJson(json);
  Map<String, dynamic> toJson() => _$MagentoCustomerToJson(this);

  String get fullName => '$firstname $lastname';
}

/// Magento Address Model
@JsonSerializable()
class MagentoAddress {
  final int? id;
  final int? customerId;
  final MagentoRegion? region;
  final String? regionId;
  final String countryId;
  final List<String> street;
  final String? company;
  final String? telephone;
  final String? fax;
  final String postcode;
  final String city;
  final String firstname;
  final String lastname;
  final String? middlename;
  final String? prefix;
  final String? suffix;
  final String? vatId;
  final bool? defaultShipping;
  final bool? defaultBilling;

  const MagentoAddress({
    this.id,
    this.customerId,
    this.region,
    this.regionId,
    required this.countryId,
    required this.street,
    this.company,
    this.telephone,
    this.fax,
    required this.postcode,
    required this.city,
    required this.firstname,
    required this.lastname,
    this.middlename,
    this.prefix,
    this.suffix,
    this.vatId,
    this.defaultShipping,
    this.defaultBilling,
  });

  factory MagentoAddress.fromJson(Map<String, dynamic> json) => _$MagentoAddressFromJson(json);
  Map<String, dynamic> toJson() => _$MagentoAddressToJson(this);

  String get fullAddress => '${street.join(', ')}, $city, ${region?.region ?? ''} $postcode, $countryId';
}

/// Magento Region Model
@JsonSerializable()
class MagentoRegion {
  final String? regionCode;
  final String? region;
  final int? regionId;

  const MagentoRegion({
    this.regionCode,
    this.region,
    this.regionId,
  });

  factory MagentoRegion.fromJson(Map<String, dynamic> json) => _$MagentoRegionFromJson(json);
  Map<String, dynamic> toJson() => _$MagentoRegionToJson(this);
}

/// Magento Product Model
@JsonSerializable()
class MagentoProduct {
  final int id;
  final String sku;
  final String name;
  final int attributeSetId;
  final double price;
  final int status;
  final int visibility;
  final String typeId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double? weight;
  final List<MagentoProductExtension> extensionAttributes;
  final List<MagentoProductLink> productLinks;
  final List<MagentoMediaGalleryEntry> mediaGalleryEntries;
  final List<MagentoCustomAttribute> customAttributes;

  const MagentoProduct({
    required this.id,
    required this.sku,
    required this.name,
    required this.attributeSetId,
    required this.price,
    required this.status,
    required this.visibility,
    required this.typeId,
    required this.createdAt,
    required this.updatedAt,
    this.weight,
    required this.extensionAttributes,
    required this.productLinks,
    required this.mediaGalleryEntries,
    required this.customAttributes,
  });

  factory MagentoProduct.fromJson(Map<String, dynamic> json) => _$MagentoProductFromJson(json);
  Map<String, dynamic> toJson() => _$MagentoProductToJson(this);
}

/// Magento Product List Model
@JsonSerializable()
class MagentoProductList {
  final List<MagentoProduct> items;
  final MagentoSearchCriteria searchCriteria;
  final int totalCount;

  const MagentoProductList({
    required this.items,
    required this.searchCriteria,
    required this.totalCount,
  });

  factory MagentoProductList.fromJson(Map<String, dynamic> json) => _$MagentoProductListFromJson(json);
  Map<String, dynamic> toJson() => _$MagentoProductListToJson(this);
}

/// Magento Search Criteria Model
@JsonSerializable()
class MagentoSearchCriteria {
  final List<MagentoFilterGroup> filterGroups;
  final List<MagentoSortOrder>? sortOrders;
  final int? pageSize;
  final int? currentPage;

  const MagentoSearchCriteria({
    required this.filterGroups,
    this.sortOrders,
    this.pageSize,
    this.currentPage,
  });

  factory MagentoSearchCriteria.fromJson(Map<String, dynamic> json) => _$MagentoSearchCriteriaFromJson(json);
  Map<String, dynamic> toJson() => _$MagentoSearchCriteriaToJson(this);
}

/// Magento Filter Group Model
@JsonSerializable()
class MagentoFilterGroup {
  final List<MagentoFilter> filters;

  const MagentoFilterGroup({
    required this.filters,
  });

  factory MagentoFilterGroup.fromJson(Map<String, dynamic> json) => _$MagentoFilterGroupFromJson(json);
  Map<String, dynamic> toJson() => _$MagentoFilterGroupToJson(this);
}

/// Magento Filter Model
@JsonSerializable()
class MagentoFilter {
  final String field;
  final String value;
  final String? conditionType;

  const MagentoFilter({
    required this.field,
    required this.value,
    this.conditionType,
  });

  factory MagentoFilter.fromJson(Map<String, dynamic> json) => _$MagentoFilterFromJson(json);
  Map<String, dynamic> toJson() => _$MagentoFilterToJson(this);
}

/// Magento Sort Order Model
@JsonSerializable()
class MagentoSortOrder {
  final String field;
  final String direction;

  const MagentoSortOrder({
    required this.field,
    required this.direction,
  });

  factory MagentoSortOrder.fromJson(Map<String, dynamic> json) => _$MagentoSortOrderFromJson(json);
  Map<String, dynamic> toJson() => _$MagentoSortOrderToJson(this);
}

/// Magento Cart Model
@JsonSerializable()
class MagentoCart {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final bool isVirtual;
  final List<MagentoCartItem> items;
  final int itemsCount;
  final int itemsQty;
  final MagentoCustomer? customer;
  final MagentoBillingAddress? billingAddress;
  final int? storeId;

  const MagentoCart({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.isVirtual,
    required this.items,
    required this.itemsCount,
    required this.itemsQty,
    this.customer,
    this.billingAddress,
    this.storeId,
  });

  factory MagentoCart.fromJson(Map<String, dynamic> json) => _$MagentoCartFromJson(json);
  Map<String, dynamic> toJson() => _$MagentoCartToJson(this);

  double get totalPrice => items.fold(0.0, (sum, item) => sum + (item.price * item.qty));
}

/// Magento Cart Item Model
@JsonSerializable()
class MagentoCartItem {
  final int itemId;
  final String sku;
  final int qty;
  final String name;
  final double price;
  final String productType;
  final String? quoteId;

  const MagentoCartItem({
    required this.itemId,
    required this.sku,
    required this.qty,
    required this.name,
    required this.price,
    required this.productType,
    this.quoteId,
  });

  factory MagentoCartItem.fromJson(Map<String, dynamic> json) => _$MagentoCartItemFromJson(json);
  Map<String, dynamic> toJson() => _$MagentoCartItemToJson(this);

  double get totalPrice => price * qty;
}

/// Magento Order Model
@JsonSerializable()
class MagentoOrder {
  final int entityId;
  final String state;
  final String status;
  final String? couponCode;
  final String? protectCode;
  final String? shippingDescription;
  final bool isVirtual;
  final int storeId;
  final int? customerId;
  final double baseDiscountAmount;
  final double baseGrandTotal;
  final double baseShippingAmount;
  final double baseTaxAmount;
  final double baseTotalPaid;
  final double baseTotalRefunded;
  final double discountAmount;
  final double grandTotal;
  final double shippingAmount;
  final double taxAmount;
  final double totalPaid;
  final double totalRefunded;
  final String baseCurrencyCode;
  final String orderCurrencyCode;
  final String? shippingInclTax;
  final String? baseShippingInclTax;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<MagentoOrderItem> items;
  final MagentoBillingAddress? billingAddress;
  final MagentoPayment? payment;

  const MagentoOrder({
    required this.entityId,
    required this.state,
    required this.status,
    this.couponCode,
    this.protectCode,
    this.shippingDescription,
    required this.isVirtual,
    required this.storeId,
    this.customerId,
    required this.baseDiscountAmount,
    required this.baseGrandTotal,
    required this.baseShippingAmount,
    required this.baseTaxAmount,
    required this.baseTotalPaid,
    required this.baseTotalRefunded,
    required this.discountAmount,
    required this.grandTotal,
    required this.shippingAmount,
    required this.taxAmount,
    required this.totalPaid,
    required this.totalRefunded,
    required this.baseCurrencyCode,
    required this.orderCurrencyCode,
    this.shippingInclTax,
    this.baseShippingInclTax,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
    this.billingAddress,
    this.payment,
  });

  factory MagentoOrder.fromJson(Map<String, dynamic> json) => _$MagentoOrderFromJson(json);
  Map<String, dynamic> toJson() => _$MagentoOrderToJson(this);
}

/// Magento Order Item Model
@JsonSerializable()
class MagentoOrderItem {
  final int itemId;
  final String? quoteItemId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? productId;
  final String productType;
  final String sku;
  final String name;
  final double weight;
  final int qtyOrdered;
  final double price;
  final double basePrice;
  final double originalPrice;
  final double rowTotal;
  final double baseRowTotal;

  const MagentoOrderItem({
    required this.itemId,
    this.quoteItemId,
    required this.createdAt,
    required this.updatedAt,
    this.productId,
    required this.productType,
    required this.sku,
    required this.name,
    required this.weight,
    required this.qtyOrdered,
    required this.price,
    required this.basePrice,
    required this.originalPrice,
    required this.rowTotal,
    required this.baseRowTotal,
  });

  factory MagentoOrderItem.fromJson(Map<String, dynamic> json) => _$MagentoOrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$MagentoOrderItemToJson(this);
}

/// Magento Wishlist Model
@JsonSerializable()
class MagentoWishlist {
  final int id;
  final int customerId;
  final DateTime updatedAt;
  final List<MagentoWishlistItem> items;

  const MagentoWishlist({
    required this.id,
    required this.customerId,
    required this.updatedAt,
    required this.items,
  });

  factory MagentoWishlist.fromJson(Map<String, dynamic> json) => _$MagentoWishlistFromJson(json);
  Map<String, dynamic> toJson() => _$MagentoWishlistToJson(this);
}

/// Magento Wishlist Item Model
@JsonSerializable()
class MagentoWishlistItem {
  final int id;
  final int wishlistId;
  final int productId;
  final int storeId;
  final DateTime addedAt;
  final String? description;
  final int qty;

  const MagentoWishlistItem({
    required this.id,
    required this.wishlistId,
    required this.productId,
    required this.storeId,
    required this.addedAt,
    this.description,
    required this.qty,
  });

  factory MagentoWishlistItem.fromJson(Map<String, dynamic> json) => _$MagentoWishlistItemFromJson(json);
  Map<String, dynamic> toJson() => _$MagentoWishlistItemToJson(this);
}

/// Supporting Models
@JsonSerializable()
class MagentoProductExtension {
  final List<int>? categoryLinks;
  final List<MagentoStockItem>? stockItem;

  const MagentoProductExtension({
    this.categoryLinks,
    this.stockItem,
  });

  factory MagentoProductExtension.fromJson(Map<String, dynamic> json) => _$MagentoProductExtensionFromJson(json);
  Map<String, dynamic> toJson() => _$MagentoProductExtensionToJson(this);
}

@JsonSerializable()
class MagentoStockItem {
  final int itemId;
  final int productId;
  final int stockId;
  final double qty;
  final bool isInStock;
  final bool isQtyDecimal;
  final bool showDefaultNotificationMessage;
  final bool useConfigMinQty;
  final double minQty;
  final int? useConfigMinSaleQty;
  final double? minSaleQty;
  final bool useConfigMaxSaleQty;
  final double? maxSaleQty;

  const MagentoStockItem({
    required this.itemId,
    required this.productId,
    required this.stockId,
    required this.qty,
    required this.isInStock,
    required this.isQtyDecimal,
    required this.showDefaultNotificationMessage,
    required this.useConfigMinQty,
    required this.minQty,
    this.useConfigMinSaleQty,
    this.minSaleQty,
    required this.useConfigMaxSaleQty,
    this.maxSaleQty,
  });

  factory MagentoStockItem.fromJson(Map<String, dynamic> json) => _$MagentoStockItemFromJson(json);
  Map<String, dynamic> toJson() => _$MagentoStockItemToJson(this);
}

@JsonSerializable()
class MagentoProductLink {
  final String sku;
  final String linkType;
  final String linkedProductSku;
  final String linkedProductType;
  final int position;

  const MagentoProductLink({
    required this.sku,
    required this.linkType,
    required this.linkedProductSku,
    required this.linkedProductType,
    required this.position,
  });

  factory MagentoProductLink.fromJson(Map<String, dynamic> json) => _$MagentoProductLinkFromJson(json);
  Map<String, dynamic> toJson() => _$MagentoProductLinkToJson(this);
}

@JsonSerializable()
class MagentoMediaGalleryEntry {
  final int id;
  final String mediaType;
  final String label;
  final int position;
  final bool disabled;
  final List<String> types;
  final String file;

  const MagentoMediaGalleryEntry({
    required this.id,
    required this.mediaType,
    required this.label,
    required this.position,
    required this.disabled,
    required this.types,
    required this.file,
  });

  factory MagentoMediaGalleryEntry.fromJson(Map<String, dynamic> json) => _$MagentoMediaGalleryEntryFromJson(json);
  Map<String, dynamic> toJson() => _$MagentoMediaGalleryEntryToJson(this);
}

@JsonSerializable()
class MagentoCustomAttribute {
  final String attributeCode;
  final dynamic value;

  const MagentoCustomAttribute({
    required this.attributeCode,
    required this.value,
  });

  factory MagentoCustomAttribute.fromJson(Map<String, dynamic> json) => _$MagentoCustomAttributeFromJson(json);
  Map<String, dynamic> toJson() => _$MagentoCustomAttributeToJson(this);
}

@JsonSerializable()
class MagentoBillingAddress {
  final int? addressId;
  final String? addressType;
  final String? city;
  final String? company;
  final String countryId;
  final String? customerAddressId;
  final int? customerId;
  final String? email;
  final String? fax;
  final String firstname;
  final String lastname;
  final String? middlename;
  final String postcode;
  final String? prefix;
  final MagentoRegion? region;
  final String? regionCode;
  final int? regionId;
  final List<String> street;
  final String? suffix;
  final String? telephone;
  final String? vatId;

  const MagentoBillingAddress({
    this.addressId,
    this.addressType,
    this.city,
    this.company,
    required this.countryId,
    this.customerAddressId,
    this.customerId,
    this.email,
    this.fax,
    required this.firstname,
    required this.lastname,
    this.middlename,
    required this.postcode,
    this.prefix,
    this.region,
    this.regionCode,
    this.regionId,
    required this.street,
    this.suffix,
    this.telephone,
    this.vatId,
  });

  factory MagentoBillingAddress.fromJson(Map<String, dynamic> json) => _$MagentoBillingAddressFromJson(json);
  Map<String, dynamic> toJson() => _$MagentoBillingAddressToJson(this);
}

@JsonSerializable()
class MagentoPayment {
  final String? accountStatus;
  final String? additionalInformation;
  final double? amountOrdered;
  final double? baseAmountOrdered;
  final double? baseShippingAmount;
  final String? ccLast4;
  final String? method;
  final int? parentId;
  final double? shippingAmount;

  const MagentoPayment({
    this.accountStatus,
    this.additionalInformation,
    this.amountOrdered,
    this.baseAmountOrdered,
    this.baseShippingAmount,
    this.ccLast4,
    this.method,
    this.parentId,
    this.shippingAmount,
  });

  factory MagentoPayment.fromJson(Map<String, dynamic> json) => _$MagentoPaymentFromJson(json);
  Map<String, dynamic> toJson() => _$MagentoPaymentToJson(this);
}
