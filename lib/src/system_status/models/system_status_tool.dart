import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooSystemStatusTool {
  WooSystemStatusTool({
    this.id,
    this.name,
    this.action,
    this.description,
    this.success,
    this.message,
    this.confirm,
  });
  factory WooSystemStatusTool.fromJson(Map<String, dynamic> json) =>
      WooSystemStatusTool(
        id: WooJson.readString(json, 'id'),
        name: WooJson.readString(json, 'name'),
        action: WooJson.readString(json, 'action'),
        description: WooJson.readString(json, 'description'),
        success: WooJson.readBool(json, 'success'),
        message: WooJson.readString(json, 'message'),
        confirm: WooJson.readBool(json, 'confirm'),
      );
  factory WooSystemStatusTool.fake() => WooSystemStatusTool(
        id: FakeHelper.word(),
        name: FakeHelper.word(),
        action: FakeHelper.word(),
        description: FakeHelper.sentence(),
      );
  final String? id;
  final String? name;
  final String? action;
  final String? description;
  final bool? success;
  final String? message;
  final bool? confirm;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putIfPresent('name', name)
    ..putIfPresent('action', action)
    ..putIfPresent('description', description)
    ..putIfPresent('success', success)
    ..putIfPresent('message', message)
    ..putIfPresent('confirm', confirm);
  WooSystemStatusTool copyWith({
    String? id,
    String? name,
    String? action,
    String? description,
    bool? success,
    String? message,
    bool? confirm,
  }) =>
      WooSystemStatusTool(
        id: id ?? this.id,
        name: name ?? this.name,
        action: action ?? this.action,
        description: description ?? this.description,
        success: success ?? this.success,
        message: message ?? this.message,
        confirm: confirm ?? this.confirm,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooSystemStatusTool &&
        other.id == id &&
        other.name == name &&
        other.action == action &&
        other.description == description &&
        other.success == success &&
        other.message == message &&
        other.confirm == confirm;
  }

  @override
  int get hashCode =>
      Object.hash(id, name, action, description, success, message, confirm);
  @override
  String toString() => 'WooSystemStatusTool(id: $id, name: $name)';
}
