import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

enum WooProductAttributeType implements WooEnum {
  select('select'),
  button('button'),
  unknown('unknown');

  const WooProductAttributeType(this.value);
  @override
  final String value;
  static WooProductAttributeType fake() => FakeHelper.randomItem(values);
}
