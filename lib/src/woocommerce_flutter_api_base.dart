import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'base/enums/api.dart';
import 'exceptions/woocommerce_exception.dart';
import 'http/woo_error_interceptor.dart';
import 'store/session.dart';

class WooCommerce {
  WooCommerce({
    required this.baseUrl,
    required this.consumerKey,
    required this.consumerSecret,
    this.apiVersion = WooApiVersion.v3,
    String? apiPath,
    this.storeApiPath = '/wp-json/wc/store/v1',
    WooCartTokenStore? cartTokenStore,
    this.authMethod = WooAuthMethod.basic,
    this.isDebug = false,
    this.useFaker = false,
    List<Interceptor>? interceptors,
  })  : apiPath = apiPath ?? '/wp-json/wc/${apiVersion.value}',
        _cartTokenStore = cartTokenStore,
        _interceptors = interceptors ?? const <Interceptor>[] {
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
    dio.interceptors.addAll(_interceptors);
    dio.interceptors.add(WooErrorInterceptor());
  }
  late final Dio dio;
  final String baseUrl;
  final String consumerKey;
  final String consumerSecret;
  final WooApiVersion apiVersion;
  final String apiPath;

  final String storeApiPath;
  final WooAuthMethod authMethod;
  final bool isDebug;
  final bool useFaker;

  final List<Interceptor> _interceptors;
  final WooCartTokenStore? _cartTokenStore;
  Dio? _storeDio;

  late final WooCartSession cartSession =
      WooCartSession(tokens: _cartTokenStore);

  Dio get storeDio => _storeDio ??= _createStoreDio();

  Dio _createStoreDio() {
    final store = Dio(
      BaseOptions(
        baseUrl: '${baseUrl.replaceAll(RegExp(r'/+$'), '')}$storeApiPath',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    if (isDebug) {
      store.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
      ));
    }
    store.interceptors.addAll(_interceptors);
    store.interceptors.add(WooErrorInterceptor());
    return store;
  }

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

  Future<Response<T>> requestStoreGet<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) =>
      _storeRequest(
        () async => storeDio.get<T>(
          path,
          queryParameters: queryParameters,
          options: await _storeOptions(options),
          cancelToken: cancelToken,
        ),
      );

  Future<Response<T>> requestStorePost<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) =>
      _storeRequest(
        () async => storeDio.post<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: await _storeOptions(options),
          cancelToken: cancelToken,
        ),
      );

  Future<Response<T>> requestStorePut<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) =>
      _storeRequest(
        () async => storeDio.put<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: await _storeOptions(options),
          cancelToken: cancelToken,
        ),
      );

  Future<Response<T>> requestStoreDelete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) =>
      _storeRequest(
        () async => storeDio.delete<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: await _storeOptions(options),
          cancelToken: cancelToken,
        ),
      );

  Future<Options> _storeOptions(Options? options) async {
    final headers = await cartSession.headers();
    if (options == null) return Options(headers: headers);
    return options.copyWith(
      headers: <String, dynamic>{...?options.headers, ...headers},
    );
  }

  Future<Response<T>> _storeRequest<T>(
    Future<Response<T>> Function() send,
  ) async {
    try {
      final response = await send();
      await cartSession.absorb(_headerMap(response.headers));
      cartSession.settle();
      return response;
    } on DioException catch (error) {
      final response = error.response;
      if (response != null) {
        await cartSession.absorb(_headerMap(response.headers));
      }
      cartSession.settle();
      final mapped = error.error;
      if (mapped is WooCommerceException) throw mapped;
      throw WooCommerceException.fromDioException(error);
    } catch (_) {
      cartSession.settle();
      rethrow;
    }
  }

  static Map<String, String> _headerMap(Headers? headers) => <String, String>{
        if (headers != null)
          for (final entry in headers.map.entries)
            entry.key: entry.value.join(','),
      };
}
