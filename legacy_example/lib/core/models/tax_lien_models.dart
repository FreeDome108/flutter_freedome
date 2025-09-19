import 'package:json_annotation/json_annotation.dart';

part 'tax_lien_models.g.dart';

/// Tax Lien Product Model
@JsonSerializable()
class TaxLien {
  final String id;
  final String sku;
  final String name;
  final String description;
  final double price;
  final double taxAmount;
  final double interestRate;
  final String county;
  final String state;
  final PropertyInfo property;
  final RiskAssessment risk;
  final List<String> images;
  final String status;
  final DateTime auctionDate;
  final DateTime redemptionDeadline;
  final bool isAvailable;
  final Map<String, dynamic> customAttributes;

  const TaxLien({
    required this.id,
    required this.sku,
    required this.name,
    required this.description,
    required this.price,
    required this.taxAmount,
    required this.interestRate,
    required this.county,
    required this.state,
    required this.property,
    required this.risk,
    required this.images,
    required this.status,
    required this.auctionDate,
    required this.redemptionDeadline,
    required this.isAvailable,
    required this.customAttributes,
  });

  factory TaxLien.fromJson(Map<String, dynamic> json) => _$TaxLienFromJson(json);
  Map<String, dynamic> toJson() => _$TaxLienToJson(this);

  TaxLien copyWith({
    String? id,
    String? sku,
    String? name,
    String? description,
    double? price,
    double? taxAmount,
    double? interestRate,
    String? county,
    String? state,
    PropertyInfo? property,
    RiskAssessment? risk,
    List<String>? images,
    String? status,
    DateTime? auctionDate,
    DateTime? redemptionDeadline,
    bool? isAvailable,
    Map<String, dynamic>? customAttributes,
  }) {
    return TaxLien(
      id: id ?? this.id,
      sku: sku ?? this.sku,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      taxAmount: taxAmount ?? this.taxAmount,
      interestRate: interestRate ?? this.interestRate,
      county: county ?? this.county,
      state: state ?? this.state,
      property: property ?? this.property,
      risk: risk ?? this.risk,
      images: images ?? this.images,
      status: status ?? this.status,
      auctionDate: auctionDate ?? this.auctionDate,
      redemptionDeadline: redemptionDeadline ?? this.redemptionDeadline,
      isAvailable: isAvailable ?? this.isAvailable,
      customAttributes: customAttributes ?? this.customAttributes,
    );
  }
}

/// Property Information Model
@JsonSerializable()
class PropertyInfo {
  final String id;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String propertyType;
  final double squareFootage;
  final int bedrooms;
  final int bathrooms;
  final int yearBuilt;
  final double lotSize;
  final double assessedValue;
  final double marketValue;
  final LocationCoordinates coordinates;
  final List<String> photos;
  final String zoning;
  final Map<String, dynamic> additionalInfo;

  const PropertyInfo({
    required this.id,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.propertyType,
    required this.squareFootage,
    required this.bedrooms,
    required this.bathrooms,
    required this.yearBuilt,
    required this.lotSize,
    required this.assessedValue,
    required this.marketValue,
    required this.coordinates,
    required this.photos,
    required this.zoning,
    required this.additionalInfo,
  });

  factory PropertyInfo.fromJson(Map<String, dynamic> json) => _$PropertyInfoFromJson(json);
  Map<String, dynamic> toJson() => _$PropertyInfoToJson(this);

  String get fullAddress => '$address, $city, $state $zipCode';
}

/// Location Coordinates Model
@JsonSerializable()
class LocationCoordinates {
  final double latitude;
  final double longitude;

  const LocationCoordinates({
    required this.latitude,
    required this.longitude,
  });

  factory LocationCoordinates.fromJson(Map<String, dynamic> json) => _$LocationCoordinatesFromJson(json);
  Map<String, dynamic> toJson() => _$LocationCoordinatesToJson(this);
}

/// Risk Assessment Model
@JsonSerializable()
class RiskAssessment {
  final String level; // Low, Medium, High
  final double score; // 0-100
  final String description;
  final List<RiskFactor> factors;
  final double probabilityOfRedemption;
  final double expectedRoi;
  final Map<String, dynamic> analytics;

  const RiskAssessment({
    required this.level,
    required this.score,
    required this.description,
    required this.factors,
    required this.probabilityOfRedemption,
    required this.expectedRoi,
    required this.analytics,
  });

  factory RiskAssessment.fromJson(Map<String, dynamic> json) => _$RiskAssessmentFromJson(json);
  Map<String, dynamic> toJson() => _$RiskAssessmentToJson(this);
}

/// Risk Factor Model
@JsonSerializable()
class RiskFactor {
  final String name;
  final String category;
  final double impact; // -1 to 1
  final String description;

  const RiskFactor({
    required this.name,
    required this.category,
    required this.impact,
    required this.description,
  });

  factory RiskFactor.fromJson(Map<String, dynamic> json) => _$RiskFactorFromJson(json);
  Map<String, dynamic> toJson() => _$RiskFactorToJson(this);
}

/// Tax Lien List Response Model
@JsonSerializable()
class TaxLienList {
  final List<TaxLien> items;
  final int totalCount;
  final int currentPage;
  final int pageSize;
  final int totalPages;
  final Map<String, List<FilterOption>> filters;

  const TaxLienList({
    required this.items,
    required this.totalCount,
    required this.currentPage,
    required this.pageSize,
    required this.totalPages,
    required this.filters,
  });

  factory TaxLienList.fromJson(Map<String, dynamic> json) => _$TaxLienListFromJson(json);
  Map<String, dynamic> toJson() => _$TaxLienListToJson(this);

  bool get hasNextPage => currentPage < totalPages;
  bool get hasPreviousPage => currentPage > 1;
}

/// Filter Option Model
@JsonSerializable()
class FilterOption {
  final String label;
  final String value;
  final int count;

  const FilterOption({
    required this.label,
    required this.value,
    required this.count,
  });

  factory FilterOption.fromJson(Map<String, dynamic> json) => _$FilterOptionFromJson(json);
  Map<String, dynamic> toJson() => _$FilterOptionToJson(this);
}

/// Search Criteria Model
@JsonSerializable()
class SearchCriteria {
  final String? query;
  final String? state;
  final String? county;
  final String? propertyType;
  final double? minPrice;
  final double? maxPrice;
  final double? minInterestRate;
  final double? maxInterestRate;
  final String? riskLevel;
  final String? sortBy;
  final String? sortOrder;
  final int page;
  final int pageSize;

  const SearchCriteria({
    this.query,
    this.state,
    this.county,
    this.propertyType,
    this.minPrice,
    this.maxPrice,
    this.minInterestRate,
    this.maxInterestRate,
    this.riskLevel,
    this.sortBy,
    this.sortOrder,
    this.page = 1,
    this.pageSize = 20,
  });

  factory SearchCriteria.fromJson(Map<String, dynamic> json) => _$SearchCriteriaFromJson(json);
  Map<String, dynamic> toJson() => _$SearchCriteriaToJson(this);

  SearchCriteria copyWith({
    String? query,
    String? state,
    String? county,
    String? propertyType,
    double? minPrice,
    double? maxPrice,
    double? minInterestRate,
    double? maxInterestRate,
    String? riskLevel,
    String? sortBy,
    String? sortOrder,
    int? page,
    int? pageSize,
  }) {
    return SearchCriteria(
      query: query ?? this.query,
      state: state ?? this.state,
      county: county ?? this.county,
      propertyType: propertyType ?? this.propertyType,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      minInterestRate: minInterestRate ?? this.minInterestRate,
      maxInterestRate: maxInterestRate ?? this.maxInterestRate,
      riskLevel: riskLevel ?? this.riskLevel,
      sortBy: sortBy ?? this.sortBy,
      sortOrder: sortOrder ?? this.sortOrder,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  Map<String, String> toQueryParameters() {
    final params = <String, String>{};
    
    if (query != null) params['q'] = query!;
    if (state != null) params['state'] = state!;
    if (county != null) params['county'] = county!;
    if (propertyType != null) params['property_type'] = propertyType!;
    if (minPrice != null) params['min_price'] = minPrice.toString();
    if (maxPrice != null) params['max_price'] = maxPrice.toString();
    if (minInterestRate != null) params['min_interest_rate'] = minInterestRate.toString();
    if (maxInterestRate != null) params['max_interest_rate'] = maxInterestRate.toString();
    if (riskLevel != null) params['risk_level'] = riskLevel!;
    if (sortBy != null) params['sort_by'] = sortBy!;
    if (sortOrder != null) params['sort_order'] = sortOrder!;
    params['page'] = page.toString();
    params['page_size'] = pageSize.toString();
    
    return params;
  }
}

/// Investment Portfolio Model
@JsonSerializable()
class InvestmentPortfolio {
  final String id;
  final String customerId;
  final List<Investment> investments;
  final double totalInvested;
  final double currentValue;
  final double totalReturns;
  final double roiPercentage;
  final PortfolioAnalytics analytics;
  final DateTime lastUpdated;

  const InvestmentPortfolio({
    required this.id,
    required this.customerId,
    required this.investments,
    required this.totalInvested,
    required this.currentValue,
    required this.totalReturns,
    required this.roiPercentage,
    required this.analytics,
    required this.lastUpdated,
  });

  factory InvestmentPortfolio.fromJson(Map<String, dynamic> json) => _$InvestmentPortfolioFromJson(json);
  Map<String, dynamic> toJson() => _$InvestmentPortfolioToJson(this);
}

/// Individual Investment Model
@JsonSerializable()
class Investment {
  final String id;
  final String taxLienId;
  final TaxLien taxLien;
  final double purchasePrice;
  final DateTime purchaseDate;
  final String status; // Active, Redeemed, Foreclosed
  final double currentValue;
  final double interestEarned;
  final DateTime? redemptionDate;
  final Map<String, dynamic> transactions;

  const Investment({
    required this.id,
    required this.taxLienId,
    required this.taxLien,
    required this.purchasePrice,
    required this.purchaseDate,
    required this.status,
    required this.currentValue,
    required this.interestEarned,
    this.redemptionDate,
    required this.transactions,
  });

  factory Investment.fromJson(Map<String, dynamic> json) => _$InvestmentFromJson(json);
  Map<String, dynamic> toJson() => _$InvestmentToJson(this);

  double get totalReturn => currentValue - purchasePrice;
  double get roiPercentage => totalReturn / purchasePrice * 100;
}

/// Portfolio Analytics Model
@JsonSerializable()
class PortfolioAnalytics {
  final Map<String, double> performanceByState;
  final Map<String, double> performanceByPropertyType;
  final Map<String, int> investmentsByRiskLevel;
  final List<MonthlyPerformance> monthlyPerformance;
  final double avgHoldingPeriod;
  final double successRate;

  const PortfolioAnalytics({
    required this.performanceByState,
    required this.performanceByPropertyType,
    required this.investmentsByRiskLevel,
    required this.monthlyPerformance,
    required this.avgHoldingPeriod,
    required this.successRate,
  });

  factory PortfolioAnalytics.fromJson(Map<String, dynamic> json) => _$PortfolioAnalyticsFromJson(json);
  Map<String, dynamic> toJson() => _$PortfolioAnalyticsToJson(this);
}

/// Monthly Performance Model
@JsonSerializable()
class MonthlyPerformance {
  final DateTime month;
  final double totalValue;
  final double totalReturns;
  final int activeInvestments;

  const MonthlyPerformance({
    required this.month,
    required this.totalValue,
    required this.totalReturns,
    required this.activeInvestments,
  });

  factory MonthlyPerformance.fromJson(Map<String, dynamic> json) => _$MonthlyPerformanceFromJson(json);
  Map<String, dynamic> toJson() => _$MonthlyPerformanceToJson(this);
}
