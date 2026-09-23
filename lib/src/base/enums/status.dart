import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

enum WooFilterStatus implements WooEnum {
  any('any'),
  draft('draft'),
  pending('pending'),
  private('private'),
  publish('publish'),
  unknown('unknown');

  const WooFilterStatus(this.value);
  @override
  final String value;
  static WooFilterStatus fake() => FakeHelper.randomItem(values);
}
