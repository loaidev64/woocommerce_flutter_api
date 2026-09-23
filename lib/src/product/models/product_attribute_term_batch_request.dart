import '../../json/woo_json.dart';
import '../../helpers/fake_helper.dart';
import 'product_attribute_term.dart';

class WooProductAttributeTermBatchRequest {
  WooProductAttributeTermBatchRequest({this.create, this.update, this.delete});
  factory WooProductAttributeTermBatchRequest.fromJson(
          Map<String, dynamic> json) =>
      WooProductAttributeTermBatchRequest(
        create:
            WooJson.readList(json, 'create', WooProductAttributeTerm.fromJson),
        update:
            WooJson.readList(json, 'update', WooProductAttributeTerm.fromJson),
        delete: WooJson.readIntList(json, 'delete'),
      );
  factory WooProductAttributeTermBatchRequest.fake() =>
      WooProductAttributeTermBatchRequest(
        create: FakeHelper.list(() => WooProductAttributeTerm.fake()),
        update: FakeHelper.list(() => WooProductAttributeTerm.fake()),
        delete: FakeHelper.listOfIntegers(),
      );
  final List<WooProductAttributeTerm>? create;
  final List<WooProductAttributeTerm>? update;
  final List<int>? delete;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('create', create?.map((term) => term.toJson()).toList())
    ..putIfPresent('update', update?.map((term) => term.toJson()).toList())
    ..putIfPresent('delete', delete);
  WooProductAttributeTermBatchRequest copyWith({
    List<WooProductAttributeTerm>? create,
    List<WooProductAttributeTerm>? update,
    List<int>? delete,
  }) =>
      WooProductAttributeTermBatchRequest(
        create: create ?? this.create,
        update: update ?? this.update,
        delete: delete ?? this.delete,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductAttributeTermBatchRequest &&
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
      'WooProductAttributeTermBatchRequest(create: ${create?.length ?? 0}, '
      'update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
}
