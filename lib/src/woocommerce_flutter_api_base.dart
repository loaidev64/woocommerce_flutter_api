import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// The class that holds all of the methods
///
/// if you want to call some api that it's not already implemented in
/// this class you can use [dio] object to call the api
class WooCommerce {
  late final Dio dio;

  /// [baseUrl] is the base url of your site. For example, http://me.com or https://me.com.
  final String baseUrl;

  /// [username] is the consumer key provided by WooCommerce, e.g. `ck_12abc34n56j`.
  final String username;

  /// [password] is the consumer secret provided by WooCommerce, e.g. `cs_1uab8h3s3op`.
  final String password;

  /// [apiPath], tells the SDK if there is a different path to your api installation.
  /// Useful if the websites woocommerce api path have been modified.
  final String? apiPath;

  /// [isDebug], tells the library if it should _printToLog debug logs.
  /// Useful if you are debuging or in development.
  final bool isDebug;

  /// [useFaker], fakes all api requests
  final bool useFaker;

  WooCommerce({
    required this.baseUrl,
    required this.username,
    required this.password,
    this.apiPath = '/wp-json/wc/v3',
    this.isDebug = true,
    this.useFaker = false,
  }) {
    final authToken = base64.encode(utf8.encode('$username:$password'));
    dio = Dio(
      BaseOptions(
        baseUrl: '$baseUrl$apiPath',
        headers: {
          HttpHeaders.authorizationHeader: 'Basic $authToken',
        },
      ),
    );

    if (isDebug) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
      ));
    }
  }
}
