import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

enum WooApiVersion implements WooEnum {
  v3('v3'),
  v4('v4'),
  unknown('unknown');

  const WooApiVersion(this.value);
  @override
  final String value;
  static WooApiVersion fake() => FakeHelper.randomItem(values);
}

enum WooAuthMethod implements WooEnum {
  basic('basic'),
  queryString('query_string'),
  unknown('unknown');

  const WooAuthMethod(this.value);
  @override
  final String value;
  static WooAuthMethod fake() => FakeHelper.randomItem(values);
}
