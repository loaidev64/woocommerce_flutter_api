import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';
import 'order.dart';

class WooOrderBatchRequest {
  WooOrderBatchRequest({
    this.create,
    this.update,
    this.delete,
  });
  factory WooOrderBatchRequest.fromJson(Map<String, dynamic> json) =>
      WooOrderBatchRequest(
        create: WooJson.readList(json, 'create', WooOrder.fromJson),
        update: WooJson.readList(json, 'update', WooOrder.fromJson),
        delete: WooJson.readIntList(json, 'delete'),
      );
  factory WooOrderBatchRequest.fake() => WooOrderBatchRequest(
        create: FakeHelper.list(() => WooOrder.fake()),
        update: FakeHelper.list(() => WooOrder.fake()),
        delete: FakeHelper.listOfIntegers(),
      );
  final List<WooOrder>? create;
  final List<WooOrder>? update;
  final List<int>? delete;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('create', create?.map((order) => order.toJson()).toList())
    ..putIfPresent('update', update?.map((order) => order.toJson()).toList())
    ..putIfPresent('delete', delete);
  WooOrderBatchRequest copyWith({
    List<WooOrder>? create,
    List<WooOrder>? update,
    List<int>? delete,
  }) =>
      WooOrderBatchRequest(
        create: create ?? this.create,
        update: update ?? this.update,
        delete: delete ?? this.delete,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooOrderBatchRequest &&
          WooJson.listEquals(other.create, create) &&
          WooJson.listEquals(other.update, update) &&
          WooJson.listEquals(other.delete, delete);
  @override
  int get hashCode => Object.hashAll([...?create, ...?update, ...?delete]);
  @override
  String toString() {
    return 'WooOrderBatchRequest(create: ${create?.length ?? 0}, update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
  }
}
