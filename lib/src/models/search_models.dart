import 'package:json_annotation/json_annotation.dart';
import 'product_models.dart';

part 'search_models.g.dart';

/// Search response model
@JsonSerializable()
class SearchResponse {
  final List<Product>? items;
  final int? totalCount;
  final int? currentPage;
  final int? pageSize;
  final List<SearchFilter>? availableFilters;
  final List<SearchSuggestion>? suggestions;

  SearchResponse({
    this.items,
    this.totalCount,
    this.currentPage,
    this.pageSize,
    this.availableFilters,
    this.suggestions,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) => _$SearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);
}

/// Search suggestion model
@JsonSerializable()
class SearchSuggestion {
  final String? text;
  final String? type;
  final int? frequency;
  final String? url;

  SearchSuggestion({
    this.text,
    this.type,
    this.frequency,
    this.url,
  });

  factory SearchSuggestion.fromJson(Map<String, dynamic> json) => _$SearchSuggestionFromJson(json);
  Map<String, dynamic> toJson() => _$SearchSuggestionToJson(this);
}

/// Search filter model
@JsonSerializable()
class SearchFilter {
  final String? field;
  final String? value;
  final String? label;
  final String? type;
  final List<String>? options;

  SearchFilter({
    this.field,
    this.value,
    this.label,
    this.type,
    this.options,
  });

  factory SearchFilter.fromJson(Map<String, dynamic> json) => _$SearchFilterFromJson(json);
  Map<String, dynamic> toJson() => _$SearchFilterToJson(this);
}

/// Search analytics model
@JsonSerializable()
class SearchAnalytics {
  final int totalSearches;
  final List<String> popularQueries;
  final List<SearchTrend> searchTrends;
  final double conversionRate;

  SearchAnalytics({
    required this.totalSearches,
    required this.popularQueries,
    required this.searchTrends,
    required this.conversionRate,
  });

  factory SearchAnalytics.fromJson(Map<String, dynamic> json) => _$SearchAnalyticsFromJson(json);
  Map<String, dynamic> toJson() => _$SearchAnalyticsToJson(this);
}

/// Search trend model
@JsonSerializable()
class SearchTrend {
  final String period;
  final int searchCount;
  final double growthRate;

  SearchTrend({
    required this.period,
    required this.searchCount,
    required this.growthRate,
  });

  factory SearchTrend.fromJson(Map<String, dynamic> json) => _$SearchTrendFromJson(json);
  Map<String, dynamic> toJson() => _$SearchTrendToJson(this);
}

/// Filterable attribute model
@JsonSerializable()
class FilterableAttribute {
  final String? code;
  final String? label;
  final String? type;
  final List<AttributeOption>? options;
  final bool? isMultiSelect;

  FilterableAttribute({
    this.code,
    this.label,
    this.type,
    this.options,
    this.isMultiSelect,
  });

  factory FilterableAttribute.fromJson(Map<String, dynamic> json) => _$FilterableAttributeFromJson(json);
  Map<String, dynamic> toJson() => _$FilterableAttributeToJson(this);
}

/// Attribute option model
@JsonSerializable()
class AttributeOption {
  final String? value;
  final String? label;
  final int? count;

  AttributeOption({
    this.value,
    this.label,
    this.count,
  });

  factory AttributeOption.fromJson(Map<String, dynamic> json) => _$AttributeOptionFromJson(json);
  Map<String, dynamic> toJson() => _$AttributeOptionToJson(this);
}

/// Price range model
@JsonSerializable()
class PriceRange {
  final double minPrice;
  final double maxPrice;
  final List<double> priceSteps;

  PriceRange({
    required this.minPrice,
    required this.maxPrice,
    required this.priceSteps,
  });

  factory PriceRange.fromJson(Map<String, dynamic> json) => _$PriceRangeFromJson(json);
  Map<String, dynamic> toJson() => _$PriceRangeToJson(this);
}

/// Availability filter model
@JsonSerializable()
class AvailabilityFilter {
  final String code;
  final String label;
  final String value;

  AvailabilityFilter({
    required this.code,
    required this.label,
    required this.value,
  });

  factory AvailabilityFilter.fromJson(Map<String, dynamic> json) => _$AvailabilityFilterFromJson(json);
  Map<String, dynamic> toJson() => _$AvailabilityFilterToJson(this);
}

/// Filter combination model
@JsonSerializable()
class FilterCombination {
  final String name;
  final List<Map<String, dynamic>> filters;
  final DateTime? createdAt;
  final bool? isShared;

  FilterCombination({
    required this.name,
    required this.filters,
    this.createdAt,
    this.isShared,
  });

  factory FilterCombination.fromJson(Map<String, dynamic> json) => _$FilterCombinationFromJson(json);
  Map<String, dynamic> toJson() => _$FilterCombinationToJson(this);
}

/// Search request model
@JsonSerializable()
class SearchRequest {
  final String query;
  final Map<String, dynamic>? filters;
  final int page;
  final int pageSize;
  final String? sortBy;
  final String? sortOrder;

  SearchRequest({
    required this.query,
    this.filters,
    this.page = 1,
    this.pageSize = 20,
    this.sortBy,
    this.sortOrder,
  });

  factory SearchRequest.fromJson(Map<String, dynamic> json) => _$SearchRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SearchRequestToJson(this);
}

/// Search filter request model
@JsonSerializable()
class SearchFilterRequest {
  final String field;
  final String value;
  final String? operator;

  SearchFilterRequest({
    required this.field,
    required this.value,
    this.operator,
  });

  factory SearchFilterRequest.fromJson(Map<String, dynamic> json) => _$SearchFilterRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SearchFilterRequestToJson(this);
}
