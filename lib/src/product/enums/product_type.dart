import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

enum WooProductType implements WooEnum {
  simple('simple'),
  grouped('grouped'),
  external('external'),
  variable('variable'),
  unknown('unknown');

  const WooProductType(this.value);
  @override
  final String value;
  static WooProductType fake() => FakeHelper.randomItem(values);
}
