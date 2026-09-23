import '../../json/woo_json.dart';
import '../../helpers/fake_helper.dart';
import 'product.dart';

class WooProductBatchResponse {
  WooProductBatchResponse({this.create, this.update, this.delete});
  factory WooProductBatchResponse.fromJson(Map<String, dynamic> json) =>
      WooProductBatchResponse(
        create: WooJson.readList(json, 'create', WooProduct.fromJson),
        update: WooJson.readList(json, 'update', WooProduct.fromJson),
        delete: WooJson.readList(json, 'delete', WooProduct.fromJson),
      );
  factory WooProductBatchResponse.fake() => WooProductBatchResponse(
        create: FakeHelper.list(() => WooProduct.fake()),
        update: FakeHelper.list(() => WooProduct.fake()),
        delete: FakeHelper.list(() => WooProduct.fake()),
      );
  final List<WooProduct>? create;
  final List<WooProduct>? update;
  final List<WooProduct>? delete;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent(
        'create', create?.map((product) => product.toJson()).toList())
    ..putIfPresent(
        'update', update?.map((product) => product.toJson()).toList())
    ..putIfPresent(
        'delete', delete?.map((product) => product.toJson()).toList());
  WooProductBatchResponse copyWith({
    List<WooProduct>? create,
    List<WooProduct>? update,
    List<WooProduct>? delete,
  }) =>
      WooProductBatchResponse(
        create: create ?? this.create,
        update: update ?? this.update,
        delete: delete ?? this.delete,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductBatchResponse &&
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
      'WooProductBatchResponse(create: ${create?.length ?? 0}, '
      'update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
}
