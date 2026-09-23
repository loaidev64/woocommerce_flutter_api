import 'dart:developer' as developer;
import 'package:dio/dio.dart';

class WooLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _log('--> ${options.method} ${options.uri}');
    final body = options.data;
    if (body != null) _log('--> body: $body');
    handler.next(options);
  }

  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    _log('<-- ${response.statusCode} ${response.requestOptions.uri}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _log('<-- ${err.response?.statusCode ?? 'ERR'} ${err.requestOptions.uri}');
    _log('<-- ${err.message ?? err.error ?? 'unknown error'}');
    handler.next(err);
  }

  void _log(String message) =>
      developer.log(message, name: 'woocommerce_flutter_api');
}
