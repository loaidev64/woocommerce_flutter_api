import '../../json/woo_json.dart';
import '../../helpers/fake_helper.dart';
import 'webhook.dart';

class WooWebhookBatchResponse {
  WooWebhookBatchResponse({this.create, this.update, this.delete});
  factory WooWebhookBatchResponse.fromJson(Map<String, dynamic> json) =>
      WooWebhookBatchResponse(
        create: WooJson.readList(json, 'create', WooWebhook.fromJson),
        update: WooJson.readList(json, 'update', WooWebhook.fromJson),
        delete: WooJson.readList(json, 'delete', WooWebhook.fromJson),
      );
  factory WooWebhookBatchResponse.fake() => WooWebhookBatchResponse(
        create: FakeHelper.list(() => WooWebhook.fake()),
        update: FakeHelper.list(() => WooWebhook.fake()),
        delete: FakeHelper.list(() => WooWebhook.fake()),
      );
  final List<WooWebhook>? create;
  final List<WooWebhook>? update;
  final List<WooWebhook>? delete;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent(
        'create', create?.map((webhook) => webhook.toJson()).toList())
    ..putIfPresent(
        'update', update?.map((webhook) => webhook.toJson()).toList())
    ..putIfPresent(
        'delete', delete?.map((webhook) => webhook.toJson()).toList());
  WooWebhookBatchResponse copyWith({
    List<WooWebhook>? create,
    List<WooWebhook>? update,
    List<WooWebhook>? delete,
  }) =>
      WooWebhookBatchResponse(
        create: create ?? this.create,
        update: update ?? this.update,
        delete: delete ?? this.delete,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooWebhookBatchResponse &&
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
  String toString() =>
      'WooWebhookBatchResponse(create: ${create?.length ?? 0}, '
      'update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
}
