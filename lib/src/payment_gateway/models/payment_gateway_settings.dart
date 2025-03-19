import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

class WooPaymentGatewaySetting {
  final String? id;
  final String? label;
  final String? description;
  final String? type;
  final String? value;
  final String? defaultValue;
  final String? tip;
  final String? placeholder;

  WooPaymentGatewaySetting({
    this.id,
    this.label,
    this.description,
    this.type,
    this.value,
    this.defaultValue,
    this.tip,
    this.placeholder,
  });

  factory WooPaymentGatewaySetting.fromJson(Map<String, dynamic> json) =>
      WooPaymentGatewaySetting(
        id: json['id'],
        label: json['label'],
        description: json['description'],
        type: json['type'],
        value: json['value'],
        defaultValue: json['default'],
        tip: json['tip'],
        placeholder: json['placeholder'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'description': description,
        'type': type,
        'value': value,
        'default': defaultValue,
        'tip': tip,
        'placeholder': placeholder,
      };

  factory WooPaymentGatewaySetting.fake() => WooPaymentGatewaySetting(
        id: FakeHelper.word(),
        label: FakeHelper.word(),
        description: FakeHelper.sentence(),
        type: FakeHelper.randomItem(['text', 'select', 'checkbox']),
        value: FakeHelper.word(),
        defaultValue: FakeHelper.word(),
        tip: FakeHelper.sentence(),
        placeholder: FakeHelper.word(),
      );
}
