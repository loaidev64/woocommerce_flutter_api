import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

enum WooProductFilterWithType implements WooEnum {
  relatedIds('related_ids'),
  upsellIds('upsell_ids'),
  crossSellIds('cross_sell_ids'),
  parentId('parent_id'),
  variations('variations'),
  groupedProducts('grouped_products'),
  unknown('unknown');

  const WooProductFilterWithType(this.value);
  @override
  final String value;
  static WooProductFilterWithType fake() => FakeHelper.randomItem(values);
}
