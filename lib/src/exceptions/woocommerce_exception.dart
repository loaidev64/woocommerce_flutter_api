import 'package:dio/dio.dart';

class WooCommerceException implements Exception {
  WooCommerceException({
    required this.message,
    this.statusCode,
    this.code,
    this.requestId,
  });
  factory WooCommerceException.fromDioException(DioException error) {
    final response = error.response;
    final statusCode = response?.statusCode;
    final body = response?.data;
    final parsed = body is Map<String, dynamic>
        ? _ParsedError.from(body)
        : _ParsedError.empty;
    final requestIdHeader =
        response?.headers.value('x-woo-commerce-request-id');
    if (error.type != DioExceptionType.badResponse) {
      return WooCommerceNetworkException(
        message: parsed.message ?? error.message ?? 'Network request failed',
        statusCode: statusCode,
        code: parsed.code,
        requestId: requestIdHeader,
        dioType: error.type,
      );
    }
    final errorMessage =
        parsed.message ?? 'Request failed with status $statusCode';
    final errorCode = parsed.code;
    final requestId = requestIdHeader;
    switch (statusCode) {
      case 400:
        return WooCommerceValidationException(
          message: errorMessage,
          statusCode: statusCode,
          code: errorCode,
          requestId: requestId,
          fieldErrors: parsed.fieldErrors,
        );
      case 401:
      case 403:
        return WooCommerceAuthException(
          message: errorMessage,
          statusCode: statusCode,
          code: errorCode,
          requestId: requestId,
        );
      case 404:
        return WooCommerceNotFoundException(
          message: errorMessage,
          statusCode: statusCode,
          code: errorCode,
          requestId: requestId,
        );
      case 429:
        return WooCommerceRateLimitException(
          message: errorMessage,
          statusCode: statusCode,
          code: errorCode,
          requestId: requestId,
          retryAfterSeconds: _retryAfter(response?.headers),
        );
      case 500 || 502 || 503 || 504:
        return WooCommerceServerException(
          message: errorMessage,
          statusCode: statusCode,
          code: errorCode,
          requestId: requestId,
        );
      default:
        return WooCommerceException(
          message: errorMessage,
          statusCode: statusCode,
          code: errorCode,
          requestId: requestId,
        );
    }
  }
  final String message;
  final int? statusCode;
  final String? code;
  final String? requestId;
  @override
  String toString() {
    final parts = [
      if (statusCode != null) 'status $statusCode',
      if (code != null) 'code $code',
      message,
    ];
    return '$runtimeType(${parts.join(', ')})';
  }

  static int? _retryAfter(Headers? headers) {
    final value = headers?.value('retry-after');
    if (value == null) return null;
    return int.tryParse(value);
  }
}

class WooCommerceValidationException extends WooCommerceException {
  WooCommerceValidationException({
    required super.message,
    required super.statusCode,
    required super.code,
    required super.requestId,
    this.fieldErrors = const {},
  });
  final Map<String, dynamic> fieldErrors;
}

class WooCommerceAuthException extends WooCommerceException {
  WooCommerceAuthException({
    required super.message,
    required super.statusCode,
    required super.code,
    required super.requestId,
  });
}

class WooCommerceNotFoundException extends WooCommerceException {
  WooCommerceNotFoundException({
    required super.message,
    required super.statusCode,
    required super.code,
    required super.requestId,
  });
}

class WooCommerceRateLimitException extends WooCommerceException {
  WooCommerceRateLimitException({
    required super.message,
    required super.statusCode,
    required super.code,
    required super.requestId,
    this.retryAfterSeconds,
  });
  final int? retryAfterSeconds;
}

class WooCommerceServerException extends WooCommerceException {
  WooCommerceServerException({
    required super.message,
    required super.statusCode,
    required super.code,
    required super.requestId,
  });
}

class WooCommerceNetworkException extends WooCommerceException {
  WooCommerceNetworkException({
    required super.message,
    required super.statusCode,
    required super.code,
    required super.requestId,
    this.dioType,
  });
  final DioExceptionType? dioType;
}

class WooCommerceParseException extends WooCommerceException {
  WooCommerceParseException({
    required super.message,
    super.statusCode,
    super.code,
    super.requestId,
    this.path,
  });
  final String? path;
}

class _ParsedError {
  const _ParsedError({
    this.code,
    this.message,
    this.fieldErrors = const {},
  });
  factory _ParsedError.from(Map<String, dynamic> body) {
    final data = body['data'];
    final details = data is Map<String, dynamic> ? data['details'] : null;
    return _ParsedError(
      code: body['code'] is String ? body['code'] as String : null,
      message: body['message'] is String ? body['message'] as String : null,
      fieldErrors: details is Map<String, dynamic> ? details : const {},
    );
  }
  static const empty = _ParsedError();
  final String? code;
  final String? message;
  final Map<String, dynamic> fieldErrors;
}
