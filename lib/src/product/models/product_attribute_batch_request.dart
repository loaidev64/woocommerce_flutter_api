import '../../json/woo_json.dart';
import '../../helpers/fake_helper.dart';
import 'product_attribute.dart';

class WooProductAttributeBatchRequest {
  WooProductAttributeBatchRequest({this.create, this.update, this.delete});
  factory WooProductAttributeBatchRequest.fromJson(Map<String, dynamic> json) =>
      WooProductAttributeBatchRequest(
        create: WooJson.readList(json, 'create', WooProductAttribute.fromJson),
        update: WooJson.readList(json, 'update', WooProductAttribute.fromJson),
        delete: WooJson.readIntList(json, 'delete'),
      );
  factory WooProductAttributeBatchRequest.fake() =>
      WooProductAttributeBatchRequest(
        create: FakeHelper.list(() => WooProductAttribute.fake()),
        update: FakeHelper.list(() => WooProductAttribute.fake()),
        delete: FakeHelper.listOfIntegers(),
      );
  final List<WooProductAttribute>? create;
  final List<WooProductAttribute>? update;
  final List<int>? delete;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent(
        'create', create?.map((attribute) => attribute.toJson()).toList())
    ..putIfPresent(
        'update', update?.map((attribute) => attribute.toJson()).toList())
    ..putIfPresent('delete', delete);
  WooProductAttributeBatchRequest copyWith({
    List<WooProductAttribute>? create,
    List<WooProductAttribute>? update,
    List<int>? delete,
  }) =>
      WooProductAttributeBatchRequest(
        create: create ?? this.create,
        update: update ?? this.update,
        delete: delete ?? this.delete,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductAttributeBatchRequest &&
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
      'WooProductAttributeBatchRequest(create: ${create?.length ?? 0}, '
      'update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
}
