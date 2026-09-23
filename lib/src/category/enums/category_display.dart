import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

enum WooCategoryDisplay implements WooEnum {
  standard('default'),
  products('products'),
  subcategories('subcategories'),
  both('both'),
  unknown('unknown');

  const WooCategoryDisplay(this.value);
  @override
  final String value;
  static WooCategoryDisplay fake() => FakeHelper.randomItem(values);
}
