import '../../json/woo_json.dart';
import '../../helpers/fake_helper.dart';
import 'product_tag.dart';

class WooProductTagBatchResponse {
  WooProductTagBatchResponse({this.create, this.update, this.delete});
  factory WooProductTagBatchResponse.fromJson(Map<String, dynamic> json) =>
      WooProductTagBatchResponse(
        create: WooJson.readList(json, 'create', WooProductTag.fromJson),
        update: WooJson.readList(json, 'update', WooProductTag.fromJson),
        delete: WooJson.readList(json, 'delete', WooProductTag.fromJson),
      );
  factory WooProductTagBatchResponse.fake() => WooProductTagBatchResponse(
        create: FakeHelper.list(() => WooProductTag.fake()),
        update: FakeHelper.list(() => WooProductTag.fake()),
        delete: FakeHelper.list(() => WooProductTag.fake()),
      );
  final List<WooProductTag>? create;
  final List<WooProductTag>? update;
  final List<WooProductTag>? delete;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('create', create?.map((tag) => tag.toJson()).toList())
    ..putIfPresent('update', update?.map((tag) => tag.toJson()).toList())
    ..putIfPresent('delete', delete?.map((tag) => tag.toJson()).toList());
  WooProductTagBatchResponse copyWith({
    List<WooProductTag>? create,
    List<WooProductTag>? update,
    List<WooProductTag>? delete,
  }) =>
      WooProductTagBatchResponse(
        create: create ?? this.create,
        update: update ?? this.update,
        delete: delete ?? this.delete,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductTagBatchResponse &&
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
      'WooProductTagBatchResponse(create: ${create?.length ?? 0}, '
      'update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
}
