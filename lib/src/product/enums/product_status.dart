import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

enum WooProductStatus implements WooEnum {
  draft('draft'),
  pending('pending'),
  private('private'),
  publish('publish'),
  future('future'),
  unknown('unknown');

  const WooProductStatus(this.value);
  @override
  final String value;
  static WooProductStatus fake() => FakeHelper.randomItem(values);
}
