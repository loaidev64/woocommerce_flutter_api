import '../../json/woo_json.dart';
import '../../helpers/fake_helper.dart';
import 'product_tag.dart';

class WooProductTagBatchRequest {
  WooProductTagBatchRequest({this.create, this.update, this.delete});
  factory WooProductTagBatchRequest.fromJson(Map<String, dynamic> json) =>
      WooProductTagBatchRequest(
        create: WooJson.readList(json, 'create', WooProductTag.fromJson),
        update: WooJson.readList(json, 'update', WooProductTag.fromJson),
        delete: WooJson.readIntList(json, 'delete'),
      );
  factory WooProductTagBatchRequest.fake() => WooProductTagBatchRequest(
        create: FakeHelper.list(() => WooProductTag.fake()),
        update: FakeHelper.list(() => WooProductTag.fake()),
        delete: FakeHelper.listOfIntegers(),
      );
  final List<WooProductTag>? create;
  final List<WooProductTag>? update;
  final List<int>? delete;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('create', create?.map((tag) => tag.toJson()).toList())
    ..putIfPresent('update', update?.map((tag) => tag.toJson()).toList())
    ..putIfPresent('delete', delete);
  WooProductTagBatchRequest copyWith({
    List<WooProductTag>? create,
    List<WooProductTag>? update,
    List<int>? delete,
  }) =>
      WooProductTagBatchRequest(
        create: create ?? this.create,
        update: update ?? this.update,
        delete: delete ?? this.delete,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductTagBatchRequest &&
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
      'WooProductTagBatchRequest(create: ${create?.length ?? 0}, '
      'update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
}
