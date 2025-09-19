import 'package:flutter/foundation.dart';
import 'package:flutter_magento/flutter_magento.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.finalPrice * quantity;
}

class CartProvider extends ChangeNotifier {
  final FlutterMagento _magento;
  
  CartProvider(this._magento);
  
  // Cart items
  List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems;
  
  // Loading states
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  // Error handling
  String? _error;
  String? get error => _error;
  
  // Cart totals
  int get itemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);
  double get totalPrice => _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  
  /// Add product to cart
  Future<void> addToCart(Product product, {int quantity = 1}) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      
      // Check if product already exists in cart
      final existingIndex = _cartItems.indexWhere(
        (item) => item.product.id == product.id,
      );
      
      if (existingIndex != -1) {
        // Update quantity if product already exists
        _cartItems[existingIndex].quantity += quantity;
      } else {
        // Add new item to cart
        _cartItems.add(CartItem(product: product, quantity: quantity));
      }
      
      // TODO: Sync with Magento cart API when available
      // await _magento.addToCart(product.id, quantity);
      
      _error = null;
    } catch (e) {
      _error = 'Failed to add to cart: $e';
      if (kDebugMode) {
        print('Add to cart error: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  /// Remove product from cart
  Future<void> removeFromCart(Product product) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      
      _cartItems.removeWhere((item) => item.product.id == product.id);
      
      // TODO: Sync with Magento cart API when available
      // await _magento.removeFromCart(product.id);
      
      _error = null;
    } catch (e) {
      _error = 'Failed to remove from cart: $e';
      if (kDebugMode) {
        print('Remove from cart error: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  /// Update product quantity in cart
  Future<void> updateQuantity(Product product, int quantity) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      
      final index = _cartItems.indexWhere(
        (item) => item.product.id == product.id,
      );
      
      if (index != -1) {
        if (quantity <= 0) {
          _cartItems.removeAt(index);
        } else {
          _cartItems[index].quantity = quantity;
        }
      }
      
      // TODO: Sync with Magento cart API when available
      // await _magento.updateCartItem(product.id, quantity);
      
      _error = null;
    } catch (e) {
      _error = 'Failed to update quantity: $e';
      if (kDebugMode) {
        print('Update quantity error: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  /// Clear cart
  Future<void> clearCart() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      
      _cartItems.clear();
      
      // TODO: Sync with Magento cart API when available
      // await _magento.clearCart();
      
      _error = null;
    } catch (e) {
      _error = 'Failed to clear cart: $e';
      if (kDebugMode) {
        print('Clear cart error: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  /// Check if product is in cart
  bool isInCart(Product product) {
    return _cartItems.any((item) => item.product.id == product.id);
  }
  
  /// Get quantity of product in cart
  int getQuantity(Product product) {
    final item = _cartItems.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );
    return item.quantity;
  }
  
  /// Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
