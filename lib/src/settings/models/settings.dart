import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

class WooSettings {
  /// A unique identifier that can be used to link settings together.
  final String? id;

  /// A human readable label for the setting used in interfaces.
  final String? label;

  /// A human readable description for the setting used in interfaces.
  final String? description;

  /// ID of parent grouping.
  final String? parentId;

  /// IDs for settings sub groups.
  final List<String>? subGroups;

  WooSettings({
    this.id,
    this.label,
    this.description,
    this.parentId,
    this.subGroups,
  });

  WooSettings.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    label = json['label'],
    description = json['description'],
    parentId = json['parent_id'],
    subGroups = json['sub_groups'] != null 
      ? List<String>.from(json['sub_groups'])
      : null;

  Map<String, dynamic> toJson() => {
    'id': id,
    'label': label,
    'description': description,
    'parent_id': parentId,
    'sub_groups': subGroups,
  };

  factory WooSettings.fake() => WooSettings(
    id: FakeHelper.word(),
    label: FakeHelper.sentence(),
    description: FakeHelper.sentence(),
    parentId: FakeHelper.word(),
    subGroups: FakeHelper.list(() => FakeHelper.word()),
  );
}