import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'app_models.freezed.dart';
part 'app_models.g.dart';

/// API Response wrapper
@freezed
class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse.success({
    required T data,
    String? message,
  }) = _Success<T>;

  const factory ApiResponse.error({
    required String message,
    String? code,
    @Default(500) int statusCode,
  }) = _Error<T>;

  const factory ApiResponse.loading() = _Loading<T>;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$ApiResponseFromJson(json, fromJsonT);
}

/// App Configuration
@freezed
class AppConfig with _$AppConfig {
  const factory AppConfig({
    required String apiBaseUrl,
    required String graphqlUrl,
    required String websocketUrl,
    @Default(true) bool enableAnalytics,
    @Default(true) bool enableCrashlytics,
    @Default(true) bool enablePushNotifications,
    @Default(30) int connectionTimeoutSeconds,
    @Default(30) int receiveTimeoutSeconds,
    @Default(3) int maxRetries,
    @Default(false) bool enableDebugMode,
    Map<String, dynamic>? customConfig,
  }) = _AppConfig;

  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);
}

/// User Preferences
@freezed
class UserPreferences with _$UserPreferences {
  const factory UserPreferences({
    @Default('en') String languageCode,
    @Default('system') String themeMode,
    @Default(true) bool enableNotifications,
    @Default(true) bool enableAnalytics,
    @Default(false) bool enableBiometrics,
    @Default('USD') String currency,
    @Default('US') String countryCode,
    Map<String, dynamic>? customSettings,
  }) = _UserPreferences;

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);
}

/// Network Status
@freezed
class NetworkStatus with _$NetworkStatus {
  const factory NetworkStatus({
    @Default(true) bool isConnected,
    @Default(false) bool isWiFi,
    @Default(false) bool isMobile,
    String? connectionType,
  }) = _NetworkStatus;

  factory NetworkStatus.fromJson(Map<String, dynamic> json) =>
      _$NetworkStatusFromJson(json);
}

/// App State
@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default(false) bool isInitialized,
    @Default(false) bool isLoading,
    String? error,
    AppConfig? config,
    UserPreferences? preferences,
    NetworkStatus? networkStatus,
    String? version,
    String? buildNumber,
  }) = _AppState;

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);
}

/// Pagination Info
@freezed
class PaginationInfo with _$PaginationInfo {
  const factory PaginationInfo({
    @Default(1) int currentPage,
    @Default(20) int pageSize,
    @Default(0) int totalCount,
    @Default(0) int totalPages,
    @Default(false) bool hasNextPage,
    @Default(false) bool hasPreviousPage,
  }) = _PaginationInfo;

  factory PaginationInfo.fromJson(Map<String, dynamic> json) =>
      _$PaginationInfoFromJson(json);
}

/// Sort Option
@freezed
class SortOption with _$SortOption {
  const factory SortOption({
    required String field,
    @Default('asc') String direction,
    String? label,
  }) = _SortOption;

  factory SortOption.fromJson(Map<String, dynamic> json) =>
      _$SortOptionFromJson(json);
}

/// Filter Option
@freezed
class FilterOption with _$FilterOption {
  const factory FilterOption({
    required String field,
    required String value,
    String? label,
    @Default(0) int count,
    @Default(false) bool isSelected,
  }) = _FilterOption;

  factory FilterOption.fromJson(Map<String, dynamic> json) =>
      _$FilterOptionFromJson(json);
}

/// Cache Entry
@freezed
class CacheEntry<T> with _$CacheEntry<T> {
  const factory CacheEntry({
    required T data,
    required DateTime timestamp,
    @Default(3600) int ttlSeconds,
  }) = _CacheEntry<T>;

  factory CacheEntry.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$CacheEntryFromJson(json, fromJsonT);
}

/// Error Details
@freezed
class ErrorDetails with _$ErrorDetails {
  const factory ErrorDetails({
    required String message,
    String? code,
    @Default(500) int statusCode,
    String? details,
    DateTime? timestamp,
    Map<String, dynamic>? metadata,
  }) = _ErrorDetails;

  factory ErrorDetails.fromJson(Map<String, dynamic> json) =>
      _$ErrorDetailsFromJson(json);
}
