import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

enum WooNotificationObjectType implements WooEnum {
  order('order'),
  unknown('unknown');

  const WooNotificationObjectType(this.value);
  @override
  final String value;
  static WooNotificationObjectType fake() => FakeHelper.randomItem(values);
}
