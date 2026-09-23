import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

enum WooOrderTaxStatus implements WooEnum {
  taxable('taxable'),
  none('none'),
  unknown('unknown');

  const WooOrderTaxStatus(this.value);
  @override
  final String value;
  static WooOrderTaxStatus fake() => FakeHelper.randomItem(values);
}
