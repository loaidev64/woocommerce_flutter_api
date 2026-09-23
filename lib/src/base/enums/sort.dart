import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

enum WooSort implements WooEnum {
  asc('asc'),
  desc('desc'),
  unknown('unknown');

  const WooSort(this.value);
  @override
  final String value;
  static WooSort fake() => FakeHelper.randomItem(values);
}

enum WooOrderBy implements WooEnum {
  date('date'),
  dateGmt('date_gmt'),
  modified('modified'),
  id('id'),
  include('include'),
  title('title'),
  name('name'),
  slug('slug'),
  termGroup('term_group'),
  description('description'),
  count('count'),
  price('price'),
  popularity('popularity'),
  rating('rating'),
  menuOrder('menu_order'),
  registeredDate('registered_date'),
  unknown('unknown');

  const WooOrderBy(this.value);
  @override
  final String value;
  static WooOrderBy fake() => FakeHelper.randomItem(values);
}
