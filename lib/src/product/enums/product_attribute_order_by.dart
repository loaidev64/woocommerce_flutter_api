import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

enum WooProductAttributeOrderBy implements WooEnum {
  menuOrder('menu_order'),
  name('name'),
  nameNum('name_num'),
  id('id'),
  unknown('unknown');

  const WooProductAttributeOrderBy(this.value);
  @override
  final String value;
  static WooProductAttributeOrderBy fake() => FakeHelper.randomItem(values);
}
