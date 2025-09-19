class AppConfig {
  // Magento Store Configuration
  static const String magentoBaseUrl = 'https://your-magento-store.com';
  static const String magentoApiVersion = 'V1';
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;
  
  // App Configuration
  static const String appName = 'Flutter Magento Example';
  static const String appVersion = '1.0.0';
  
  // Feature Flags
  static const bool enableDebugLogging = true;
  static const bool enableAnalytics = false;
  static const bool enableCrashReporting = false;
  
  // UI Configuration
  static const int productsPerPage = 20;
  static const int searchDebounceMs = 500;
  static const double productCardAspectRatio = 0.75;
  static const int gridCrossAxisCount = 2;
  
  // Cache Configuration
  static const int productCacheExpiryHours = 1;
  static const int categoryCacheExpiryHours = 24;
  static const int userCacheExpiryHours = 168; // 1 week
  
  // API Endpoints (relative to base URL)
  static const String authEndpoint = '/rest/V1/integration/customer/token';
  static const String productsEndpoint = '/rest/V1/products';
  static const String categoriesEndpoint = '/rest/V1/categories';
  static const String cartEndpoint = '/rest/V1/guest-carts';
  static const String customerCartEndpoint = '/rest/V1/carts/mine';
  static const String ordersEndpoint = '/rest/V1/orders';
  static const String wishlistEndpoint = '/rest/V1/customer/wishlist';
  
  // Default Headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  // Error Messages
  static const String networkErrorMessage = 'Network error. Please check your connection.';
  static const String serverErrorMessage = 'Server error. Please try again later.';
  static const String authenticationErrorMessage = 'Authentication failed. Please login again.';
  static const String unknownErrorMessage = 'An unknown error occurred.';
  
  // Success Messages
  static const String loginSuccessMessage = 'Login successful!';
  static const String registerSuccessMessage = 'Registration successful!';
  static const String logoutSuccessMessage = 'Logout successful!';
  static const String addToCartSuccessMessage = 'Product added to cart!';
  static const String addToWishlistSuccessMessage = 'Product added to wishlist!';
}





