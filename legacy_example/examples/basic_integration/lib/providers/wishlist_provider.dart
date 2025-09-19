import 'package:flutter/foundation.dart';
import 'package:flutter_magento/flutter_magento.dart';
import '../models/product.dart';

class WishlistProvider extends ChangeNotifier {
  final FlutterMagento _magento;
  
  WishlistProvider(this._magento);
  
  // Wishlist items
  List<Product> _wishlistItems = [];
  List<Product> get wishlistItems => _wishlistItems;
  
  // Loading states
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  // Error handling
  String? _error;
  String? get error => _error;
  
  /// Add product to wishlist
  Future<void> addToWishlist(Product product) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      
      // Check if product already exists in wishlist
      if (!_wishlistItems.any((item) => item.id == product.id)) {
        _wishlistItems.add(product);
        
        // TODO: Sync with Magento wishlist API when available
        // await _magento.addToWishlist(product.id);
      }
      
      _error = null;
    } catch (e) {
      _error = 'Failed to add to wishlist: $e';
      if (kDebugMode) {
        print('Add to wishlist error: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  /// Remove product from wishlist
  Future<void> removeFromWishlist(Product product) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      
      _wishlistItems.removeWhere((item) => item.id == product.id);
      
      // TODO: Sync with Magento wishlist API when available
      // await _magento.removeFromWishlist(product.id);
      
      _error = null;
    } catch (e) {
      _error = 'Failed to remove from wishlist: $e';
      if (kDebugMode) {
        print('Remove from wishlist error: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  /// Clear wishlist
  Future<void> clearWishlist() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      
      _wishlistItems.clear();
      
      // TODO: Sync with Magento wishlist API when available
      // await _magento.clearWishlist();
      
      _error = null;
    } catch (e) {
      _error = 'Failed to clear wishlist: $e';
      if (kDebugMode) {
        print('Clear wishlist error: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  /// Check if product is in wishlist
  bool isInWishlist(Product product) {
    return _wishlistItems.any((item) => item.id == product.id);
  }
  
  /// Load wishlist from server
  Future<void> loadWishlist() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      
      // TODO: Load wishlist from Magento API when available
      // final response = await _magento.getWishlist();
      // _wishlistItems = response.items ?? [];
      
      _error = null;
    } catch (e) {
      _error = 'Failed to load wishlist: $e';
      if (kDebugMode) {
        print('Load wishlist error: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  /// Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
