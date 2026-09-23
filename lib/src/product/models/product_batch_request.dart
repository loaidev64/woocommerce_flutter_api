import '../../json/woo_json.dart';
import '../../helpers/fake_helper.dart';
import 'product.dart';

class WooProductBatchRequest {
  WooProductBatchRequest({this.create, this.update, this.delete});
  factory WooProductBatchRequest.fromJson(Map<String, dynamic> json) =>
      WooProductBatchRequest(
        create: WooJson.readList(json, 'create', WooProduct.fromJson),
        update: WooJson.readList(json, 'update', WooProduct.fromJson),
        delete: WooJson.readIntList(json, 'delete'),
      );
  factory WooProductBatchRequest.fake() => WooProductBatchRequest(
        create: FakeHelper.list(() => WooProduct.fake()),
        update: FakeHelper.list(() => WooProduct.fake()),
        delete: FakeHelper.listOfIntegers(),
      );
  final List<WooProduct>? create;
  final List<WooProduct>? update;
  final List<int>? delete;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent(
        'create', create?.map((product) => product.toJson()).toList())
    ..putIfPresent(
        'update', update?.map((product) => product.toJson()).toList())
    ..putIfPresent('delete', delete);
  WooProductBatchRequest copyWith({
    List<WooProduct>? create,
    List<WooProduct>? update,
    List<int>? delete,
  }) =>
      WooProductBatchRequest(
        create: create ?? this.create,
        update: update ?? this.update,
        delete: delete ?? this.delete,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductBatchRequest &&
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
  String toString() => 'WooProductBatchRequest(create: ${create?.length ?? 0}, '
      'update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
}
