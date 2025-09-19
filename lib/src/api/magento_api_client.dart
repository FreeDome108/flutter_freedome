import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/auth_models.dart';
import '../models/product_models.dart';

/// Main API client for Magento integration
class MagentoApiClient {
  static const String _storageKeyAccessToken = 'magento_access_token';
  static const String _storageKeyRefreshToken = 'magento_refresh_token';
  static const String _storageKeyCustomerId = 'magento_customer_id';

  late final Dio _dio;
  late final FlutterSecureStorage _secureStorage;
  
  String? _baseUrl;
  String? _accessToken;
  String? _refreshToken;
  int? _customerId;

  MagentoApiClient._();

  static MagentoApiClient? _instance;

  /// Get singleton instance
  static MagentoApiClient get instance {
    _instance ??= MagentoApiClient._();
    return _instance!;
  }

  /// Initialize the API client
  Future<bool> initialize({
    required String baseUrl,
    Map<String, String>? headers,
    int? connectionTimeout,
    int? receiveTimeout,
  }) async {
    try {
      _baseUrl = baseUrl;
      
      // Initialize secure storage
      _secureStorage = const FlutterSecureStorage();
      
      // Load stored tokens
      await _loadStoredTokens();
      
      // Setup Dio client
      _dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(seconds: connectionTimeout ?? 30),
        receiveTimeout: Duration(seconds: receiveTimeout ?? 30),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          ...?headers,
        },
      ));

      // Add interceptors
      _setupInterceptors();
      
      return true;
    } catch (e) {
      print('Failed to initialize MagentoApiClient: $e');
      return false;
    }
  }

  /// Setup Dio interceptors
  void _setupInterceptors() {
    // Request interceptor for authentication
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (_accessToken != null) {
            options.headers['Authorization'] = 'Bearer $_accessToken';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401 && _refreshToken != null) {
            // Try to refresh token
            try {
              final success = await _refreshAccessToken();
              if (success) {
                // Retry the original request
                final response = await _dio.request(
                  error.requestOptions.path,
                  options: Options(
                    method: error.requestOptions.method,
                    headers: error.requestOptions.headers,
                  ),
                  data: error.requestOptions.data,
                  queryParameters: error.requestOptions.queryParameters,
                );
                handler.resolve(response);
                return;
              }
            } catch (e) {
              // Refresh failed, clear tokens
              await _clearTokens();
            }
          }
          handler.next(error);
        },
      ),
    );
  }

  /// Load stored tokens from secure storage
  Future<void> _loadStoredTokens() async {
    try {
      _accessToken = await _secureStorage.read(key: _storageKeyAccessToken);
      _refreshToken = await _secureStorage.read(key: _storageKeyRefreshToken);
      final customerIdStr = await _secureStorage.read(key: _storageKeyCustomerId);
      _customerId = customerIdStr != null ? int.tryParse(customerIdStr) : null;
    } catch (e) {
      print('Failed to load stored tokens: $e');
    }
  }

  /// Store tokens in secure storage
  Future<void> storeTokens({
    required String accessToken,
    required String refreshToken,
    int? customerId,
  }) async {
    try {
      await _secureStorage.write(key: _storageKeyAccessToken, value: accessToken);
      await _secureStorage.write(key: _storageKeyRefreshToken, value: refreshToken);
      if (customerId != null) {
        await _secureStorage.write(key: _storageKeyCustomerId, value: customerId.toString());
      }
      
      _accessToken = accessToken;
      _refreshToken = refreshToken;
      _customerId = customerId;
    } catch (e) {
      print('Failed to store tokens: $e');
    }
  }

  /// Clear stored tokens
  Future<void> _clearTokens() async {
    try {
      await _secureStorage.delete(key: _storageKeyAccessToken);
      await _secureStorage.delete(key: _storageKeyRefreshToken);
      await _secureStorage.delete(key: _storageKeyCustomerId);
      
      _accessToken = null;
      _refreshToken = null;
      _customerId = null;
    } catch (e) {
      print('Failed to clear tokens: $e');
    }
  }

  /// Refresh access token
  Future<bool> _refreshAccessToken() async {
    if (_refreshToken == null) return false;
    
    try {
      final response = await _dio.post('/rest/V1/integration/customer/token', data: {
        'refresh_token': _refreshToken,
      });
      
      if (response.statusCode == 200) {
        final authResponse = AuthResponse.fromJson(response.data);
        await storeTokens(
          accessToken: authResponse.accessToken,
          refreshToken: authResponse.refreshToken,
          customerId: authResponse.customer.id,
        );
        return true;
      }
    } catch (e) {
      print('Failed to refresh token: $e');
    }
    
    return false;
  }

  /// Check if user is authenticated
  bool get isAuthenticated => _accessToken != null;

  /// Get current customer ID
  int? get currentCustomerId => _customerId;

  /// Get base URL
  String? get baseUrl => _baseUrl;

  /// Get Dio instance for custom requests
  Dio get dio => _dio;

  /// Make authenticated request
  Future<Response<T>> authenticatedRequest<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    if (!isAuthenticated) {
      throw Exception('User not authenticated');
    }
    
    return _dio.request<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// Make guest request (no authentication required)
  Future<Response<T>> guestRequest<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _dio.request<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// Logout and clear tokens
  Future<void> logout() async {
    try {
      if (isAuthenticated) {
        // Call logout endpoint if available
        await _dio.post('/rest/V1/customers/logout');
      }
    } catch (e) {
      print('Logout API call failed: $e');
    } finally {
      await _clearTokens();
    }
  }

  /// Dispose the client
  void dispose() {
    _dio.close();
    _instance = null;
  }
}
