import 'package:test/test.dart';
import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

void main() {
  group('enum wire values', () {
    test('order status', () {
      expect(WooOrderStatus.onHold.value, 'on-hold');
      expect(WooOrderStatus.completed.value, 'completed');
      expect(WooOrderStatus.unknown.value, 'unknown');
      expect(
        WooOrderStatus.values.map((s) => s.value),
        containsAll(['pending', 'processing', 'refunded', 'failed', 'trash']),
      );
    });

    test('category display has no trailing-underscore hack', () {
      expect(WooCategoryDisplay.standard.value, 'default');
      expect(WooCategoryDisplay.unknown.value, 'unknown');
    });

    test('product status includes future and unknown', () {
      expect(WooProductStatus.future.value, 'future');
      expect(WooProductStatus.unknown.value, 'unknown');
    });

    test('currency constants are ISO codes', () {
      expect(WooCurrency.usd, 'USD');
      expect(WooCurrency.eur, 'EUR');
      expect(WooCurrency.fake(), matches(RegExp(r'^[A-Z]{3}$')));
    });
  });

  group('WooJson.readEnum', () {
    test('parses wire values', () {
      expect(
        WooJson.readEnum(
          <String, dynamic>{'status': 'on-hold'},
          'status',
          WooOrderStatus.values,
        ),
        WooOrderStatus.onHold,
      );
    });

    test('unknown plugin statuses fall back to unknown member', () {
      expect(
        WooJson.readEnum(
          <String, dynamic>{'status': 'wc-custom-plugin-status'},
          'status',
          WooOrderStatus.values,
        ),
        WooOrderStatus.unknown,
      );
    });

    test('missing key returns null', () {
      expect(
        WooJson.readEnum(<String, dynamic>{}, 'status', WooOrderStatus.values),
        isNull,
      );
    });
  });

  group('enum fake() coverage', () {
    test('fake() can produce every value including the last', () {
      final suites = <(List<Enum>, Enum Function())>[
        (WooOrderStatus.values, WooOrderStatus.fake),
        (WooProductStatus.values, WooProductStatus.fake),
        (WooProductType.values, WooProductType.fake),
        (WooProductStockStatus.values, WooProductStockStatus.fake),
      ];
      for (final (values, fake) in suites) {
        final generated = <Enum>{
          for (var i = 0; i < values.length * 50; i++) fake(),
        };
        expect(generated.contains(values.last), isTrue, reason: '$values');
      }
    });
  });
}
