import '../../json/woo_json.dart';
import '../../helpers/fake_helper.dart';
import 'product_attribute.dart';

class WooProductAttributeBatchResponse {
  WooProductAttributeBatchResponse({this.create, this.update, this.delete});
  factory WooProductAttributeBatchResponse.fromJson(
          Map<String, dynamic> json) =>
      WooProductAttributeBatchResponse(
        create: WooJson.readList(json, 'create', WooProductAttribute.fromJson),
        update: WooJson.readList(json, 'update', WooProductAttribute.fromJson),
        delete: WooJson.readList(json, 'delete', WooProductAttribute.fromJson),
      );
  factory WooProductAttributeBatchResponse.fake() =>
      WooProductAttributeBatchResponse(
        create: FakeHelper.list(() => WooProductAttribute.fake()),
        update: FakeHelper.list(() => WooProductAttribute.fake()),
        delete: FakeHelper.list(() => WooProductAttribute.fake()),
      );
  final List<WooProductAttribute>? create;
  final List<WooProductAttribute>? update;
  final List<WooProductAttribute>? delete;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent(
        'create', create?.map((attribute) => attribute.toJson()).toList())
    ..putIfPresent(
        'update', update?.map((attribute) => attribute.toJson()).toList())
    ..putIfPresent(
        'delete', delete?.map((attribute) => attribute.toJson()).toList());
  WooProductAttributeBatchResponse copyWith({
    List<WooProductAttribute>? create,
    List<WooProductAttribute>? update,
    List<WooProductAttribute>? delete,
  }) =>
      WooProductAttributeBatchResponse(
        create: create ?? this.create,
        update: update ?? this.update,
        delete: delete ?? this.delete,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductAttributeBatchResponse &&
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
      'WooProductAttributeBatchResponse(create: ${create?.length ?? 0}, '
      'update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
}
