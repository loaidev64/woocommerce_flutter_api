import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

enum WooWebhookStatus implements WooEnum {
  active('active'),
  paused('paused'),
  disabled('disabled'),
  unknown('unknown');

  const WooWebhookStatus(this.value);
  @override
  final String value;
  static WooWebhookStatus fake() => FakeHelper.randomItem(values);
}
