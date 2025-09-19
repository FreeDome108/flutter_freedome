import 'package:dio/dio.dart';
import '../models/search_models.dart';
import '../models/product_models.dart';
import 'magento_api_client.dart';

/// Search API for Magento
class SearchApi {
  final MagentoApiClient _client;

  SearchApi(this._client);

  /// Full-text search with filters and pagination
  Future<SearchResponse> search({
    required String query,
    Map<String, dynamic>? filters,
    int page = 1,
    int pageSize = 20,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      String url = '/rest/V1/search?searchCriteria[query]=$query&searchCriteria[currentPage]=$page&searchCriteria[pageSize]=$pageSize';
      
      if (sortBy != null) {
        url += '&searchCriteria[sortOrders][0][field]=$sortBy';
        if (sortOrder != null) {
          url += '&searchCriteria[sortOrders][0][direction]=$sortOrder';
        }
      }

      if (filters != null) {
        filters.forEach((key, value) {
          url += '&searchCriteria[filterGroups][0][filters][0][field]=$key&searchCriteria[filterGroups][0][filters][0][value]=$value';
        });
      }

      final response = await _client.guestRequest<Map<String, dynamic>>(url);

      if (response.statusCode == 200) {
        return SearchResponse.fromJson(response.data!);
      } else {
        throw Exception('Failed to search: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to search: ${e.message}');
    } catch (e) {
      throw Exception('Failed to search: $e');
    }
  }

  /// Search by category
  Future<SearchResponse> searchByCategory({
    required String categoryId,
    required String query,
    Map<String, dynamic>? filters,
    int page = 1,
    int pageSize = 20,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      String url = '/rest/V1/search?searchCriteria[query]=$query&searchCriteria[filterGroups][0][filters][0][field]=category_id&searchCriteria[filterGroups][0][filters][0][value]=$categoryId&searchCriteria[currentPage]=$page&searchCriteria[pageSize]=$pageSize';
      
      if (sortBy != null) {
        url += '&searchCriteria[sortOrders][0][field]=$sortBy';
        if (sortOrder != null) {
          url += '&searchCriteria[sortOrders][0][direction]=$sortOrder';
        }
      }

      if (filters != null) {
        filters.forEach((key, value) {
          url += '&searchCriteria[filterGroups][1][filters][0][field]=$key&searchCriteria[filterGroups][1][filters][0][value]=$value';
        });
      }

      final response = await _client.guestRequest<Map<String, dynamic>>(url);

      if (response.statusCode == 200) {
        return SearchResponse.fromJson(response.data!);
      } else {
        throw Exception('Failed to search by category: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to search by category: ${e.message}');
    } catch (e) {
      throw Exception('Failed to search by category: $e');
    }
  }

  /// Search by attribute
  Future<SearchResponse> searchByAttribute({
    required String attribute,
    required String value,
    Map<String, dynamic>? additionalFilters,
    int page = 1,
    int pageSize = 20,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      String url = '/rest/V1/search?searchCriteria[filterGroups][0][filters][0][field]=$attribute&searchCriteria[filterGroups][0][filters][0][value]=$value&searchCriteria[currentPage]=$page&searchCriteria[pageSize]=$pageSize';
      
      if (sortBy != null) {
        url += '&searchCriteria[sortOrders][0][field]=$sortBy';
        if (sortOrder != null) {
          url += '&searchCriteria[sortOrders][0][direction]=$sortOrder';
        }
      }

      if (additionalFilters != null) {
        additionalFilters.forEach((key, value) {
          url += '&searchCriteria[filterGroups][1][filters][0][field]=$key&searchCriteria[filterGroups][1][filters][0][value]=$value';
        });
      }

      final response = await _client.guestRequest<Map<String, dynamic>>(url);

      if (response.statusCode == 200) {
        return SearchResponse.fromJson(response.data!);
      } else {
        throw Exception('Failed to search by attribute: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to search by attribute: ${e.message}');
    } catch (e) {
      throw Exception('Failed to search by attribute: $e');
    }
  }

  /// Get search suggestions
  Future<List<SearchSuggestion>> getSearchSuggestions(String query) async {
    try {
      final response = await _client.guestRequest<Map<String, dynamic>>(
        '/rest/V1/search/suggestions?q=$query',
      );

      if (response.statusCode == 200) {
        final List<dynamic> suggestions = response.data!['suggestions'] ?? [];
        return suggestions.map((suggestion) => SearchSuggestion.fromJson(suggestion)).toList();
      } else {
        throw Exception('Failed to get search suggestions: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get search suggestions: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get search suggestions: $e');
    }
  }

  /// Get popular searches
  Future<List<String>> getPopularSearches() async {
    try {
      // TODO: Implement popular searches when Magento provides the endpoint
      // For now, return empty list
      return [];
    } catch (e) {
      throw Exception('Failed to get popular searches: $e');
    }
  }

  /// Get search history (for authenticated users)
  Future<List<String>> getSearchHistory() async {
    try {
      // TODO: Implement search history when Magento provides the endpoint
      // For now, return empty list
      return [];
    } catch (e) {
      throw Exception('Failed to get search history: $e');
    }
  }

  /// Save search query (for authenticated users)
  Future<bool> saveSearchQuery(String query) async {
    try {
      // TODO: Implement save search query when Magento provides the endpoint
      // For now, return success
      return true;
    } catch (e) {
      throw Exception('Failed to save search query: $e');
    }
  }

  /// Get search filters
  Future<List<SearchFilter>> getSearchFilters(String query) async {
    try {
      // TODO: Implement search filters when Magento provides the endpoint
      // For now, return empty list
      return [];
    } catch (e) {
      throw Exception('Failed to get search filters: $e');
    }
  }

  /// Apply search filters
  Future<SearchResponse> applySearchFilters({
    required String query,
    required List<SearchFilter> filters,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final filterMap = <String, dynamic>{};
      for (final filter in filters) {
        filterMap[filter.field] = filter.value;
      }

      return await search(
        query: query,
        filters: filterMap,
        page: page,
        pageSize: pageSize,
      );
    } catch (e) {
      throw Exception('Failed to apply search filters: $e');
    }
  }

  /// Get search analytics
  Future<SearchAnalytics> getSearchAnalytics() async {
    try {
      // TODO: Implement search analytics when Magento provides the endpoint
      // For now, return basic analytics
      return SearchAnalytics(
        totalSearches: 0,
        popularQueries: [],
        searchTrends: [],
        conversionRate: 0.0,
      );
    } catch (e) {
      throw Exception('Failed to get search analytics: $e');
    }
  }

  /// Get search trends
  Future<List<SearchTrend>> getSearchTrends() async {
    try {
      // TODO: Implement search trends when Magento provides the endpoint
      // For now, return empty list
      return [];
    } catch (e) {
      throw Exception('Failed to get search trends: $e');
    }
  }

  /// Get search synonyms
  Future<List<String>> getSearchSynonyms(String query) async {
    try {
      // TODO: Implement search synonyms when Magento provides the endpoint
      // For now, return empty list
      return [];
    } catch (e) {
      throw Exception('Failed to get search synonyms: $e');
    }
  }

  /// Track search for analytics
  Future<void> trackSearch({
    required String query,
    required int results,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      // TODO: Implement search tracking when Magento provides the endpoint
      // For now, just log the search
      print('Search tracked: $query with $results results');
    } catch (e) {
      // Don't throw exception for tracking failures
      print('Failed to track search: $e');
    }
  }

  /// Get filterable attributes
  Future<List<FilterableAttribute>> getFilterableAttributes() async {
    try {
      final response = await _client.guestRequest<Map<String, dynamic>>(
        '/rest/V1/products/attributes?searchCriteria[filterGroups][0][filters][0][field]=is_filterable&searchCriteria[filterGroups][0][filters][0][value]=1',
      );

      if (response.statusCode == 200) {
        final List<dynamic> attributes = response.data!['items'] ?? [];
        return attributes.map((attr) => FilterableAttribute.fromJson(attr)).toList();
      } else {
        throw Exception('Failed to get filterable attributes: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get filterable attributes: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get filterable attributes: $e');
    }
  }

  /// Get attribute options
  Future<List<AttributeOption>> getAttributeOptions(String attributeCode) async {
    try {
      final response = await _client.guestRequest<Map<String, dynamic>>(
        '/rest/V1/products/attributes/$attributeCode/options',
      );

      if (response.statusCode == 200) {
        final List<dynamic> options = response.data!['options'] ?? [];
        return options.map((option) => AttributeOption.fromJson(option)).toList();
      } else {
        throw Exception('Failed to get attribute options: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get attribute options: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get attribute options: $e');
    }
  }

  /// Apply attribute filter
  Future<SearchResponse> applyAttributeFilter({
    required String attributeCode,
    required List<String> values,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final filterValue = values.join(',');
      final filters = {attributeCode: filterValue};
      
      return await search(
        query: '',
        filters: filters,
        page: page,
        pageSize: pageSize,
      );
    } catch (e) {
      throw Exception('Failed to apply attribute filter: $e');
    }
  }

  /// Get price range
  Future<PriceRange> getPriceRange() async {
    try {
      // TODO: Implement price range when Magento provides the endpoint
      // For now, return basic price range
      return PriceRange(
        minPrice: 0.0,
        maxPrice: 1000.0,
        priceSteps: [0.0, 100.0, 250.0, 500.0, 1000.0],
      );
    } catch (e) {
      throw Exception('Failed to get price range: $e');
    }
  }

  /// Apply price filter
  Future<SearchResponse> applyPriceFilter({
    required double minPrice,
    required double maxPrice,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final filters = {
        'price': '$minPrice-$maxPrice',
      };
      
      return await search(
        query: '',
        filters: filters,
        page: page,
        pageSize: pageSize,
      );
    } catch (e) {
      throw Exception('Failed to apply price filter: $e');
    }
  }

  /// Get availability filters
  Future<List<AvailabilityFilter>> getAvailabilityFilters() async {
    try {
      // TODO: Implement availability filters when Magento provides the endpoint
      // For now, return basic availability filters
      return [
        AvailabilityFilter(
          code: 'in_stock',
          label: 'In Stock',
          value: '1',
        ),
        AvailabilityFilter(
          code: 'out_of_stock',
          label: 'Out of Stock',
          value: '0',
        ),
      ];
    } catch (e) {
      throw Exception('Failed to get availability filters: $e');
    }
  }

  /// Apply availability filter
  Future<SearchResponse> applyAvailabilityFilter({
    required String availability,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final filters = {
        'stock_status': availability,
      };
      
      return await search(
        query: '',
        filters: filters,
        page: page,
        pageSize: pageSize,
      );
    } catch (e) {
      throw Exception('Failed to apply availability filter: $e');
    }
  }

  /// Combine multiple filters
  Future<SearchResponse> combineFilters({
    required List<Map<String, dynamic>> filters,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final combinedFilters = <String, dynamic>{};
      
      for (final filter in filters) {
        combinedFilters.addAll(filter);
      }
      
      return await search(
        query: '',
        filters: combinedFilters,
        page: page,
        pageSize: pageSize,
      );
    } catch (e) {
      throw Exception('Failed to combine filters: $e');
    }
  }

  /// Save filter combination
  Future<bool> saveFilterCombination({
    required String name,
    required List<Map<String, dynamic>> filters,
  }) async {
    try {
      // TODO: Implement save filter combination when Magento provides the endpoint
      // For now, return success
      return true;
    } catch (e) {
      throw Exception('Failed to save filter combination: $e');
    }
  }

  /// Get saved filter combinations
  Future<List<FilterCombination>> getSavedFilterCombinations() async {
    try {
      // TODO: Implement get saved filter combinations when Magento provides the endpoint
      // For now, return empty list
      return [];
    } catch (e) {
      throw Exception('Failed to get saved filter combinations: $e');
    }
  }

  /// Delete filter combination
  Future<bool> deleteFilterCombination(String name) async {
    try {
      // TODO: Implement delete filter combination when Magento provides the endpoint
      // For now, return success
      return true;
    } catch (e) {
      throw Exception('Failed to delete filter combination: $e');
    }
  }

  /// Share filter combination
  Future<bool> shareFilterCombination({
    required String name,
    required String email,
  }) async {
    try {
      // TODO: Implement share filter combination when Magento provides the endpoint
      // For now, return success
      return true;
    } catch (e) {
      throw Exception('Failed to share filter combination: $e');
    }
  }
}
