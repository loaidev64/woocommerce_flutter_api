import 'package:test/test.dart';
import 'package:woocommerce_flutter_api/src/order/enums/order_status.dart';
import 'package:woocommerce_flutter_api/src/order/models/order.dart';

void main() {
  group('WooOrder.fromJson (real WooCommerce v3 payload)', () {
    const orderJson = {
      'id': 728,
      'parent_id': 0,
      'number': '728',
      'order_key': 'wc_order_5f9e4d666cd44',
      'created_via': 'checkout',
      'version': '5.5.1',
      'status': 'on-hold',
      'currency': 'USD',
      'date_created': '2023-03-23T15:35:30',
      'date_created_gmt': '2023-03-23T12:35:30',
      'date_modified': '2023-03-23T15:35:33',
      'date_modified_gmt': '2023-03-23T12:35:33',
      'discount_total': '0.00',
      'discount_tax': '0.00',
      'shipping_total': '0.00',
      'shipping_tax': '0.00',
      'cart_tax': '0.00',
      'total': '60.00',
      'total_tax': '0.00',
      'prices_include_tax': false,
      'customer_id': 1,
      'customer_ip_address': '',
      'customer_user_agent': '',
      'customer_note': '',
      'billing': {
        'first_name': 'John',
        'last_name': 'Doe',
        'company': '',
        'address_1': '969 Market St',
        'address_2': '',
        'city': 'San Francisco',
        'state': 'CA',
        'postcode': '94103',
        'country': 'US',
        'email': 'john.doe@example.com',
        'phone': '555-555-5555',
      },
      'shipping': {
        'first_name': 'John',
        'last_name': 'Doe',
        'company': '',
        'address_1': '969 Market St',
        'address_2': '',
        'city': 'San Francisco',
        'state': 'CA',
        'postcode': '94103',
        'country': 'US',
      },
      'payment_method': 'bacs',
      'payment_method_title': 'Direct bank transfer',
      'transaction_id': '',
      'line_items': [
        {
          'id': 13,
          'name': 'Album',
          'product_id': 93,
          'variation_id': 0,
          'quantity': 1,
          'tax_class': '',
          'subtotal': '30.00',
          'subtotal_tax': '0.00',
          'total': '30.00',
          'total_tax': '0.00',
          'price': 30,
        },
      ],
      'tax_lines': [],
      'shipping_lines': [],
      'fee_lines': [],
      'coupon_lines': [],
      'refunds': [],
    };

    test('parses a real order without throwing', () {
      final order = WooOrder.fromJson(orderJson);
      expect(order.id, 728);
      expect(order.total, 60.00);
      expect(order.dateCreated, isNotNull);
    });

    test('parses wire status on-hold', () {
      final order = WooOrder.fromJson(orderJson);
      expect(order.status, WooOrderStatus.onHold);
    });

    test('order status round-trips on-hold', () {
      final order = WooOrder.fromJson(orderJson);
      final json = order.toJson();
      expect(json['status'], 'on-hold');
    });

    test('unknown plugin status does not silently become pending', () {
      final json = {...orderJson, 'status': 'wc-custom-status'};
      final order = WooOrder.fromJson(json);
      expect(order.status, isNot(WooOrderStatus.pending));
    });
  });

  group('WooOrderStatus wire values', () {
    test('onHold serializes as on-hold', () {
      expect(WooOrderStatus.onHold.value, 'on-hold');
    });

    test('fake() can produce the last value', () {
      final seen = <WooOrderStatus>{};
      for (var i = 0; i < 200; i++) {
        seen.add(WooOrderStatus.fake());
      }
      expect(seen.contains(WooOrderStatus.values.last), isTrue);
    });
  });
}
