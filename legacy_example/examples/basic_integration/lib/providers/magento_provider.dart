import 'package:flutter/foundation.dart';
import 'package:flutter_magento/flutter_magento.dart';
import '../models/product.dart';
import '../models/category.dart';

class MagentoProvider extends ChangeNotifier {
  final FlutterMagento _magento;
  
  MagentoProvider(this._magento);
  
  // Products
  List<Product> _products = [];
  List<Product> get products => _products;
  
  // Categories
  List<dynamic> _categories = [];
  List<dynamic> get categories => _categories;
  
  // Selected category
  String? _selectedCategoryId;
  String? get selectedCategoryId => _selectedCategoryId;
  
  // Loading states
  bool _isLoadingProducts = false;
  bool _isLoadingCategories = false;
  
  bool get isLoadingProducts => _isLoadingProducts;
  bool get isLoadingCategories => _isLoadingCategories;
  
  // Error handling
  String? _error;
  String? get error => _error;
  
  /// Load products with optional filters
  Future<void> loadProducts({
    int page = 1,
    int pageSize = 20,
    String? searchQuery,
    String? categoryId,
    Map<String, dynamic>? filters,
  }) async {
    try {
      _isLoadingProducts = true;
      _error = null;
      notifyListeners();
      
      final response = await _magento.getProducts(
        page: page,
        pageSize: pageSize,
        searchQuery: searchQuery,
        categoryId: categoryId,
        filters: filters,
      );
      
      if (page == 1) {
        _products = response.items ?? [];
      } else {
        _products.addAll(response.items ?? []);
      }
      
      _error = null;
    } catch (e) {
      _error = 'Failed to load products: $e';
      if (kDebugMode) {
        print('Error loading products: $e');
      }
    } finally {
      _isLoadingProducts = false;
      notifyListeners();
    }
  }
  
  /// Load categories
  Future<void> loadCategories() async {
    try {
      _isLoadingCategories = true;
      _error = null;
      notifyListeners();
      
      final response = await _magento.products.getCategories();
      _categories = response.children ?? [];
      
      _error = null;
    } catch (e) {
      _error = 'Failed to load categories: $e';
      if (kDebugMode) {
        print('Error loading categories: $e');
      }
    } finally {
      _isLoadingCategories = false;
      notifyListeners();
    }
  }
  
  /// Search products
  Future<void> searchProducts(String query) async {
    if (query.trim().isEmpty) {
      await loadProducts();
      return;
    }
    
    try {
      _isLoadingProducts = true;
      _error = null;
      notifyListeners();
      
      final response = await _magento.searchProducts(
        query,
        page: 1,
        pageSize: 20,
      );
      
      _products = response.items ?? [];
      _error = null;
    } catch (e) {
      _error = 'Failed to search products: $e';
      if (kDebugMode) {
        print('Error searching products: $e');
      }
    } finally {
      _isLoadingProducts = false;
      notifyListeners();
    }
  }
  
  /// Filter products by category
  Future<void> filterByCategory(String? categoryId) async {
    _selectedCategoryId = categoryId;
    await loadProducts(categoryId: categoryId);
  }
  
  /// Clear category filter
  Future<void> clearCategoryFilter() async {
    _selectedCategoryId = null;
    await loadProducts();
  }
  
  /// Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
  
  /// Refresh data
  Future<void> refresh() async {
    await Future.wait([
      loadProducts(categoryId: _selectedCategoryId),
      loadCategories(),
    ]);
  }
}
