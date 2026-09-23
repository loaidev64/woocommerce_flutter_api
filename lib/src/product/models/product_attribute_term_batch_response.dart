import '../../json/woo_json.dart';
import '../../helpers/fake_helper.dart';
import 'product_attribute_term.dart';

class WooProductAttributeTermBatchResponse {
  WooProductAttributeTermBatchResponse({this.create, this.update, this.delete});
  factory WooProductAttributeTermBatchResponse.fromJson(
          Map<String, dynamic> json) =>
      WooProductAttributeTermBatchResponse(
        create:
            WooJson.readList(json, 'create', WooProductAttributeTerm.fromJson),
        update:
            WooJson.readList(json, 'update', WooProductAttributeTerm.fromJson),
        delete:
            WooJson.readList(json, 'delete', WooProductAttributeTerm.fromJson),
      );
  factory WooProductAttributeTermBatchResponse.fake() =>
      WooProductAttributeTermBatchResponse(
        create: FakeHelper.list(() => WooProductAttributeTerm.fake()),
        update: FakeHelper.list(() => WooProductAttributeTerm.fake()),
        delete: FakeHelper.list(() => WooProductAttributeTerm.fake()),
      );
  final List<WooProductAttributeTerm>? create;
  final List<WooProductAttributeTerm>? update;
  final List<WooProductAttributeTerm>? delete;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('create', create?.map((term) => term.toJson()).toList())
    ..putIfPresent('update', update?.map((term) => term.toJson()).toList())
    ..putIfPresent('delete', delete?.map((term) => term.toJson()).toList());
  WooProductAttributeTermBatchResponse copyWith({
    List<WooProductAttributeTerm>? create,
    List<WooProductAttributeTerm>? update,
    List<WooProductAttributeTerm>? delete,
  }) =>
      WooProductAttributeTermBatchResponse(
        create: create ?? this.create,
        update: update ?? this.update,
        delete: delete ?? this.delete,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductAttributeTermBatchResponse &&
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
      'WooProductAttributeTermBatchResponse(create: ${create?.length ?? 0}, '
      'update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
}
