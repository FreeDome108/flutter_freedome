import 'package:dio/dio.dart';
import '../models/wishlist_models.dart';
import 'magento_api_client.dart';

/// Wishlist API for Magento
class WishlistApi {
  final MagentoApiClient _client;

  WishlistApi(this._client);

  /// Get customer wishlist
  Future<Wishlist> getWishlist() async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/customer/wishlist',
      );

      if (response.statusCode == 200) {
        return Wishlist.fromJson(response.data!);
      } else {
        throw Exception('Failed to get wishlist: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get wishlist: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get wishlist: $e');
    }
  }

  /// Get all customer wishlists (if multiple wishlists are supported)
  Future<List<Wishlist>> getWishlists() async {
    try {
      // For now, return single wishlist as list
      // TODO: Implement multiple wishlists when Magento supports it
      final wishlist = await getWishlist();
      return [wishlist];
    } catch (e) {
      throw Exception('Failed to get wishlists: $e');
    }
  }

  /// Create a new wishlist
  Future<Wishlist> createWishlist(String name) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/customer/wishlist',
        method: 'POST',
        data: {
          'name': name,
        },
      );

      if (response.statusCode == 200) {
        return Wishlist.fromJson(response.data!);
      } else {
        throw Exception('Failed to create wishlist: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to create wishlist: ${e.message}');
    } catch (e) {
      throw Exception('Failed to create wishlist: $e');
    }
  }

  /// Update wishlist
  Future<Wishlist> updateWishlist({
    required String wishlistId,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/customer/wishlist/$wishlistId',
        method: 'PUT',
        data: data,
      );

      if (response.statusCode == 200) {
        return Wishlist.fromJson(response.data!);
      } else {
        throw Exception('Failed to update wishlist: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to update wishlist: ${e.message}');
    } catch (e) {
      throw Exception('Failed to update wishlist: $e');
    }
  }

  /// Delete wishlist
  Future<bool> deleteWishlist(String wishlistId) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/customer/wishlist/$wishlistId',
        method: 'DELETE',
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw Exception('Failed to delete wishlist: ${e.message}');
    } catch (e) {
      throw Exception('Failed to delete wishlist: $e');
    }
  }

  /// Add product to wishlist
  Future<WishlistItem> addToWishlist({
    required String wishlistId,
    required String productId,
    List<Map<String, dynamic>>? options,
  }) async {
    try {
      final data = {
        'product_id': productId,
      };

      if (options != null) {
        data['product_options'] = options;
      }

      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/customer/wishlist/$wishlistId/items',
        method: 'POST',
        data: data,
      );

      if (response.statusCode == 200) {
        return WishlistItem.fromJson(response.data!);
      } else {
        throw Exception('Failed to add to wishlist: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to add to wishlist: ${e.message}');
    } catch (e) {
      throw Exception('Failed to add to wishlist: $e');
    }
  }

  /// Add product to default wishlist
  Future<WishlistItem> addToDefaultWishlist({
    required String productId,
    List<Map<String, dynamic>>? options,
  }) async {
    try {
      final data = {
        'product_id': productId,
      };

      if (options != null) {
        data['product_options'] = options;
      }

      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/customer/wishlist/items',
        method: 'POST',
        data: data,
      );

      if (response.statusCode == 200) {
        return WishlistItem.fromJson(response.data!);
      } else {
        throw Exception('Failed to add to default wishlist: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to add to default wishlist: ${e.message}');
    } catch (e) {
      throw Exception('Failed to add to default wishlist: $e');
    }
  }

  /// Remove product from wishlist
  Future<bool> removeFromWishlist({
    required String wishlistId,
    required int itemId,
  }) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/customer/wishlist/$wishlistId/items/$itemId',
        method: 'DELETE',
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw Exception('Failed to remove from wishlist: ${e.message}');
    } catch (e) {
      throw Exception('Failed to remove from wishlist: $e');
    }
  }

  /// Remove product from default wishlist
  Future<bool> removeFromDefaultWishlist(int itemId) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/customer/wishlist/items/$itemId',
        method: 'DELETE',
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw Exception('Failed to remove from default wishlist: ${e.message}');
    } catch (e) {
      throw Exception('Failed to remove from default wishlist: $e');
    }
  }

  /// Update wishlist item
  Future<WishlistItem> updateWishlistItem({
    required String wishlistId,
    required int itemId,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/customer/wishlist/$wishlistId/items/$itemId',
        method: 'PUT',
        data: data,
      );

      if (response.statusCode == 200) {
        return WishlistItem.fromJson(response.data!);
      } else {
        throw Exception('Failed to update wishlist item: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to update wishlist item: ${e.message}');
    } catch (e) {
      throw Exception('Failed to update wishlist item: $e');
    }
  }

  /// Update default wishlist item
  Future<WishlistItem> updateDefaultWishlistItem({
    required int itemId,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/customer/wishlist/items/$itemId',
        method: 'PUT',
        data: data,
      );

      if (response.statusCode == 200) {
        return WishlistItem.fromJson(response.data!);
      } else {
        throw Exception('Failed to update default wishlist item: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to update default wishlist item: ${e.message}');
    } catch (e) {
      throw Exception('Failed to update default wishlist item: $e');
    }
  }

  /// Move item between wishlists
  Future<bool> moveWishlistItem({
    required String fromWishlistId,
    required String toWishlistId,
    required int itemId,
  }) async {
    try {
      // First get the item details
      final item = await getWishlistItem(fromWishlistId, itemId);
      
      // Add to target wishlist
      await addToWishlist(
        wishlistId: toWishlistId,
        productId: item.productId.toString(),
        options: item.options,
      );
      
      // Remove from source wishlist
      await removeFromWishlist(
        wishlistId: fromWishlistId,
        itemId: itemId,
      );
      
      return true;
    } catch (e) {
      throw Exception('Failed to move wishlist item: $e');
    }
  }

  /// Get wishlist item details
  Future<WishlistItem> getWishlistItem(String wishlistId, int itemId) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/customer/wishlist/$wishlistId/items/$itemId',
      );

      if (response.statusCode == 200) {
        return WishlistItem.fromJson(response.data!);
      } else {
        throw Exception('Failed to get wishlist item: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get wishlist item: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get wishlist item: $e');
    }
  }

  /// Get default wishlist item details
  Future<WishlistItem> getDefaultWishlistItem(int itemId) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/customer/wishlist/items/$itemId',
      );

      if (response.statusCode == 200) {
        return WishlistItem.fromJson(response.data!);
      } else {
        throw Exception('Failed to get default wishlist item: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get default wishlist item: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get default wishlist item: $e');
    }
  }

  /// Share wishlist
  Future<bool> shareWishlist({
    required String wishlistId,
    required String email,
    String? message,
  }) async {
    try {
      final data = {
        'email': email,
      };

      if (message != null) {
        data['message'] = message;
      }

      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/customer/wishlist/$wishlistId/share',
        method: 'POST',
        data: data,
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw Exception('Failed to share wishlist: ${e.message}');
    } catch (e) {
      throw Exception('Failed to share wishlist: $e');
    }
  }

  /// Share default wishlist
  Future<bool> shareDefaultWishlist({
    required String email,
    String? message,
  }) async {
    try {
      final data = {
        'email': email,
      };

      if (message != null) {
        data['message'] = message;
      }

      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/customer/wishlist/share',
        method: 'POST',
        data: data,
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw Exception('Failed to share default wishlist: ${e.message}');
    } catch (e) {
      throw Exception('Failed to share default wishlist: $e');
    }
  }

  /// Get shared wishlist
  Future<Wishlist> getSharedWishlist(String shareCode) async {
    try {
      final response = await _client.guestRequest<Map<String, dynamic>>(
        '/rest/V1/customer/wishlist/shared/$shareCode',
      );

      if (response.statusCode == 200) {
        return Wishlist.fromJson(response.data!);
      } else {
        throw Exception('Failed to get shared wishlist: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get shared wishlist: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get shared wishlist: $e');
    }
  }

  /// Add all wishlist items to cart
  Future<bool> addAllToCart(String wishlistId) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/customer/wishlist/$wishlistId/add-to-cart',
        method: 'POST',
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw Exception('Failed to add all to cart: ${e.message}');
    } catch (e) {
      throw Exception('Failed to add all to cart: $e');
    }
  }

  /// Add all default wishlist items to cart
  Future<bool> addAllDefaultWishlistToCart() async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/customer/wishlist/add-to-cart',
        method: 'POST',
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw Exception('Failed to add all default wishlist to cart: ${e.message}');
    } catch (e) {
      throw Exception('Failed to add all default wishlist to cart: $e');
    }
  }

  /// Add selected wishlist items to cart
  Future<bool> addSelectedToCart({
    required String wishlistId,
    required List<int> itemIds,
  }) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/customer/wishlist/$wishlistId/add-selected-to-cart',
        method: 'POST',
        data: {
          'item_ids': itemIds,
        },
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw Exception('Failed to add selected to cart: ${e.message}');
    } catch (e) {
      throw Exception('Failed to add selected to cart: $e');
    }
  }

  /// Add selected default wishlist items to cart
  Future<bool> addSelectedDefaultWishlistToCart(List<int> itemIds) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/customer/wishlist/add-selected-to-cart',
        method: 'POST',
        data: {
          'item_ids': itemIds,
        },
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw Exception('Failed to add selected default wishlist to cart: ${e.message}');
    } catch (e) {
      throw Exception('Failed to add selected default wishlist to cart: $e');
    }
  }

  /// Set default wishlist
  Future<bool> setDefaultWishlist(String wishlistId) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/customer/wishlist/$wishlistId/set-default',
        method: 'PUT',
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw Exception('Failed to set default wishlist: ${e.message}');
    } catch (e) {
      throw Exception('Failed to set default wishlist: $e');
    }
  }

  /// Get default wishlist
  Future<Wishlist> getDefaultWishlist() async {
    try {
      // For now, return the main wishlist as default
      // TODO: Implement proper default wishlist logic when Magento supports it
      return await getWishlist();
    } catch (e) {
      throw Exception('Failed to get default wishlist: $e');
    }
  }

  /// Get wishlist analytics
  Future<WishlistAnalytics> getWishlistAnalytics() async {
    try {
      // TODO: Implement wishlist analytics when Magento provides the endpoint
      // For now, return basic analytics
      return WishlistAnalytics(
        totalItems: 0,
        totalWishlists: 1,
        mostWishedProducts: [],
        wishlistGrowth: 0.0,
      );
    } catch (e) {
      throw Exception('Failed to get wishlist analytics: $e');
    }
  }

  /// Get wishlist trends
  Future<List<WishlistTrend>> getWishlistTrends() async {
    try {
      // TODO: Implement wishlist trends when Magento provides the endpoint
      // For now, return empty list
      return [];
    } catch (e) {
      throw Exception('Failed to get wishlist trends: $e');
    }
  }

  /// Get wishlist recommendations
  Future<List<Product>> getWishlistRecommendations() async {
    try {
      // TODO: Implement wishlist recommendations when Magento provides the endpoint
      // For now, return empty list
      return [];
    } catch (e) {
      throw Exception('Failed to get wishlist recommendations: $e');
    }
  }
}
