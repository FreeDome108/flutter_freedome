import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/magento_models.dart';
import '../models/tax_lien_models.dart';
import '../services/magento_api_service.dart';
import '../services/theme_service.dart';
import '../services/localization_service.dart';
import '../constants/app_constants.dart';

/// Theme provider for managing app theme
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final savedTheme = await ThemeService.getThemeMode();
    state = savedTheme;
  }

  Future<void> setTheme(ThemeMode theme) async {
    await ThemeService.setThemeMode(theme);
    state = theme;
  }

  Future<void> toggleTheme() async {
    final newTheme = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await setTheme(newTheme);
  }
}

/// Localization provider for managing app locale
final localizationProvider = StateNotifierProvider<LocalizationNotifier, Locale>((ref) {
  return LocalizationNotifier();
});

class LocalizationNotifier extends StateNotifier<Locale> {
  LocalizationNotifier() : super(const Locale('en', 'US')) {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final savedLocale = await LocalizationService.getLocale();
    state = savedLocale;
  }

  Future<void> setLocale(Locale locale) async {
    await LocalizationService.setLocale(locale);
    state = locale;
  }
}

/// Auth state
class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final String? error;
  final MagentoCustomer? customer;

  const AuthState({
    this.isAuthenticated = false,
    this.isLoading = false,
    this.error,
    this.customer,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    String? error,
    MagentoCustomer? customer,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      customer: customer ?? this.customer,
    );
  }
}

/// Auth provider for managing authentication state
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  final MagentoApiService _apiService = MagentoApiService();

  AuthNotifier() : super(const AuthState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    // Check if user is already authenticated
    final customer = await _apiService.getCurrentCustomer();
    if (customer != null) {
      state = state.copyWith(
        isAuthenticated: true,
        customer: customer,
      );
    }
  }

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final success = await _apiService.authenticateCustomer(
        email: email,
        password: password,
      );

      if (success) {
        final customer = await _apiService.getCurrentCustomer();
        state = state.copyWith(
          isAuthenticated: true,
          customer: customer,
          isLoading: false,
        );
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Invalid email or password',
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  Future<bool> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final customer = await _apiService.createCustomer(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );

      if (customer != null) {
        // Auto-login after registration
        return await login(email, password);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Registration failed',
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  Future<void> logout() async {
    await _apiService.logout();
    state = const AuthState();
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// Marketplace state
class MarketplaceState {
  final bool isLoading;
  final String? error;
  final TaxLienList? taxLiens;
  final SearchCriteria searchCriteria;
  final Map<String, List<FilterOption>> availableFilters;

  const MarketplaceState({
    this.isLoading = false,
    this.error,
    this.taxLiens,
    this.searchCriteria = const SearchCriteria(),
    this.availableFilters = const {},
  });

  MarketplaceState copyWith({
    bool? isLoading,
    String? error,
    TaxLienList? taxLiens,
    SearchCriteria? searchCriteria,
    Map<String, List<FilterOption>>? availableFilters,
  }) {
    return MarketplaceState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      taxLiens: taxLiens ?? this.taxLiens,
      searchCriteria: searchCriteria ?? this.searchCriteria,
      availableFilters: availableFilters ?? this.availableFilters,
    );
  }
}

/// Marketplace provider for managing tax lien data
final marketplaceProvider = StateNotifierProvider<MarketplaceNotifier, MarketplaceState>((ref) {
  return MarketplaceNotifier();
});

class MarketplaceNotifier extends StateNotifier<MarketplaceState> {
  final MagentoApiService _apiService = MagentoApiService();

  MarketplaceNotifier() : super(const MarketplaceState()) {
    loadTaxLiens();
  }

  Future<void> loadTaxLiens({SearchCriteria? criteria}) async {
    final searchCriteria = criteria ?? state.searchCriteria;
    state = state.copyWith(isLoading: true, error: null, searchCriteria: searchCriteria);

    try {
      // TODO: Implement tax lien specific API call
      // For now, using products API as placeholder
      final products = await _apiService.getProducts(
        page: searchCriteria.page,
        pageSize: searchCriteria.pageSize,
        searchQuery: searchCriteria.query,
      );

      // Convert Magento products to tax liens (temporary implementation)
      final taxLiens = _convertProductsToTaxLiens(products);

      state = state.copyWith(
        taxLiens: taxLiens,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Temporary conversion method - replace with actual tax lien API
  TaxLienList _convertProductsToTaxLiens(MagentoProductList? products) {
    if (products == null) {
      return const TaxLienList(
        items: [],
        totalCount: 0,
        currentPage: 1,
        pageSize: 20,
        totalPages: 0,
        filters: {},
      );
    }

    // This is a placeholder implementation
    final taxLiens = products.items.map((product) {
      return TaxLien(
        id: product.id.toString(),
        sku: product.sku,
        name: product.name,
        description: 'Tax lien investment opportunity',
        price: product.price,
        taxAmount: product.price * 0.8,
        interestRate: 12.0,
        county: 'Sample County',
        state: 'FL',
        property: const PropertyInfo(
          id: '1',
          address: '123 Sample St',
          city: 'Sample City',
          state: 'FL',
          zipCode: '12345',
          propertyType: 'Residential',
          squareFootage: 1200,
          bedrooms: 3,
          bathrooms: 2,
          yearBuilt: 2000,
          lotSize: 0.25,
          assessedValue: 150000,
          marketValue: 180000,
          coordinates: LocationCoordinates(latitude: 25.7617, longitude: -80.1918),
          photos: [],
          zoning: 'R1',
          additionalInfo: {},
        ),
        risk: const RiskAssessment(
          level: 'Medium',
          score: 65,
          description: 'Moderate risk investment',
          factors: [],
          probabilityOfRedemption: 0.7,
          expectedRoi: 12.0,
          analytics: {},
        ),
        images: [],
        status: 'Available',
        auctionDate: DateTime.now().add(const Duration(days: 30)),
        redemptionDeadline: DateTime.now().add(const Duration(days: 365)),
        isAvailable: true,
        customAttributes: {},
      );
    }).toList();

    return TaxLienList(
      items: taxLiens,
      totalCount: products.totalCount,
      currentPage: products.searchCriteria.currentPage ?? 1,
      pageSize: products.searchCriteria.pageSize ?? 20,
      totalPages: (products.totalCount / (products.searchCriteria.pageSize ?? 20)).ceil(),
      filters: {},
    );
  }

  Future<void> search(String query) async {
    final newCriteria = state.searchCriteria.copyWith(
      query: query,
      page: 1,
    );
    await loadTaxLiens(criteria: newCriteria);
  }

  Future<void> applyFilters(SearchCriteria criteria) async {
    await loadTaxLiens(criteria: criteria);
  }

  Future<void> loadNextPage() async {
    if (state.taxLiens?.hasNextPage == true) {
      final newCriteria = state.searchCriteria.copyWith(
        page: state.searchCriteria.page + 1,
      );
      await loadTaxLiens(criteria: newCriteria);
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// Cart state
class CartState {
  final bool isLoading;
  final String? error;
  final MagentoCart? cart;
  final List<String> itemIds;

  const CartState({
    this.isLoading = false,
    this.error,
    this.cart,
    this.itemIds = const [],
  });

  CartState copyWith({
    bool? isLoading,
    String? error,
    MagentoCart? cart,
    List<String>? itemIds,
  }) {
    return CartState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      cart: cart ?? this.cart,
      itemIds: itemIds ?? this.itemIds,
    );
  }

  int get itemCount => itemIds.length;
  double get totalPrice => cart?.totalPrice ?? 0.0;
}

/// Cart provider for managing cart state
final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<CartState> {
  final MagentoApiService _apiService = MagentoApiService();

  CartNotifier() : super(const CartState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    await loadCart();
  }

  Future<void> loadCart() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final cart = await _apiService.getCart();
      final itemIds = cart?.items.map((item) => item.sku).toList() ?? [];
      
      state = state.copyWith(
        cart: cart,
        itemIds: itemIds,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<bool> addToCart(String sku, int quantity) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final success = await _apiService.addToCart(sku, quantity);
      if (success) {
        final updatedItemIds = [...state.itemIds, sku];
        state = state.copyWith(
          itemIds: updatedItemIds,
          isLoading: false,
        );
        await loadCart(); // Refresh cart data
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to add item to cart',
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  Future<bool> removeFromCart(String itemId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final success = await _apiService.removeFromCart(itemId);
      if (success) {
        final updatedItemIds = state.itemIds.where((id) => id != itemId).toList();
        state = state.copyWith(
          itemIds: updatedItemIds,
          isLoading: false,
        );
        await loadCart(); // Refresh cart data
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to remove item from cart',
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  Future<void> clearCart() async {
    // Implementation depends on Magento API
    state = state.copyWith(
      cart: null,
      itemIds: [],
    );
  }

  bool isInCart(String sku) {
    return state.itemIds.contains(sku);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
