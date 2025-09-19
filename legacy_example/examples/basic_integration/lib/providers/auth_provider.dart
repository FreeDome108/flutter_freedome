import 'package:flutter/foundation.dart';
import 'package:flutter_magento/flutter_magento.dart';
import '../models/customer.dart';

class AuthProvider extends ChangeNotifier {
  final FlutterMagento _magento;
  
  AuthProvider(this._magento);
  
  // Authentication state
  bool _isAuthenticated = false;
  bool _isLoading = false;
  Customer? _currentCustomer;
  
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  Customer? get currentCustomer => _currentCustomer;
  
  // Error handling
  String? _error;
  String? get error => _error;
  
  /// Login customer
  Future<bool> login(String email, String password) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      
      final authResponse = await _magento.authenticateCustomer(
        email: email,
        password: password,
      );
      
      _currentCustomer = authResponse.customer;
      _isAuthenticated = true;
      _error = null;
      
      return true;
    } catch (e) {
      _error = 'Login failed: $e';
      if (kDebugMode) {
        print('Login error: $e');
      }
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  /// Register customer
  Future<bool> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      
      final customer = await _magento.createCustomer(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );
      
      _currentCustomer = customer;
      _isAuthenticated = true;
      _error = null;
      
      return true;
    } catch (e) {
      _error = 'Registration failed: $e';
      if (kDebugMode) {
        print('Registration error: $e');
      }
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  /// Logout customer
  Future<void> logout() async {
    try {
      await _magento.logout();
      
      _isAuthenticated = false;
      _currentCustomer = null;
      _error = null;
    } catch (e) {
      _error = 'Logout failed: $e';
      if (kDebugMode) {
        print('Logout error: $e');
      }
    } finally {
      notifyListeners();
    }
  }
  
  /// Check authentication status
  Future<void> checkAuthStatus() async {
    try {
      if (_magento.isAuthenticated) {
        final customer = await _magento.getCurrentCustomer();
        _currentCustomer = customer;
        _isAuthenticated = true;
      } else {
        _isAuthenticated = false;
        _currentCustomer = null;
      }
    } catch (e) {
      _isAuthenticated = false;
      _currentCustomer = null;
      if (kDebugMode) {
        print('Auth check error: $e');
      }
    } finally {
      notifyListeners();
    }
  }
  
  /// Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
  
  /// Update customer profile
  Future<bool> updateProfile({
    String? firstName,
    String? lastName,
    String? email,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      
      final updatedCustomer = await _magento.updateCustomer(
        firstName: firstName,
        lastName: lastName,
      );
      
      _currentCustomer = updatedCustomer;
      _error = null;
      
      return true;
    } catch (e) {
      _error = 'Profile update failed: $e';
      if (kDebugMode) {
        print('Profile update error: $e');
      }
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

