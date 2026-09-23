import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

enum WooCustomerRole implements WooEnum {
  all('all'),
  administrator('administrator'),
  editor('editor'),
  author('author'),
  contributor('contributor'),
  subscriber('subscriber'),
  customer('customer'),
  shopManager('shop_manager'),
  unknown('unknown');

  const WooCustomerRole(this.value);
  @override
  final String value;
  static WooCustomerRole fake() => FakeHelper.randomItem(values);
}
