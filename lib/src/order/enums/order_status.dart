import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

enum WooOrderStatus implements WooEnum {
  any('any'),
  pending('pending'),
  processing('processing'),
  onHold('on-hold'),
  completed('completed'),
  cancelled('cancelled'),
  refunded('refunded'),
  failed('failed'),
  trash('trash'),
  unknown('unknown');

  const WooOrderStatus(this.value);
  @override
  final String value;
  static WooOrderStatus fake() => FakeHelper.randomItem(values);
}
