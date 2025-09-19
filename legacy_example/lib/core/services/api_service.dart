import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_certificate_pinning/dio_certificate_pinning.dart';
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../config/app_config.dart';
import '../models/app_models.dart';
import 'secure_storage_service.dart';
import 'network_service.dart';

/// Enhanced API service with error handling, caching, and security
class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  late final Dio _dio;
  late final NetworkService _networkService;
  final Map<String, CacheEntry<dynamic>> _cache = {};

  /// Initialize the API service
  Future<void> initialize() async {
    _networkService = NetworkService();
    await _networkService.initialize();
    
    _dio = Dio(BaseOptions(
      baseUrl: AppConfig.restApiUrl,
      connectTimeout: AppConfig.connectionTimeout,
      receiveTimeout: AppConfig.receiveTimeout,
      sendTimeout: AppConfig.sendTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'User-Agent': '${AppConfig.appName}/${AppConfig.appVersion}',
      },
    ));

    _setupInterceptors();
    
    if (kDebugMode) {
      print('🚀 API Service initialized with base URL: ${AppConfig.restApiUrl}');
    }
  }

  void _setupInterceptors() {
    // Certificate pinning for production
    if (kReleaseMode) {
      _dio.interceptors.add(
        CertificatePinningInterceptor(
          allowedSHAFingerprints: AppConfig.certificatePins,
        ),
      );
    }

    // Authentication interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          await _addAuthHeader(options);
          handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            final refreshed = await _refreshToken();
            if (refreshed) {
              // Retry the request with new token
              final clonedRequest = await _dio.request(
                error.requestOptions.path,
                options: Options(
                  method: error.requestOptions.method,
                  headers: error.requestOptions.headers,
                ),
                data: error.requestOptions.data,
                queryParameters: error.requestOptions.queryParameters,
              );
              return handler.resolve(clonedRequest);
            }
          }
          handler.next(error);
        },
      ),
    );

    // Logging interceptor (debug only)
    if (AppConfig.enableDetailedLogging) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: false,
        error: true,
        logPrint: (object) {
          if (kDebugMode) {
            print('🌐 API: $object');
          }
        },
      ));
    }

    // Error handling interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          _handleError(error);
          handler.next(error);
        },
      ),
    );

    // Retry interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          if (_shouldRetry(error)) {
            await Future.delayed(AppConfig.retryDelay);
            try {
              final response = await _dio.request(
                error.requestOptions.path,
                options: Options(
                  method: error.requestOptions.method,
                  headers: error.requestOptions.headers,
                ),
                data: error.requestOptions.data,
                queryParameters: error.requestOptions.queryParameters,
              );
              return handler.resolve(response);
            } catch (e) {
              return handler.next(error);
            }
          }
          handler.next(error);
        },
      ),
    );
  }

  Future<void> _addAuthHeader(RequestOptions options) async {
    final token = await SecureStorageService.getString('auth_token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await SecureStorageService.getString('refresh_token');
      if (refreshToken == null) return false;

      final response = await _dio.post('/auth/refresh', data: {
        'refresh_token': refreshToken,
      });

      if (response.statusCode == 200) {
        final data = response.data;
        await SecureStorageService.setString('auth_token', data['access_token']);
        if (data['refresh_token'] != null) {
          await SecureStorageService.setString('refresh_token', data['refresh_token']);
        }
        return true;
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Token refresh failed: $e');
      }
    }
    return false;
  }

  void _handleError(DioException error) {
    if (kReleaseMode && AppConfig.isFeatureEnabled('enableCrashlytics')) {
      Sentry.captureException(error, stackTrace: error.stackTrace);
    }

    if (kDebugMode) {
      print('❌ API Error: ${error.message}');
      print('Request: ${error.requestOptions.method} ${error.requestOptions.path}');
      if (error.response != null) {
        print('Response: ${error.response!.statusCode} ${error.response!.data}');
      }
    }
  }

  bool _shouldRetry(DioException error) {
    return error.type == DioExceptionType.connectionTimeout ||
           error.type == DioExceptionType.receiveTimeout ||
           error.type == DioExceptionType.sendTimeout ||
           (error.response?.statusCode ?? 0) >= 500;
  }

  /// Generic GET request with caching
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool useCache = true,
    Duration? cacheDuration,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      // Check network connectivity
      if (!await _networkService.isConnected()) {
        return const ApiResponse.error(
          message: 'No internet connection',
          code: 'NO_CONNECTION',
        );
      }

      // Check cache first
      if (useCache) {
        final cached = _getFromCache<T>(path, queryParameters);
        if (cached != null) {
          return ApiResponse.success(data: cached);
        }
      }

      final response = await _dio.get(path, queryParameters: queryParameters);
      
      if (response.statusCode == 200) {
        final data = fromJson != null ? fromJson(response.data) : response.data as T;
        
        // Cache the response
        if (useCache) {
          _saveToCache(path, queryParameters, data, cacheDuration);
        }
        
        return ApiResponse.success(data: data);
      } else {
        return ApiResponse.error(
          message: 'Request failed',
          statusCode: response.statusCode ?? 500,
        );
      }
    } on DioException catch (e) {
      return _handleDioError<T>(e);
    } catch (e) {
      return ApiResponse.error(message: e.toString());
    }
  }

  /// Generic POST request
  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      if (!await _networkService.isConnected()) {
        return const ApiResponse.error(
          message: 'No internet connection',
          code: 'NO_CONNECTION',
        );
      }

      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = fromJson != null ? fromJson(response.data) : response.data as T;
        return ApiResponse.success(data: result);
      } else {
        return ApiResponse.error(
          message: 'Request failed',
          statusCode: response.statusCode ?? 500,
        );
      }
    } on DioException catch (e) {
      return _handleDioError<T>(e);
    } catch (e) {
      return ApiResponse.error(message: e.toString());
    }
  }

  /// Generic PUT request
  Future<ApiResponse<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      if (!await _networkService.isConnected()) {
        return const ApiResponse.error(
          message: 'No internet connection',
          code: 'NO_CONNECTION',
        );
      }

      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      
      if (response.statusCode == 200) {
        final result = fromJson != null ? fromJson(response.data) : response.data as T;
        return ApiResponse.success(data: result);
      } else {
        return ApiResponse.error(
          message: 'Request failed',
          statusCode: response.statusCode ?? 500,
        );
      }
    } on DioException catch (e) {
      return _handleDioError<T>(e);
    } catch (e) {
      return ApiResponse.error(message: e.toString());
    }
  }

  /// Generic DELETE request
  Future<ApiResponse<bool>> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      if (!await _networkService.isConnected()) {
        return const ApiResponse.error(
          message: 'No internet connection',
          code: 'NO_CONNECTION',
        );
      }

      final response = await _dio.delete(path, queryParameters: queryParameters);
      
      if (response.statusCode == 200 || response.statusCode == 204) {
        return const ApiResponse.success(data: true);
      } else {
        return ApiResponse.error(
          message: 'Request failed',
          statusCode: response.statusCode ?? 500,
        );
      }
    } on DioException catch (e) {
      return _handleDioError<bool>(e);
    } catch (e) {
      return const ApiResponse.error(message: 'Unknown error occurred');
    }
  }

  /// Upload file
  Future<ApiResponse<T>> uploadFile<T>(
    String path,
    File file, {
    String fieldName = 'file',
    Map<String, dynamic>? data,
    ProgressCallback? onSendProgress,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      if (!await _networkService.isConnected()) {
        return const ApiResponse.error(
          message: 'No internet connection',
          code: 'NO_CONNECTION',
        );
      }

      final formData = FormData.fromMap({
        fieldName: await MultipartFile.fromFile(file.path),
        ...?data,
      });

      final response = await _dio.post(
        path,
        data: formData,
        onSendProgress: onSendProgress,
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = fromJson != null ? fromJson(response.data) : response.data as T;
        return ApiResponse.success(data: result);
      } else {
        return ApiResponse.error(
          message: 'Upload failed',
          statusCode: response.statusCode ?? 500,
        );
      }
    } on DioException catch (e) {
      return _handleDioError<T>(e);
    } catch (e) {
      return ApiResponse.error(message: e.toString());
    }
  }

  /// Handle Dio errors consistently
  ApiResponse<T> _handleDioError<T>(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const ApiResponse.error(
          message: 'Connection timeout. Please check your internet connection.',
          code: 'TIMEOUT',
        );
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode ?? 500;
        final message = _getErrorMessage(error.response?.data);
        return ApiResponse.error(
          message: message,
          statusCode: statusCode,
          code: 'HTTP_ERROR',
        );
      case DioExceptionType.cancel:
        return const ApiResponse.error(
          message: 'Request was cancelled',
          code: 'CANCELLED',
        );
      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return const ApiResponse.error(
            message: 'No internet connection',
            code: 'NO_CONNECTION',
          );
        }
        return const ApiResponse.error(
          message: 'An unexpected error occurred',
          code: 'UNKNOWN',
        );
      default:
        return const ApiResponse.error(
          message: 'Network error occurred',
          code: 'NETWORK_ERROR',
        );
    }
  }

  String _getErrorMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message'] ?? data['error'] ?? 'An error occurred';
    } else if (data is String) {
      return data;
    }
    return 'An error occurred';
  }

  /// Cache management
  T? _getFromCache<T>(String path, Map<String, dynamic>? queryParameters) {
    final cacheKey = _generateCacheKey(path, queryParameters);
    final cached = _cache[cacheKey];
    
    if (cached != null) {
      final isExpired = DateTime.now().difference(cached.timestamp).inSeconds > cached.ttlSeconds;
      if (!isExpired) {
        return cached.data as T;
      } else {
        _cache.remove(cacheKey);
      }
    }
    return null;
  }

  void _saveToCache<T>(
    String path,
    Map<String, dynamic>? queryParameters,
    T data,
    Duration? duration,
  ) {
    final cacheKey = _generateCacheKey(path, queryParameters);
    final ttl = duration?.inSeconds ?? AppConfig.cacheExpiration.inSeconds;
    
    _cache[cacheKey] = CacheEntry(
      data: data,
      timestamp: DateTime.now(),
      ttlSeconds: ttl,
    );

    // Clean cache if it gets too large
    if (_cache.length > 100) {
      _cleanCache();
    }
  }

  String _generateCacheKey(String path, Map<String, dynamic>? queryParameters) {
    final params = queryParameters?.entries
        .map((e) => '${e.key}=${e.value}')
        .join('&') ?? '';
    return '$path?$params';
  }

  void _cleanCache() {
    final entries = _cache.entries.toList();
    entries.sort((a, b) => a.value.timestamp.compareTo(b.value.timestamp));
    
    // Remove oldest 25% of entries
    final removeCount = (entries.length * 0.25).round();
    for (int i = 0; i < removeCount; i++) {
      _cache.remove(entries[i].key);
    }
  }

  /// Clear all cache
  void clearCache() {
    _cache.clear();
  }

  /// Get cache statistics
  Map<String, int> getCacheStats() {
    return {
      'totalEntries': _cache.length,
      'expiredEntries': _cache.values
          .where((entry) => DateTime.now().difference(entry.timestamp).inSeconds > entry.ttlSeconds)
          .length,
    };
  }

  /// Close the API service
  void dispose() {
    _dio.close();
    _cache.clear();
    _networkService.dispose();
  }
}
