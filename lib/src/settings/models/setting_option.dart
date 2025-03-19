import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

class WooSettingOption {
  /// A unique identifier for the setting.
  final String? id;

  /// A human readable label for the setting used in interfaces.
  final String? label;

  /// A human readable description for the setting used in interfaces.
  final String? description;

  /// Setting value.
  final dynamic value;

  /// Default value for the setting.
  final dynamic defaultValue;

  /// Additional help text shown to the user about the setting.
  final String? tip;

  /// Placeholder text to be displayed in text inputs.
  final String? placeholder;

  /// Type of setting.
  final String? type;

  /// Array of options for inputs.
  final Map<String, dynamic>? options;

  /// An identifier for the group this setting belongs to.
  final String? groupId;

  WooSettingOption({
    this.id,
    this.label,
    this.description,
    this.value,
    this.defaultValue,
    this.tip,
    this.placeholder,
    this.type,
    this.options,
    this.groupId,
  });

  WooSettingOption.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        label = json['label'],
        description = json['description'],
        value = json['value'],
        defaultValue = json['default'],
        tip = json['tip'],
        placeholder = json['placeholder'],
        type = json['type'],
        options = json['options'] != null
            ? Map<String, dynamic>.from(json['options'])
            : null,
        groupId = json['group_id'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'description': description,
        'value': value,
        'default': defaultValue,
        'tip': tip,
        'placeholder': placeholder,
        'type': type,
        'options': options,
        'group_id': groupId,
      };

  factory WooSettingOption.fake() => WooSettingOption(
        id: FakeHelper.word(),
        label: FakeHelper.sentence(),
        description: FakeHelper.sentence(),
        value: FakeHelper.word(),
        defaultValue: FakeHelper.word(),
        tip: FakeHelper.sentence(),
        placeholder: FakeHelper.word(),
        type: FakeHelper.randomItem(['text', 'select', 'checkbox']),
        options: {
          FakeHelper.word(): FakeHelper.sentence(),
          FakeHelper.word(): FakeHelper.sentence(),
          FakeHelper.word(): FakeHelper.sentence(),
        },
        groupId: FakeHelper.word(),
      );
}
