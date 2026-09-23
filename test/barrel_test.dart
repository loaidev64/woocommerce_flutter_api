import 'dart:convert';

import 'package:test/test.dart';
import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

void main() {
  test('package barrel exposes core infrastructure', () {
    expect(WooJson.readString(<String, dynamic>{'k': 'v'}, 'k'), 'v');
    expect(WooSort.asc.value, 'asc');
    expect(WooOrderBy.dateGmt.value, 'date_gmt');
    expect(WooSort.fake(), isNotNull);
    expect(
      WooDeleteResult.fromJson(<String, dynamic>{'id': 5, 'deleted': true}).id,
      5,
    );
    expect(WooMetaData.fake().value, isNotNull);
  });

  test('client construction — basic auth', () {
    final woo = WooCommerce(
      baseUrl: 'https://store.test',
      consumerKey: 'ck_test',
      consumerSecret: 'cs_test',
    );
    expect(woo.apiPath, '/wp-json/wc/v3');
    expect(woo.dio.options.baseUrl, 'https://store.test/wp-json/wc/v3');
    expect(
      woo.dio.options.headers['Authorization'],
      'Basic ${WooCommerce.basicAuth('ck_test', 'cs_test')}',
    );
    expect(woo.dio.interceptors.any((i) => i is WooErrorInterceptor), isTrue);
  });

  test('client construction — v4 and query-string auth', () {
    final woo = WooCommerce(
      baseUrl: 'https://store.test',
      consumerKey: 'ck_test',
      consumerSecret: 'cs_test',
      apiVersion: WooApiVersion.v4,
      authMethod: WooAuthMethod.queryString,
    );
    expect(woo.apiPath, '/wp-json/wc/v4');
    expect(woo.dio.options.queryParameters['consumer_key'], 'ck_test');
    expect(
        woo.dio.options.queryParameters.containsKey('consumer_secret'), isTrue);
    expect(woo.dio.options.headers.containsKey('Authorization'), isFalse);
  });

  test('client construction — custom apiPath wins over version', () {
    final woo = WooCommerce(
      baseUrl: 'https://store.test',
      consumerKey: 'ck',
      consumerSecret: 'cs',
      apiPath: '/wp-json/custom/v1',
    );
    expect(woo.apiPath, '/wp-json/custom/v1');
  });

  test('basicAuth matches base64(ck:cs)', () {
    expect(WooCommerce.basicAuth('a', 'b'), base64Encode(utf8.encode('a:b')));
  });

  test('debug logging defaults to off', () {
    final woo = WooCommerce(
      baseUrl: 'https://store.test',
      consumerKey: 'ck',
      consumerSecret: 'cs',
    );
    expect(woo.isDebug, isFalse);
    expect(woo.dio.interceptors.whereType<WooLogInterceptor>(), isEmpty);
  });
}
