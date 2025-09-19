import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_models.freezed.dart';
part 'product_models.g.dart';

/// Product model
@freezed
class Product with _$Product {
  const factory Product({
    required int id,
    required String sku,
    required String name,
    required String typeId,
    required double price,
    double? specialPrice,
    required int status,
    required int visibility,
    required int stockStatus,
    int? stockQuantity,
    String? description,
    String? shortDescription,
    String? metaTitle,
    String? metaDescription,
    String? metaKeyword,
    List<String>? categories,
    List<String>? websites,
    List<CustomAttribute>? customAttributes,
    List<MediaGalleryEntry>? mediaGalleryEntries,
    List<ProductOption>? options,
    List<ProductLink>? productLinks,
    List<TierPrice>? tierPrices,
    List<Review>? reviews,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Product;
  
  const Product._();

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  bool get isAvailable => stockStatus == 1;
  bool get hasSpecialPrice => specialPrice != null && specialPrice! < price;
  double get currentPrice => hasSpecialPrice ? specialPrice! : price;
  double get discountPercentage =>
      hasSpecialPrice ? ((price - specialPrice!) / price * 100) : 0.0;
}

/// Product list response model
@freezed
class ProductListResponse with _$ProductListResponse {
  const factory ProductListResponse({
    required List<Product> items,
    required int totalCount,
    required int pageSize,
    required int currentPage,
    required int totalPages,
    List<Aggregation>? aggregations,
    List<SortOption>? sortOptions,
  }) = _ProductListResponse;

  factory ProductListResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductListResponseFromJson(json);
}

/// Category model
@freezed
class Category with _$Category {
  const factory Category({
    required int id,
    required String name,
    String? description,
    String? image,
    int? parentId,
    required int level,
    required int position,
    required bool isActive,
    required int childrenCount,
    List<Category>? children,
    List<CategoryAttribute>? attributes,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

/// Category tree model
@freezed
class CategoryTree with _$CategoryTree {
  const factory CategoryTree({
    required List<Category> categories,
    required int totalCount,
  }) = _CategoryTree;

  factory CategoryTree.fromJson(Map<String, dynamic> json) =>
      _$CategoryTreeFromJson(json);
}

/// Product filter parameters
@freezed
class ProductFilterParams with _$ProductFilterParams {
  const factory ProductFilterParams({
    int? page,
    int? pageSize,
    String? searchQuery,
    String? categoryId,
    String? sortBy,
    String? sortOrder,
    Map<String, dynamic>? filters,
    double? minPrice,
    double? maxPrice,
    List<String>? attributes,
    bool? inStock,
    String? brand,
    List<String>? tags,
  }) = _ProductFilterParams;

  factory ProductFilterParams.fromJson(Map<String, dynamic> json) =>
      _$ProductFilterParamsFromJson(json);
}

/// Custom attribute model
@freezed
class CustomAttribute with _$CustomAttribute {
  const factory CustomAttribute({
    required String attributeCode,
    required String value,
    String? label,
    String? type,
    List<String>? options,
  }) = _CustomAttribute;

  factory CustomAttribute.fromJson(Map<String, dynamic> json) =>
      _$CustomAttributeFromJson(json);
}

/// Media gallery entry model
@freezed
class MediaGalleryEntry with _$MediaGalleryEntry {
  const factory MediaGalleryEntry({
    required int id,
    required String mediaType,
    required String label,
    required int position,
    required bool disabled,
    List<String>? types,
    required String file,
    String? thumbnail,
    String? smallImage,
    String? baseImage,
  }) = _MediaGalleryEntry;

  factory MediaGalleryEntry.fromJson(Map<String, dynamic> json) =>
      _$MediaGalleryEntryFromJson(json);
}

/// Product option model
@freezed
class ProductOption with _$ProductOption {
  const factory ProductOption({
    required int id,
    required String title,
    required String type,
    required bool required,
    List<ProductOptionValue>? values,
    String? defaultValue,
    int? maxCharacters,
    String? fileExtension,
    String? imageSizeX,
    String? imageSizeY,
  }) = _ProductOption;

  factory ProductOption.fromJson(Map<String, dynamic> json) =>
      _$ProductOptionFromJson(json);
}

/// Product option value model
@freezed
class ProductOptionValue with _$ProductOptionValue {
  const factory ProductOptionValue({
    required int id,
    required String title,
    double? price,
    String? priceType,
    String? sku,
    int? sortOrder,
  }) = _ProductOptionValue;

  factory ProductOptionValue.fromJson(Map<String, dynamic> json) =>
      _$ProductOptionValueFromJson(json);
}

/// Product link model
@freezed
class ProductLink with _$ProductLink {
  const factory ProductLink({
    required int id,
    required String linkType,
    required Product linkedProduct,
    int? position,
  }) = _ProductLink;

  factory ProductLink.fromJson(Map<String, dynamic> json) =>
      _$ProductLinkFromJson(json);
}

/// Tier price model
@freezed
class TierPrice with _$TierPrice {
  const factory TierPrice({
    required int id,
    required int customerGroupId,
    required double price,
    required int qty,
    String? websiteId,
  }) = _TierPrice;

  factory TierPrice.fromJson(Map<String, dynamic> json) =>
      _$TierPriceFromJson(json);
}

/// Review model
@freezed
class Review with _$Review {
  const factory Review({
    required int id,
    required String title,
    required String detail,
    required String nickname,
    required int customerId,
    required double rating,
    required DateTime createdAt,
    String? status,
    List<ReviewRating>? ratings,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) =>
      _$ReviewFromJson(json);
}

/// Review rating model
@freezed
class ReviewRating with _$ReviewRating {
  const factory ReviewRating({
    required int id,
    required String ratingName,
    required double rating,
    required int ratingId,
  }) = _ReviewRating;

  factory ReviewRating.fromJson(Map<String, dynamic> json) =>
      _$ReviewRatingFromJson(json);
}

/// Aggregation model for filters
@freezed
class Aggregation with _$Aggregation {
  const factory Aggregation({
    required String attributeCode,
    required String label,
    required List<AggregationOption> options,
    required int count,
  }) = _Aggregation;

  factory Aggregation.fromJson(Map<String, dynamic> json) =>
      _$AggregationFromJson(json);
}

/// Aggregation option model
@freezed
class AggregationOption with _$AggregationOption {
  const factory AggregationOption({
    required String value,
    required String label,
    required int count,
    bool? isSelected,
  }) = _AggregationOption;

  factory AggregationOption.fromJson(Map<String, dynamic> json) =>
      _$AggregationOptionFromJson(json);
}

/// Sort option model
@freezed
class SortOption with _$SortOption {
  const factory SortOption({
    required String value,
    required String label,
    bool? isSelected,
  }) = _SortOption;

  factory SortOption.fromJson(Map<String, dynamic> json) =>
      _$SortOptionFromJson(json);
}

/// Category attribute model
@freezed
class CategoryAttribute with _$CategoryAttribute {
  const factory CategoryAttribute({
    required String attributeCode,
    required String value,
    String? label,
  }) = _CategoryAttribute;

  factory CategoryAttribute.fromJson(Map<String, dynamic> json) =>
      _$CategoryAttributeFromJson(json);
}
