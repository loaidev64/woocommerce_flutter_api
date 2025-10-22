import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

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
        id: json['id'],
        name: json['name'],
        action: json['action'],
        description: json['description'],
        // success and message are write-only in responses
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'action': action,
        'description': description,
        'success': success,
        'message': message,
        'confirm': confirm,
      };
}
