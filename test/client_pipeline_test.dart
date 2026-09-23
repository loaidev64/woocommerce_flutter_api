import 'package:dio/dio.dart';
import 'package:test/test.dart';
import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';
class _FakeStoreInterceptor extends Interceptor {
  _FakeStoreInterceptor({this.error});
  final DioException? error;
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (error != null) {
      return handler.reject(
        DioException(
          requestOptions: options,
          response: Response<dynamic>(
            requestOptions: options,
            statusCode: error!.response?.statusCode,
            data: {
              'code': 'rest_forbidden',
              'message': 'Sorry, you cannot view this resource.',
              'data': {'status': error!.response?.statusCode},
            },
          ),
          type: error!.type,
        ),
      );
    }
    final path = options.uri.toString();
    final body = path.contains('nonexistent')
        ? <String, dynamic>{'message': 'not found'}
        : <String, dynamic>{
            'id': 1,
            'name': 'Album',
            'status': 'publish',
            'type': 'simple',
          };
    return handler.resolve(
      Response<Map<String, dynamic>>(
        requestOptions: options,
        statusCode: 200,
        data: body,
      ),
    );
  }
}
WooCommerce _client(List<Interceptor> interceptors) => WooCommerce(
      baseUrl: 'https://store.test',
      consumerKey: 'ck_test',
      consumerSecret: 'cs_test',
      interceptors: interceptors,
    );
void main() {
  test('request helpers map Dio errors into typed exceptions', () async {
    final woo = _client([
      _FakeStoreInterceptor(
        error: DioException(
          requestOptions: RequestOptions(path: '/products'),
          type: DioExceptionType.badResponse,
          response: Response<dynamic>(
            requestOptions: RequestOptions(path: '/products'),
            statusCode: 401,
          ),
        ),
      ),
    ]);
    expect(
      woo.requestGet<Map<String, dynamic>>('/products/1'),
      throwsA(isA<WooCommerceAuthException>()),
    );
  });
  test('request helpers return typed responses', () async {
    final woo = _client([_FakeStoreInterceptor()]);
    final response = await woo.requestGet<Map<String, dynamic>>('/products/1');
    expect(response.data?['name'], 'Album');
  });
  test('GET request carries query parameters', () async {
    final woo = _client([_FakeStoreInterceptor()]);
    final response = await woo.requestPost<Map<String, dynamic>>(
      '/products',
      data: {'name': 'New'},
      queryParameters: {'currency': 'EUR'},
    );
    expect(response.statusCode, 200);
  });
}
