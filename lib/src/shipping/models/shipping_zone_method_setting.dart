import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

class WooShippingZoneMethodSetting {

  WooShippingZoneMethodSetting({
    this.id,
    this.label,
    this.description,
    this.type,
    this.value,
    this.defaultValue,
    this.tip,
    this.placeholder,
  });

  factory WooShippingZoneMethodSetting.fromJson(Map<String, dynamic> json) =>
      WooShippingZoneMethodSetting(
        id: json['id'],
        label: json['label'],
        description: json['description'],
        type: json['type'],
        value: json['value'],
        defaultValue: json['default'],
        tip: json['tip'],
        placeholder: json['placeholder'],
      );

  factory WooShippingZoneMethodSetting.fake() => WooShippingZoneMethodSetting(
        id: FakeHelper.word(),
        label: FakeHelper.sentence(),
        description: FakeHelper.sentence(),
        type: FakeHelper.randomItem(const ['text', 'select', 'checkbox']),
        value: FakeHelper.word(),
        defaultValue: FakeHelper.word(),
        tip: FakeHelper.sentence(),
        placeholder: FakeHelper.word(),
      );
  final String? id;
  final String? label;
  final String? description;
  final String? type;
  final String? value;
  final String? defaultValue;
  final String? tip;
  final String? placeholder;

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
}
