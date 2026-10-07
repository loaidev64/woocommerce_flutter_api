import 'package:dio/dio.dart';

const Map<String, dynamic> _usd = <String, dynamic>{
  'currency_code': 'USD',
  'currency_symbol': r'$',
  'currency_minor_unit': 2,
  'currency_decimal_separator': '.',
  'currency_thousand_separator': ',',
  'currency_prefix': r'$',
  'currency_suffix': '',
};

/// A fake Store API for `woocommerce_flutter_api` tests.
///
/// It records every request, replays scripted responses, and issues a
/// `Cart-Token` the way a real store does — so the cart-session bookkeeping can
/// be exercised without a network.
class FakeStoreApi extends Interceptor {
  FakeStoreApi({
    required this.reply,
    this.issueToken = 'cart-token-1',
  });

  /// Builds the response data for a request. Return a [DioException] to fail.
  final Object? Function(RequestOptions options) reply;

  /// The token to hand back on cart routes, or null to hand back none.
  final String? issueToken;

  /// Every request made, in order.
  final List<RequestOptions> calls = <RequestOptions>[];

  /// The last request's URI.
  Uri get lastUri => calls.last.uri;

  /// The last request's decoded body.
  Map<String, dynamic> get lastBody =>
      (calls.last.data as Map).cast<String, dynamic>();

  /// The `Cart-Token` header sent on the last request, if any.
  String? get lastSentToken {
    final headers = calls.last.headers;
    return (headers['Cart-Token'] ?? headers['cart-token']) as String?;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    calls.add(options);
    final result = reply(options);
    if (result is DioException) {
      return handler.reject(result);
    }
    return handler.resolve(
      Response<dynamic>(
        requestOptions: options,
        statusCode: 200,
        data: result,
        headers: Headers.fromMap(<String, List<String>>{
          'content-type': <String>['application/json; charset=utf-8'],
          if (issueToken != null) 'cart-token': <String>[issueToken!],
        }),
      ),
    );
  }
}

/// A cart as the Store API actually sends one, trimmed of the longest tails.
Map<String, dynamic> cartJson({
  int quantity = 1,
  String totalPrice = '8256',
  List<Object?>? errors,
}) =>
    <String, dynamic>{
      'items': <Object?>[
        <String, dynamic>{
          'key': 'a5771bce93e200c36f7cd9dfd0e5deaa',
          'id': 38,
          'quantity': quantity,
          'name': 'Beanie with Logo',
          'sku': 'Woo-beanie-logo',
          'permalink': 'https://shop.test/product/beanie/',
          'short_description': '<p>A beanie</p>',
          'prices': <String, dynamic>{
            'currency_code': 'USD',
            'currency_symbol': r'$',
            'currency_minor_unit': 2,
            'currency_decimal_separator': '.',
            'currency_thousand_separator': ',',
            'currency_prefix': r'$',
            'currency_suffix': '',
            'price': '1800',
            'regular_price': '2000',
            'sale_price': '1800',
          },
          'totals': <String, dynamic>{
            'line_subtotal': '2000',
            'line_total': '1800',
          },
          'quantity_limits': <String, dynamic>{
            'minimum': 1,
            'maximum': 12,
            'multiple_of': 2,
            'editable': true,
          },
          'variation': <Object?>[
            <String, dynamic>{'attribute': 'pa_colour', 'value': 'blue'},
          ],
          'images': <Object?>[
            <String, dynamic>{
              'id': 11,
              'src': 'https://shop.test/images/beanie.jpg',
              'thumbnail': 'https://shop.test/images/beanie-450x450.jpg',
              'alt': 'Beanie',
            },
          ],
          'low_stock_remaining': null,
          'backorders_allowed': false,
          'sold_individually': false,
        },
      ],
      'coupons': <Object?>[
        <String, dynamic>{
          'code': 'save10',
          'discount_type': 'percent',
          'totals': <String, dynamic>{
            'total_discount': '1095',
            'total_discount_tax': '100',
          },
        },
      ],
      'totals': <String, dynamic>{
        'currency_code': 'USD',
        'currency_symbol': r'$',
        'currency_minor_unit': 2,
        'currency_decimal_separator': '.',
        'currency_thousand_separator': ',',
        'currency_prefix': r'$',
        'currency_suffix': '',
        'total_items': '2000',
        'total_items_tax': '0',
        'total_fees': '0',
        'total_discount': '1095',
        'total_shipping': '1300',
        'total_shipping_tax': '0',
        'total_tax': '0',
        'total_price': totalPrice,
      },
      'billing_address': <String, dynamic>{
        'first_name': 'John',
        'last_name': 'Doe',
        'address_1': '1 Main St',
        'city': 'London',
        'postcode': 'N1 7GU',
        'country': 'GB',
        'email': 'john@example.com',
      },
      'shipping_address': <String, dynamic>{
        'first_name': 'John',
        'last_name': 'Doe',
        'address_1': '1 Main St',
        'city': 'London',
        'postcode': 'N1 7GU',
        'country': 'GB',
      },
      'shipping_rates': <Object?>[
        <String, dynamic>{
          'package_id': 0,
          'name': 'Shipment 1',
          'destination': <String, dynamic>{
            'country': 'GB',
            'postcode': 'N1 7GU',
          },
          'items': <Object?>[
            <String, dynamic>{'name': 'Beanie with Logo'},
          ],
          'shipping_rates': <Object?>[
            <String, dynamic>{
              'rate_id': 'flat_rate:10',
              'name': 'Flat rate',
              'description': '',
              'delivery_time': '',
              'price': '1300',
              'taxes': '0',
              'method_id': 'flat_rate',
              'instance_id': 10,
              'selected': true,
              ..._usd,
            },
            <String, dynamic>{
              'rate_id': 'free_shipping:11',
              'name': 'Free shipping',
              'price': '0',
              'taxes': '0',
              'selected': false,
              ..._usd,
            },
          ],
        },
      ],
      'items_count': 1,
      'items_weight': 0.5,
      'needs_payment': true,
      'needs_shipping': true,
      'has_calculated_shipping': true,
      'payment_methods': <Object?>['cod', 'bacs'],
      'errors': errors ?? <Object?>[],
    };

/// A checkout as the Store API sends one.
Map<String, dynamic> checkoutJson({
  int orderId = 146,
  String status = 'checkout-draft',
  String paymentStatus = '',
  String redirectUrl = '',
}) =>
    <String, dynamic>{
      'order_id': orderId,
      'status': status,
      'order_key': 'wc_order_abc123',
      'customer_id': 0,
      'customer_note': '',
      'payment_method': 'cod',
      'billing_address': <String, dynamic>{
        'first_name': 'Ada',
        'last_name': 'Lovelace',
        'address_1': '12 Analytical Way',
        'city': 'London',
        'postcode': 'N1 7GU',
        'country': 'GB',
        'email': 'ada@example.com',
      },
      'shipping_address': <String, dynamic>{
        'first_name': 'Ada',
        'last_name': 'Lovelace',
        'address_1': '12 Analytical Way',
        'city': 'London',
        'postcode': 'N1 7GU',
        'country': 'GB',
      },
      'payment_result': <String, dynamic>{
        'payment_status': paymentStatus,
        'redirect_url': redirectUrl,
        'payment_details': <Object?>[],
      },
      'additional_fields': <String, dynamic>{},
    };

/// An error body shaped the way WooCommerce shapes them, as a [DioException].
DioException wooStoreError(
  RequestOptions options,
  int status,
  String code,
  String message, {
  Map<String, dynamic>? data,
}) =>
    DioException(
      requestOptions: options,
      type: DioExceptionType.badResponse,
      response: Response<dynamic>(
        requestOptions: options,
        statusCode: status,
        data: <String, dynamic>{
          'code': code,
          'message': message,
          'data': <String, dynamic>{'status': status, ...?data},
        },
      ),
    );
