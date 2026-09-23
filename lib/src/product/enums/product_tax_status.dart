import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

enum WooProductTaxStatus implements WooEnum {
  taxable('taxable'),
  shipping('shipping'),
  none('none'),
  unknown('unknown');

  const WooProductTaxStatus(this.value);
  @override
  final String value;
  static WooProductTaxStatus fake() => FakeHelper.randomItem(values);
}
