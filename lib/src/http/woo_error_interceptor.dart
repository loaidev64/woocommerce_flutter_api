import 'package:dio/dio.dart';
import '../exceptions/woocommerce_exception.dart';

class WooErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.error is WooCommerceException) return handler.next(err);
    final mapped = WooCommerceException.fromDioException(err);
    return handler.next(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: mapped,
        stackTrace: err.stackTrace,
        message: mapped.message,
      ),
    );
  }
}
