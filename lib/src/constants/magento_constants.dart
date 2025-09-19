/// Constants for Magento API integration
class MagentoConstants {
  // API Endpoints
  static const String apiVersion = 'V1';
  static const String restApiPath = 'rest';
  
  // Authentication
  static const String customerTokenEndpoint = 'integration/customer/token';
  static const String adminTokenEndpoint = 'integration/admin/token';
  
  // Customer endpoints
  static const String customersEndpoint = 'customers';
  static const String customerMeEndpoint = 'customers/me';
  static const String customerAddressesEndpoint = 'customers/me/addresses';
  
  // Product endpoints
  static const String productsEndpoint = 'products';
  static const String searchEndpoint = 'search';
  
  // Category endpoints
  static const String categoriesEndpoint = 'categories';
  
  // Cart endpoints
  static const String guestCartsEndpoint = 'guest-carts';
  static const String cartItemsEndpoint = 'items';
  
  // Order endpoints
  static const String ordersEndpoint = 'orders';
  static const String customerOrdersEndpoint = 'customers/me/orders';
  
  // Wishlist endpoints
  static const String wishlistEndpoint = 'customers/me/wishlist';
  static const String wishlistAddEndpoint = 'customers/me/wishlist/add';
  static const String wishlistRemoveEndpoint = 'customers/me/wishlist/remove';
  
  // Checkout endpoints
  static const String estimateShippingEndpoint = 'estimate-shipping-methods';
  static const String paymentMethodsEndpoint = 'payment-methods';
  static const String placeOrderEndpoint = 'order';
  
  // HTTP Headers
  static const String contentTypeHeader = 'Content-Type';
  static const String acceptHeader = 'Accept';
  static const String authorizationHeader = 'Authorization';
  static const String userAgentHeader = 'User-Agent';
  
  // Content Types
  static const String jsonContentType = 'application/json';
  static const String formUrlEncodedContentType = 'application/x-www-form-urlencoded';
  
  // Default values
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  static const int defaultConnectionTimeout = 30000; // 30 seconds
  static const int defaultReceiveTimeout = 30000; // 30 seconds
  
  // Search criteria
  static const String searchCriteriaCurrentPage = 'searchCriteria[currentPage]';
  static const String searchCriteriaPageSize = 'searchCriteria[pageSize]';
  static const String searchCriteriaFilterGroups = 'searchCriteria[filterGroups]';
  static const String searchCriteriaFilters = 'filters';
  static const String searchCriteriaSortOrders = 'searchCriteria[sortOrders]';
  
  // Filter conditions
  static const String filterConditionEq = 'eq'; // equals
  static const String filterConditionNeq = 'neq'; // not equals
  static const String filterConditionGt = 'gt'; // greater than
  static const String filterConditionGteq = 'gteq'; // greater than or equals
  static const String filterConditionLt = 'lt'; // less than
  static const String filterConditionLteq = 'lteq'; // less than or equals
  static const String filterConditionIn = 'in'; // in
  static const String filterConditionNin = 'nin'; // not in
  static const String filterConditionNotNull = 'notnull'; // not null
  static const String filterConditionNull = 'null'; // null
  static const String filterConditionLike = 'like'; // like
  static const String filterConditionNlike = 'nlike'; // not like
  
  // Sort directions
  static const String sortDirectionAsc = 'ASC';
  static const String sortDirectionDesc = 'DESC';
  
  // Common fields
  static const String fieldId = 'id';
  static const String fieldSku = 'sku';
  static const String fieldName = 'name';
  static const String fieldEmail = 'email';
  static const String fieldPrice = 'price';
  static const String fieldQuantity = 'qty';
  static const String fieldCategoryId = 'category_id';
  static const String fieldStatus = 'status';
  static const String fieldCreatedAt = 'created_at';
  static const String fieldUpdatedAt = 'updated_at';
  
  // Error codes
  static const String errorCodeAuthentication = 'AUTH_ERROR';
  static const String errorCodeAuthorization = 'AUTHZ_ERROR';
  static const String errorCodeValidation = 'VALIDATION_ERROR';
  static const String errorCodeNotFound = 'NOT_FOUND';
  static const String errorCodeServerError = 'SERVER_ERROR';
  static const String errorCodeRateLimit = 'RATE_LIMIT';
  
  // HTTP Status codes
  static const int statusOk = 200;
  static const int statusCreated = 201;
  static const int statusNoContent = 204;
  static const int statusBadRequest = 400;
  static const int statusUnauthorized = 401;
  static const int statusForbidden = 403;
  static const int statusNotFound = 404;
  static const int statusMethodNotAllowed = 405;
  static const int statusConflict = 409;
  static const int statusUnprocessableEntity = 422;
  static const int statusTooManyRequests = 429;
  static const int statusInternalServerError = 500;
  static const int statusBadGateway = 502;
  static const int statusServiceUnavailable = 503;
  
  // User agent
  static const String userAgent = 'FlutterMagento/1.0.0';
  
  // Storage keys
  static const String storageCustomerToken = 'magento_customer_token';
  static const String storageCustomerData = 'magento_customer_data';
  static const String storageCartId = 'magento_cart_id';
  static const String storageSettings = 'magento_settings';
  
  // Cache keys
  static const String cacheProducts = 'magento_products';
  static const String cacheCategories = 'magento_categories';
  static const String cacheCustomer = 'magento_customer';
  static const String cacheCart = 'magento_cart';
  
  // Cache TTL (Time To Live) in seconds
  static const int cacheTtlProducts = 300; // 5 minutes
  static const int cacheTtlCategories = 1800; // 30 minutes
  static const int cacheTtlCustomer = 3600; // 1 hour
  static const int cacheTtlCart = 300; // 5 minutes
  
  // Pagination
  static const int minPage = 1;
  static const int maxPage = 1000;
  
  // Quantity limits
  static const int minQuantity = 1;
  static const int maxQuantity = 999;
  
  // Price precision
  static const int pricePrecision = 2;
  
  // Date formats
  static const String dateFormat = 'yyyy-MM-dd HH:mm:ss';
  static const String dateFormatShort = 'yyyy-MM-dd';
  
  // Currency
  static const String defaultCurrency = 'USD';
  
  // Language
  static const String defaultLanguage = 'en_US';
  
  // Timezone
  static const String defaultTimezone = 'UTC';
}
