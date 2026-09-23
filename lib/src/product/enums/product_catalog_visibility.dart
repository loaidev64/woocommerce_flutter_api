import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

enum WooProductCatalogVisibility implements WooEnum {
  visible('visible'),
  catalog('catalog'),
  search('search'),
  hidden('hidden'),
  unknown('unknown');

  const WooProductCatalogVisibility(this.value);
  @override
  final String value;
  static WooProductCatalogVisibility fake() => FakeHelper.randomItem(values);
}
