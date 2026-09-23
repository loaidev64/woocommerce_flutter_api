import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

enum WooOrderNoteType implements WooEnum {
  any('any'),
  customer('customer'),
  internal('internal'),
  unknown('unknown');

  const WooOrderNoteType(this.value);
  @override
  final String value;
  static WooOrderNoteType fake() => FakeHelper.randomItem(values);
}
