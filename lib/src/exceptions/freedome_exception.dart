/// Exception thrown by FreeDome operations
class FreeDomeException implements Exception {
  final String message;
  final String? code;
  final int? statusCode;
  final dynamic originalError;

  const FreeDomeException(
    this.message, {
    this.code,
    this.statusCode,
    this.originalError,
  });

  factory FreeDomeException.authenticationError(String message) {
    return FreeDomeException(message, code: 'AUTH_ERROR');
  }

  /// Network connection error
  factory FreeDomeException.networkError(String message) {
    return FreeDomeException(message, code: 'NETWORK_ERROR');
  }

  /// API error with status code
  factory FreeDomeException.apiError(String message, int statusCode) {
    return FreeDomeException(
      message,
      code: 'API_ERROR',
      statusCode: statusCode,
    );
  }

  /// Dome system not found
  factory FreeDomeException.domeNotFound(String message) {
    return FreeDomeException(message, code: 'DOME_NOT_FOUND');
  }

  /// Content format not supported
  factory FreeDomeException.unsupportedContent(String message) {
    return FreeDomeException(message, code: 'UNSUPPORTED_CONTENT');
  }

  /// Permission denied
  factory FreeDomeException.permissionDenied(String message) {
    return FreeDomeException(message, code: 'PERMISSION_DENIED');
  }

  @override
  String toString() {
    final buffer = StringBuffer('FreeDomeException: $message');
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
      other is FreeDomeException &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          code == other.code &&
          statusCode == other.statusCode;

  @override
  int get hashCode => message.hashCode ^ code.hashCode ^ statusCode.hashCode;
}
