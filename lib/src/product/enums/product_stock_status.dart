import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

enum WooProductStockStatus implements WooEnum {
  instock('instock'),
  outofstock('outofstock'),
  onbackorder('onbackorder'),
  unknown('unknown');

  const WooProductStockStatus(this.value);
  @override
  final String value;
  static WooProductStockStatus fake() => FakeHelper.randomItem(values);
}
