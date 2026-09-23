import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

enum WooContext implements WooEnum {
  view('view'),
  edit('edit'),
  unknown('unknown');

  const WooContext(this.value);
  @override
  final String value;
  static WooContext fake() => FakeHelper.randomItem(values);
}
