import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

enum WooProductBackorder implements WooEnum {
  no('no'),
  notify('notify'),
  yes('yes'),
  unknown('unknown');

  const WooProductBackorder(this.value);
  @override
  final String value;
  static WooProductBackorder fake() => FakeHelper.randomItem(values);
}
