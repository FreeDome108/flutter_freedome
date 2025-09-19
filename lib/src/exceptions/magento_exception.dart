/// Exception thrown by Magento operations
class MagentoException implements Exception {
  final String message;
  final String? code;
  final int? statusCode;
  final Map<String, dynamic>? details;

  const MagentoException(
    this.message, {
    this.code,
    this.statusCode,
    this.details,
  });

  /// Create exception for authentication errors
  factory MagentoException.authenticationError(String message) {
    return MagentoException(message, code: 'AUTH_ERROR');
  }

  /// Create exception for network errors
  factory MagentoException.networkError(String message) {
    return MagentoException(message, code: 'NETWORK_ERROR');
  }

  /// Create exception for API errors
  factory MagentoException.apiError(String message, int statusCode) {
    return MagentoException(
      message,
      code: 'API_ERROR',
      statusCode: statusCode,
    );
  }

  /// Check if this is an authentication error
  bool get isAuthenticationError => code == 'AUTH_ERROR';

  /// Check if this is a network error
  bool get isNetworkError => code == 'NETWORK_ERROR';

  /// Check if this is an API error
  bool get isApiError => code == 'API_ERROR';

  @override
  String toString() {
    final buffer = StringBuffer('MagentoException: $message');
    if (code != null) {
      buffer.write(' (Code: $code)');
    }
    if (statusCode != null) {
      buffer.write(' (Status: $statusCode)');
    }
    return buffer.toString();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MagentoException &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          code == other.code &&
          statusCode == other.statusCode;

  @override
  int get hashCode => message.hashCode ^ code.hashCode ^ statusCode.hashCode;
}
