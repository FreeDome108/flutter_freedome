import 'package:flutter/foundation.dart';
import '../models/cart.dart';
import '../models/product.dart';
import '../exceptions/magento_exception.dart';
import 'magento_api_service.dart';

/// Service for managing shopping cart
class CartService {
  final MagentoApiService _apiService;
  
  Cart? _currentCart;
  String? _cartId;
  bool _isInitialized = false;
  
  CartService(this._apiService);
  
  /// Get current cart
  Cart? get currentCart => _currentCart;
  
  /// Get cart ID
  String? get cartId => _cartId;
  
  /// Check if service is initialized
  bool get isInitialized => _isInitialized;
  
  /// Check if cart is empty
  bool get isCartEmpty => _currentCart?.items.isEmpty ?? true;
  
  /// Get cart items count
  int get itemsCount => _currentCart?.items.length ?? 0;
  
  /// Get cart total
  double get cartTotal => _currentCart?.grandTotal ?? 0.0;
  
  /// Initialize the cart service
  Future<bool> initialize() async {
    try {
      _isInitialized = true;
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Failed to initialize CartService: $e');
      }
      return false;
    }
  }
  
  /// Create new cart
  Future<String> createCart() async {
    try {
      _cartId = await _apiService.createCart();
      await _refreshCart();
      return _cartId!;
    } catch (e) {
      if (e is MagentoException) {
        rethrow;
      }
      throw MagentoException('Failed to create cart: $e');
    }
  }
  
  /// Get cart information
  Future<Cart> getCart() async {
    if (_cartId == null) {
      throw MagentoException('Cart not created. Call createCart() first.');
    }
    
    try {
      await _refreshCart();
      return _currentCart!;
    } catch (e) {
      if (e is MagentoException) {
        rethrow;
      }
      throw MagentoException('Failed to get cart: $e');
    }
  }
  
  /// Add product to cart
  Future<bool> addToCart({
    required String sku,
    required int quantity,
    Map<String, dynamic>? productOptions,
  }) async {
    if (_cartId == null) {
      throw MagentoException('Cart not created. Call createCart() first.');
    }
    
    try {
      final success = await _apiService.addToCart(
        _cartId!,
        sku,
        quantity,
        productOptions,
      );
      
      if (success) {
        await _refreshCart();
      }
      
      return success;
    } catch (e) {
      if (e is MagentoException) {
        rethrow;
      }
      throw MagentoException('Failed to add product to cart: $e');
    }
  }
  
  /// Update cart item quantity
  Future<bool> updateQuantity({
    required int itemId,
    required int quantity,
  }) async {
    if (_cartId == null) {
      throw MagentoException('Cart not created. Call createCart() first.');
    }
    
    if (quantity <= 0) {
      return await removeFromCart(itemId);
    }
    
    try {
      final success = await _apiService.updateCartItem(
        _cartId!,
        itemId,
        quantity,
      );
      
      if (success) {
        await _refreshCart();
      }
      
      return success;
    } catch (e) {
      if (e is MagentoException) {
        rethrow;
      }
      throw MagentoException('Failed to update quantity: $e');
    }
  }
  
  /// Remove item from cart
  Future<bool> removeFromCart(int itemId) async {
    if (_cartId == null) {
      throw MagentoException('Cart not created. Call createCart() first.');
    }
    
    try {
      final success = await _apiService.removeFromCart(_cartId!, itemId);
      
      if (success) {
        await _refreshCart();
      }
      
      return success;
    } catch (e) {
      if (e is MagentoException) {
        rethrow;
      }
      throw MagentoException('Failed to remove item from cart: $e');
    }
  }
  
  /// Clear cart
  Future<bool> clearCart() async {
    if (_cartId == null) {
      return true;
    }
    
    try {
      final items = _currentCart?.items ?? [];
      bool allRemoved = true;
      
      for (final item in items) {
        final success = await removeFromCart(item.id);
        if (!success) {
          allRemoved = false;
        }
      }
      
      return allRemoved;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Failed to clear cart: $e');
      }
      return false;
    }
  }
  
  /// Get cart item by ID
  CartItem? getCartItem(int itemId) {
    return _currentCart?.items.firstWhere(
      (item) => item.id == itemId,
      orElse: () => throw MagentoException.notFoundError('Cart item'),
    );
  }
  
  /// Check if product is in cart
  bool isProductInCart(String sku) {
    return _currentCart?.items.any((item) => item.sku == sku) ?? false;
  }
  
  /// Get product quantity in cart
  int getProductQuantity(String sku) {
    final item = _currentCart?.items.firstWhere(
      (item) => item.sku == sku,
      orElse: () => CartItem(
        id: 0,
        sku: sku,
        name: '',
        price: 0.0,
        quantity: 0,
      ),
    );
    
    return item?.quantity ?? 0;
  }
  
  /// Apply coupon code
  Future<bool> applyCoupon(String couponCode) async {
    if (_cartId == null) {
      throw MagentoException('Cart not created. Call createCart() first.');
    }
    
    try {
      // This would typically call a Magento API endpoint to apply coupon
      // For now, we'll just update the local cart object
      if (_currentCart != null) {
        _currentCart = _currentCart!.copyWith(couponCode: couponCode);
      }
      
      return true;
    } catch (e) {
      if (e is MagentoException) {
        rethrow;
      }
      throw MagentoException('Failed to apply coupon: $e');
    }
  }
  
  /// Remove coupon code
  Future<bool> removeCoupon() async {
    if (_cartId == null) {
      throw MagentoException('Cart not created. Call createCart() first.');
    }
    
    try {
      if (_currentCart != null) {
        _currentCart = _currentCart!.copyWith(couponCode: null);
      }
      
      return true;
    } catch (e) {
      if (e is MagentoException) {
        rethrow;
      }
      throw MagentoException('Failed to remove coupon: $e');
    }
  }
  
  /// Estimate shipping
  Future<List<Map<String, dynamic>>> estimateShipping(Map<String, dynamic> address) async {
    if (_cartId == null) {
      throw MagentoException('Cart not created. Call createCart() first.');
    }
    
    try {
      final response = await _apiService.estimateShippingMethods(_cartId!, address);
      return List<Map<String, dynamic>>.from(response['shipping_methods'] ?? []);
    } catch (e) {
      if (e is MagentoException) {
        rethrow;
      }
      throw MagentoException('Failed to estimate shipping: $e');
    }
  }
  
  /// Get payment methods
  Future<List<Map<String, dynamic>>> getPaymentMethods() async {
    if (_cartId == null) {
      throw MagentoException('Cart not created. Call createCart() first.');
    }
    
    try {
      final response = await _apiService.estimatePaymentMethods(_cartId!);
      return List<Map<String, dynamic>>.from(response['payment_methods'] ?? []);
    } catch (e) {
      if (e is MagentoException) {
        rethrow;
      }
      throw MagentoException('Failed to get payment methods: $e');
    }
  }
  
  /// Place order
  Future<Map<String, dynamic>> placeOrder(Map<String, dynamic> orderData) async {
    if (_cartId == null) {
      throw MagentoException('Cart not created. Call createCart() first.');
    }
    
    try {
      final response = await _apiService.placeOrder(_cartId!, orderData);
      
      // Clear cart after successful order
      await clearCart();
      _cartId = null;
      _currentCart = null;
      
      return response;
    } catch (e) {
      if (e is MagentoException) {
        rethrow;
      }
      throw MagentoException('Failed to place order: $e');
    }
  }
  
  /// Refresh cart data
  Future<void> _refreshCart() async {
    if (_cartId == null) return;
    
    try {
      _currentCart = await _apiService.getCart(_cartId!);
    } catch (e) {
      if (kDebugMode) {
        print('❌ Failed to refresh cart: $e');
      }
      // Don't throw here, just log the error
    }
  }
  
  /// Set cart ID (useful for restoring cart from storage)
  void setCartId(String cartId) {
    _cartId = cartId;
  }
  
  /// Reset cart service
  void reset() {
    _currentCart = null;
    _cartId = null;
  }
}
