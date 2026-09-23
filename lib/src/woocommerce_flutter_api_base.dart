import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'base/enums/api.dart';
import 'exceptions/woocommerce_exception.dart';
import 'http/woo_error_interceptor.dart';

class WooCommerce {
  WooCommerce({
    required this.baseUrl,
    required this.consumerKey,
    required this.consumerSecret,
    this.apiVersion = WooApiVersion.v3,
    String? apiPath,
    this.authMethod = WooAuthMethod.basic,
    this.isDebug = false,
    this.useFaker = false,
    List<Interceptor>? interceptors,
  }) : apiPath = apiPath ?? '/wp-json/wc/${apiVersion.value}' {
    dio = Dio(
      BaseOptions(
        baseUrl: '$baseUrl${this.apiPath}',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: switch (authMethod) {
          WooAuthMethod.basic => {
              'Authorization':
                  'Basic ${basicAuth(consumerKey, consumerSecret)}',
            },
          WooAuthMethod.queryString => const {},
          _ => const {},
        },
        queryParameters: switch (authMethod) {
          WooAuthMethod.basic => const {},
          WooAuthMethod.queryString => {
              'consumer_key': consumerKey,
              'consumer_secret': consumerSecret,
            },
          _ => const {},
        },
      ),
    );
    if (isDebug) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
      ));
    }
    if (interceptors != null) dio.interceptors.addAll(interceptors);
    dio.interceptors.add(WooErrorInterceptor());
  }
  late final Dio dio;
  final String baseUrl;
  final String consumerKey;
  final String consumerSecret;
  final WooApiVersion apiVersion;
  final String apiPath;
  final WooAuthMethod authMethod;
  final bool isDebug;
  final bool useFaker;
  static String basicAuth(String consumerKey, String consumerSecret) {
    final credentials = '$consumerKey:$consumerSecret';
    return base64Encode(utf8.encode(credentials));
  }

  Future<Response<T>> requestGet<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) =>
      _request(
        () => dio.get<T>(
          path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ),
      );
  Future<Response<T>> requestPost<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) =>
      _request(
        () => dio.post<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ),
      );
  Future<Response<T>> requestPut<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) =>
      _request(
        () => dio.put<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ),
      );
  Future<Response<T>> requestDelete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) =>
      _request(
        () => dio.delete<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ),
      );
  Future<Response<T>> _request<T>(Future<Response<T>> Function() send) async {
    try {
      return await send();
    } on DioException catch (error) {
      final mapped = error.error;
      if (mapped is WooCommerceException) throw mapped;
      throw WooCommerceException.fromDioException(error);
    }
  }
}
