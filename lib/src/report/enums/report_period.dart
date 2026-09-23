import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

enum WooReportPeriod implements WooEnum {
  week('week'),
  month('month'),
  lastMonth('last_month'),
  year('year'),
  unknown('unknown');

  const WooReportPeriod(this.value);
  @override
  final String value;
  static WooReportPeriod fake() => FakeHelper.randomItem(values);
}
