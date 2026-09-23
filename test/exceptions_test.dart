import 'package:dio/dio.dart';
import 'package:test/test.dart';
import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

DioException _dioError({
  int? statusCode,
  DioExceptionType type = DioExceptionType.badResponse,
  Object? body,
  String? message,
}) {
  return DioException(
    type: type,
    message: message,
    response: Response<dynamic>(
      statusCode: statusCode,
      requestOptions: RequestOptions(path: '/products'),
      data: body,
    ),
    requestOptions: RequestOptions(path: '/products'),
  );
}

void main() {
  group('WooCommerceException.fromDioException', () {
    test('400 with WooCommerce error body → validation exception', () {
      final e = WooCommerceException.fromDioException(
        _dioError(
          statusCode: 400,
          body: {
            'code': 'woocommerce_rest_invalid_param',
            'message': 'Invalid parameter(s): per_page',
            'data': {
              'status': 400,
              'details': {'per_page': {}},
            },
          },
        ),
      );
      expect(e, isA<WooCommerceValidationException>());
      expect(e.code, 'woocommerce_rest_invalid_param');
      expect(e.statusCode, 400);
      expect(e.message, contains('Invalid parameter'));
      expect(
        e,
        isA<WooCommerceValidationException>().having(
          (v) => v.fieldErrors,
          'fieldErrors',
          isNotEmpty,
        ),
      );
    });

    test('401 → auth exception', () {
      final e = WooCommerceException.fromDioException(
        _dioError(
          statusCode: 401,
          body: {'code': 'woocommerce_rest_cannot_view', 'message': 'nope'},
        ),
      );
      expect(e, isA<WooCommerceAuthException>());
      expect(e.code, 'woocommerce_rest_cannot_view');
    });

    test('404 → not found exception', () {
      final e = WooCommerceException.fromDioException(
        _dioError(statusCode: 404, body: {'message': 'not here'}),
      );
      expect(e, isA<WooCommerceNotFoundException>());
    });

    test('429 with Retry-After → rate limit exception', () {
      final response = Response<dynamic>(
        statusCode: 429,
        requestOptions: RequestOptions(path: '/products'),
        data: {'message': 'slow down'},
      );
      response.headers.add('retry-after', '30');
      final e = WooCommerceException.fromDioException(
        DioException(
          type: DioExceptionType.badResponse,
          response: response,
          requestOptions: response.requestOptions,
        ),
      );
      expect(e, isA<WooCommerceRateLimitException>());
      expect(
        (e as WooCommerceRateLimitException).retryAfterSeconds,
        30,
      );
    });

    test('500 → server exception', () {
      final e = WooCommerceException.fromDioException(
        _dioError(statusCode: 500, body: {'message': 'boom'}),
      );
      expect(e, isA<WooCommerceServerException>());
    });

    test('connection timeout → network exception', () {
      final e = WooCommerceException.fromDioException(
        _dioError(
          type: DioExceptionType.connectionTimeout,
          message: 'timed out',
        ),
      );
      expect(e, isA<WooCommerceNetworkException>());
      expect((e as WooCommerceNetworkException).dioType,
          DioExceptionType.connectionTimeout);
    });

    test('unusual status falls back to base exception', () {
      final e = WooCommerceException.fromDioException(
        _dioError(statusCode: 418, body: {'message': 'teapot'}),
      );
      expect(e.runtimeType, WooCommerceException);
      expect(e.message, 'teapot');
    });
  });
}
