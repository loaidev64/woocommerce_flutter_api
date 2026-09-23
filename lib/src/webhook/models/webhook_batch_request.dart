import '../../json/woo_json.dart';
import '../../helpers/fake_helper.dart';
import 'webhook.dart';

class WooWebhookBatchRequest {
  WooWebhookBatchRequest({this.create, this.update, this.delete});
  factory WooWebhookBatchRequest.fromJson(Map<String, dynamic> json) =>
      WooWebhookBatchRequest(
        create: WooJson.readList(json, 'create', WooWebhook.fromJson),
        update: WooJson.readList(json, 'update', WooWebhook.fromJson),
        delete: WooJson.readIntList(json, 'delete'),
      );
  factory WooWebhookBatchRequest.fake() => WooWebhookBatchRequest(
        create: FakeHelper.list(() => WooWebhook.fake()),
        update: FakeHelper.list(() => WooWebhook.fake()),
        delete: FakeHelper.listOfIntegers(),
      );
  final List<WooWebhook>? create;
  final List<WooWebhook>? update;
  final List<int>? delete;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent(
        'create', create?.map((webhook) => webhook.toJson()).toList())
    ..putIfPresent(
        'update', update?.map((webhook) => webhook.toJson()).toList())
    ..putIfPresent('delete', delete);
  WooWebhookBatchRequest copyWith({
    List<WooWebhook>? create,
    List<WooWebhook>? update,
    List<int>? delete,
  }) =>
      WooWebhookBatchRequest(
        create: create ?? this.create,
        update: update ?? this.update,
        delete: delete ?? this.delete,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooWebhookBatchRequest &&
          WooJson.listEquals(other.create, create) &&
          WooJson.listEquals(other.update, update) &&
          WooJson.listEquals(other.delete, delete);
  @override
  int get hashCode => Object.hashAll([
        ...(create ?? const []),
        ...(update ?? const []),
        ...(delete ?? const []),
      ]);
  @override
  String toString() => 'WooWebhookBatchRequest(create: ${create?.length ?? 0}, '
      'update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
}
