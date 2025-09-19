import 'package:dio/dio.dart';
import '../models/product_models.dart';
import 'magento_api_client.dart';

/// Product API for Magento integration
class ProductApi {
  final MagentoApiClient _client;

  ProductApi(this._client);

  /// Get products with pagination and filters
  Future<ProductListResponse> getProducts({
    ProductFilterParams? params,
    int page = 1,
    int pageSize = 20,
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
  }) async {
    try {
      // Build query parameters
      final queryParams = <String, dynamic>{
        'searchCriteria[pageSize]': pageSize,
        'searchCriteria[currentPage]': page,
      };

      // Add search query if provided
      if (searchQuery != null && searchQuery.isNotEmpty) {
        queryParams['searchCriteria[filterGroups][0][filters][0][field]'] = 'name';
        queryParams['searchCriteria[filterGroups][0][filters][0][value]'] = '%$searchQuery%';
        queryParams['searchCriteria[filterGroups][0][filters][0][conditionType]'] = 'like';
      }

      // Add category filter if provided
      if (categoryId != null && categoryId.isNotEmpty) {
        queryParams['searchCriteria[filterGroups][1][filters][0][field]'] = 'category_id';
        queryParams['searchCriteria[filterGroups][1][filters][0][value]'] = categoryId;
        queryParams['searchCriteria[filterGroups][1][filters][0][conditionType]'] = 'eq';
      }

      // Add price filters if provided
      if (minPrice != null) {
        queryParams['searchCriteria[filterGroups][2][filters][0][field]'] = 'price';
        queryParams['searchCriteria[filterGroups][2][filters][0][value]'] = minPrice;
        queryParams['searchCriteria[filterGroups][2][filters][0][conditionType]'] = 'gteq';
      }

      if (maxPrice != null) {
        final priceGroupIndex = minPrice != null ? 3 : 2;
        queryParams['searchCriteria[filterGroups][$priceGroupIndex][filters][0][field]'] = 'price';
        queryParams['searchCriteria[filterGroups][$priceGroupIndex][filters][0][value]'] = maxPrice;
        queryParams['searchCriteria[filterGroups][$priceGroupIndex][filters][0][conditionType]'] = 'lteq';
      }

      // Add stock filter if provided
      if (inStock != null) {
        final stockGroupIndex = _getNextFilterGroupIndex(queryParams);
        queryParams['searchCriteria[filterGroups][$stockGroupIndex][filters][0][field]'] = 'stock_status';
        queryParams['searchCriteria[filterGroups][$stockGroupIndex][filters][0][value]'] = inStock ? 1 : 0;
        queryParams['searchCriteria[filterGroups][$stockGroupIndex][filters][0][conditionType]'] = 'eq';
      }

      // Add custom filters if provided
      if (filters != null) {
        var filterGroupIndex = _getNextFilterGroupIndex(queryParams);
        var filterIndex = 0;
        
        for (final entry in filters.entries) {
          queryParams['searchCriteria[filterGroups][$filterGroupIndex][filters][$filterIndex][field]'] = entry.key;
          queryParams['searchCriteria[filterGroups][$filterGroupIndex][filters][$filterIndex][value]'] = entry.value;
          queryParams['searchCriteria[filterGroups][$filterGroupIndex][filters][$filterIndex][conditionType]'] = 'eq';
          filterIndex++;
        }
      }

      // Add sorting if provided
      if (sortBy != null && sortBy.isNotEmpty) {
        queryParams['searchCriteria[sortOrders][0][field]'] = sortBy;
        queryParams['searchCriteria[sortOrders][0][direction]'] = sortOrder ?? 'ASC';
      }

      // Add fields to select
      queryParams['fields'] = 'items[id,sku,name,price,special_price,status,visibility,stock_status,stock_quantity,description,short_description,meta_title,meta_description,meta_keyword,categories,websites,custom_attributes,media_gallery_entries,options,product_links,tier_prices,reviews,created_at,updated_at]';

      final response = await _client.guestRequest<Map<String, dynamic>>(
        '/rest/V1/products',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return ProductListResponse.fromJson(response.data!);
      } else {
        throw Exception('Failed to get products: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get products: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get products: $e');
    }
  }

  /// Get product by SKU
  Future<Product> getProduct(String sku) async {
    try {
      final response = await _client.guestRequest<Map<String, dynamic>>(
        '/rest/V1/products/$sku',
        queryParameters: {
          'fields': 'id,sku,name,price,special_price,status,visibility,stock_status,stock_quantity,description,short_description,meta_title,meta_description,meta_keyword,categories,websites,custom_attributes,media_gallery_entries,options,product_links,tier_prices,reviews,created_at,updated_at',
        },
      );

      if (response.statusCode == 200) {
        return Product.fromJson(response.data!);
      } else {
        throw Exception('Failed to get product: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception('Product not found: $sku');
      }
      throw Exception('Failed to get product: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get product: $e');
    }
  }

  /// Get categories
  Future<CategoryTree> getCategories() async {
    try {
      final response = await _client.guestRequest<Map<String, dynamic>>(
        '/rest/V1/categories',
        queryParameters: {
          'fields': 'id,name,description,image,parent_id,level,position,is_active,children_count,children,attributes',
        },
      );

      if (response.statusCode == 200) {
        return CategoryTree.fromJson(response.data!);
      } else {
        throw Exception('Failed to get categories: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get categories: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get categories: $e');
    }
  }

  /// Get category by ID
  Future<Category> getCategory(int categoryId) async {
    try {
      final response = await _client.guestRequest<Map<String, dynamic>>(
        '/rest/V1/categories/$categoryId',
        queryParameters: {
          'fields': 'id,name,description,image,parent_id,level,position,is_active,children_count,children,attributes',
        },
      );

      if (response.statusCode == 200) {
        return Category.fromJson(response.data!);
      } else {
        throw Exception('Failed to get category: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception('Category not found: $categoryId');
      }
      throw Exception('Failed to get category: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get category: $e');
    }
  }

  /// Get products by category
  Future<ProductListResponse> getProductsByCategory(
    int categoryId, {
    int page = 1,
    int pageSize = 20,
    String? sortBy,
    String? sortOrder,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'searchCriteria[filterGroups][0][filters][0][field]': 'category_id',
        'searchCriteria[filterGroups][0][filters][0][value]': categoryId,
        'searchCriteria[filterGroups][0][filters][0][conditionType]': 'eq',
        'searchCriteria[pageSize]': pageSize,
        'searchCriteria[currentPage]': page,
      };

      // Add sorting if provided
      if (sortBy != null && sortBy.isNotEmpty) {
        queryParams['searchCriteria[sortOrders][0][field]'] = sortBy;
        queryParams['searchCriteria[sortOrders][0][direction]'] = sortOrder ?? 'ASC';
      }

      // Add custom filters if provided
      if (filters != null) {
        var filterIndex = 1;
        for (final entry in filters.entries) {
          queryParams['searchCriteria[filterGroups][0][filters][$filterIndex][field]'] = entry.key;
          queryParams['searchCriteria[filterGroups][0][filters][$filterIndex][value]'] = entry.value;
          queryParams['searchCriteria[filterGroups][0][filters][$filterIndex][conditionType]'] = 'eq';
          filterIndex++;
        }
      }

      // Add fields to select
      queryParams['fields'] = 'items[id,sku,name,price,special_price,status,visibility,stock_status,stock_quantity,description,short_description,meta_title,meta_description,meta_keyword,categories,websites,custom_attributes,media_gallery_entries,options,product_links,tier_prices,reviews,created_at,updated_at]';

      final response = await _client.guestRequest<Map<String, dynamic>>(
        '/rest/V1/products',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return ProductListResponse.fromJson(response.data!);
      } else {
        throw Exception('Failed to get category products: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get category products: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get category products: $e');
    }
  }

  /// Search products
  Future<ProductListResponse> searchProducts(
    String query, {
    int page = 1,
    int pageSize = 20,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'searchCriteria[filterGroups][0][filters][0][field]': 'name',
        'searchCriteria[filterGroups][0][filters][0][value]': '%$query%',
        'searchCriteria[filterGroups][0][filters][0][conditionType]': 'like',
        'searchCriteria[pageSize]': pageSize,
        'searchCriteria[currentPage]': page,
      };

      // Add additional search fields
      queryParams['searchCriteria[filterGroups][0][filters][1][field]'] = 'sku';
      queryParams['searchCriteria[filterGroups][0][filters][1][value]'] = '%$query%';
      queryParams['searchCriteria[filterGroups][0][filters][1][conditionType]'] = 'like';

      queryParams['searchCriteria[filterGroups][0][filters][2][field]'] = 'description';
      queryParams['searchCriteria[filterGroups][0][filters][2][value]'] = '%$query%';
      queryParams['searchCriteria[filterGroups][0][filters][2][conditionType]'] = 'like';

      // Add custom filters if provided
      if (filters != null) {
        var filterIndex = 3;
        for (final entry in filters.entries) {
          queryParams['searchCriteria[filterGroups][0][filters][$filterIndex][field]'] = entry.key;
          queryParams['searchCriteria[filterGroups][0][filters][$filterIndex][value]'] = entry.value;
          queryParams['searchCriteria[filterGroups][0][filters][$filterIndex][conditionType]'] = 'eq';
          filterIndex++;
        }
      }

      // Add sorting if provided
      if (sortBy != null && sortBy.isNotEmpty) {
        queryParams['searchCriteria[sortOrders][0][field]'] = sortBy;
        queryParams['searchCriteria[sortOrders][0][direction]'] = sortOrder ?? 'ASC';
      }

      // Add fields to select
      queryParams['fields'] = 'items[id,sku,name,price,special_price,status,visibility,stock_status,stock_quantity,description,short_description,meta_title,meta_description,meta_keyword,categories,websites,custom_attributes,media_gallery_entries,options,product_links,tier_prices,reviews,created_at,updated_at]';

      final response = await _client.guestRequest<Map<String, dynamic>>(
        '/rest/V1/products',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return ProductListResponse.fromJson(response.data!);
      } else {
        throw Exception('Failed to search products: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to search products: ${e.message}');
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }

  /// Get product variants (configurable options)
  Future<List<ProductOption>> getProductVariants(String sku) async {
    try {
      final response = await _client.guestRequest<Map<String, dynamic>>(
        '/rest/V1/products/$sku/options',
      );

      if (response.statusCode == 200) {
        final List<dynamic> optionsData = response.data!['options'] ?? [];
        return optionsData.map((json) => ProductOption.fromJson(json)).toList();
      } else {
        throw Exception('Failed to get product variants: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get product variants: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get product variants: $e');
    }
  }

  /// Get related products
  Future<List<Product>> getRelatedProducts(String sku) async {
    try {
      final response = await _client.guestRequest<Map<String, dynamic>>(
        '/rest/V1/products/$sku/links',
        queryParameters: {
          'type': 'related',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> productsData = response.data!['items'] ?? [];
        return productsData.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to get related products: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get related products: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get related products: $e');
    }
  }

  /// Get cross-sell products
  Future<List<Product>> getCrossSellProducts(String sku) async {
    try {
      final response = await _client.guestRequest<Map<String, dynamic>>(
        '/rest/V1/products/$sku/links',
        queryParameters: {
          'type': 'crosssell',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> productsData = response.data!['items'] ?? [];
        return productsData.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to get cross-sell products: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get cross-sell products: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get cross-sell products: $e');
    }
  }

  /// Get up-sell products
  Future<List<Product>> getUpSellProducts(String sku) async {
    try {
      final response = await _client.guestRequest<Map<String, dynamic>>(
        '/rest/V1/products/$sku/links',
        queryParameters: {
          'type': 'upsell',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> productsData = response.data!['items'] ?? [];
        return productsData.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to get up-sell products: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get up-sell products: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get up-sell products: $e');
    }
  }

  /// Get product reviews
  Future<List<Review>> getProductReviews(String sku, {
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await _client.guestRequest<Map<String, dynamic>>(
        '/rest/V1/products/$sku/reviews',
        queryParameters: {
          'searchCriteria[pageSize]': pageSize,
          'searchCriteria[currentPage]': page,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> reviewsData = response.data!['items'] ?? [];
        return reviewsData.map((json) => Review.fromJson(json)).toList();
      } else {
        throw Exception('Failed to get product reviews: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get product reviews: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get product reviews: $e');
    }
  }

  /// Helper method to get next filter group index
  int _getNextFilterGroupIndex(Map<String, dynamic> queryParams) {
    int maxIndex = -1;
    for (final key in queryParams.keys) {
      if (key.startsWith('searchCriteria[filterGroups][') && key.contains('][filters]')) {
        final match = RegExp(r'searchCriteria\[filterGroups\]\[(\d+)\]').firstMatch(key);
        if (match != null) {
          final index = int.tryParse(match.group(1) ?? '0') ?? 0;
          if (index > maxIndex) maxIndex = index;
        }
      }
    }
    return maxIndex + 1;
  }
}

