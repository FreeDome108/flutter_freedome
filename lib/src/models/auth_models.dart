import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_models.freezed.dart';
part 'auth_models.g.dart';

/// Authentication response model
@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required String accessToken,
    required String refreshToken,
    required String tokenType,
    required int expiresIn,
    required Customer customer,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}

/// Customer model for authentication
@freezed
class Customer with _$Customer {
  const factory Customer({
    required int id,
    required String email,
    required String firstname,
    required String lastname,
    String? middlename,
    int? groupId,
    String? dob,
    String? taxvat,
    String? gender,
    bool? isSubscribed,
    String? prefix,
    String? suffix,
    String? defaultBilling,
    String? defaultShipping,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Address>? addresses,
  }) = _Customer;
  
  const Customer._();

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  String get fullName => '$firstname $lastname';
  String get displayName =>
      middlename != null ? '$firstname $middlename $lastname' : fullName;
}

/// Address model
@freezed
class Address with _$Address {
  const factory Address({
    int? id,
    String? customerId,
    String? region,
    String? regionId,
    String? regionCode,
    String? countryId,
    List<String>? street,
    String? company,
    String? telephone,
    String? fax,
    String? postcode,
    String? city,
    String? firstname,
    String? lastname,
    String? middlename,
    String? prefix,
    String? suffix,
    String? vatId,
    bool? defaultShipping,
    bool? defaultBilling,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

/// Customer creation request model
@freezed
class CustomerCreateRequest with _$CustomerCreateRequest {
  const factory CustomerCreateRequest({
    required String email,
    required String password,
    required String firstname,
    required String lastname,
    String? middlename,
    String? prefix,
    String? suffix,
    String? dob,
    String? taxvat,
    String? gender,
    bool? isSubscribed,
    List<Address>? addresses,
  }) = _CustomerCreateRequest;

  factory CustomerCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$CustomerCreateRequestFromJson(json);
}

/// Customer update request model
@freezed
class CustomerUpdateRequest with _$CustomerUpdateRequest {
  const factory CustomerUpdateRequest({
    String? firstname,
    String? lastname,
    String? middlename,
    String? prefix,
    String? suffix,
    String? dob,
    String? taxvat,
    String? gender,
    bool? isSubscribed,
    List<Address>? addresses,
  }) = _CustomerUpdateRequest;

  factory CustomerUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$CustomerUpdateRequestFromJson(json);
}

/// Password change request model
@freezed
class PasswordChangeRequest with _$PasswordChangeRequest {
  const factory PasswordChangeRequest({
    required String currentPassword,
    required String newPassword,
  }) = _PasswordChangeRequest;

  factory PasswordChangeRequest.fromJson(Map<String, dynamic> json) =>
      _$PasswordChangeRequestFromJson(json);
}

/// Password reset request model
@freezed
class PasswordResetRequest with _$PasswordResetRequest {
  const factory PasswordResetRequest({
    required String email,
  }) = _PasswordResetRequest;

  factory PasswordResetRequest.fromJson(Map<String, dynamic> json) =>
      _$PasswordResetRequestFromJson(json);
}

/// Social login request model
@freezed
class SocialLoginRequest with _$SocialLoginRequest {
  const factory SocialLoginRequest({
    required String provider,
    required String token,
    String? email,
    String? firstname,
    String? lastname,
  }) = _SocialLoginRequest;

  factory SocialLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$SocialLoginRequestFromJson(json);
}

/// Token refresh request model
@freezed
class TokenRefreshRequest with _$TokenRefreshRequest {
  const factory TokenRefreshRequest({
    required String refreshToken,
  }) = _TokenRefreshRequest;

  factory TokenRefreshRequest.fromJson(Map<String, dynamic> json) =>
      _$TokenRefreshRequestFromJson(json);
}

/// Session information model
@freezed
class SessionInfo with _$SessionInfo {
  const factory SessionInfo({
    required String sessionId,
    required DateTime createdAt,
    required DateTime expiresAt,
    required bool isValid,
    String? customerId,
    String? cartId,
  }) = _SessionInfo;

  factory SessionInfo.fromJson(Map<String, dynamic> json) =>
      _$SessionInfoFromJson(json);
}
