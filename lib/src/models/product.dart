import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required int id,
    required String sku,
    required String name,
    required String typeId,
    required double price,
    double? specialPrice,
    String? description,
    String? shortDescription,
    List<String>? images,
    String? thumbnail,
    bool? isInStock,
    int? stockQuantity,
    String? weight,
    List<String>? categories,
    List<ProductAttribute>? attributes,
    List<ProductOption>? options,
    List<ProductVariation>? variations,
    Map<String, dynamic>? customAttributes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}

@freezed
class ProductAttribute with _$ProductAttribute {
  const factory ProductAttribute({
    required String code,
    required String label,
    required String value,
    String? type,
    bool? isRequired,
    bool? isVisible,
    List<String>? options,
  }) = _ProductAttribute;

  factory ProductAttribute.fromJson(Map<String, dynamic> json) => _$ProductAttributeFromJson(json);
}

@freezed
class ProductOption with _$ProductOption {
  const factory ProductOption({
    required int id,
    required String label,
    required String type,
    bool? isRequired,
    double? price,
    String? priceType,
    List<String>? values,
    int? sortOrder,
  }) = _ProductOption;

  factory ProductOption.fromJson(Map<String, dynamic> json) => _$ProductOptionFromJson(json);
}

@freezed
class ProductVariation with _$ProductVariation {
  const factory ProductVariation({
    required int id,
    required String sku,
    required double price,
    List<String>? images,
    Map<String, String>? attributes,
    bool? isInStock,
    int? stockQuantity,
  }) = _ProductVariation;

  factory ProductVariation.fromJson(Map<String, dynamic> json) => _$ProductVariationFromJson(json);
}
