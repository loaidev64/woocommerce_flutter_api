import '../../json/woo_json.dart';
import '../../helpers/fake_helper.dart';
import 'variation.dart';

class WooProductVariationBatchRequest {
  WooProductVariationBatchRequest({this.create, this.update, this.delete});
  factory WooProductVariationBatchRequest.fromJson(Map<String, dynamic> json) =>
      WooProductVariationBatchRequest(
        create: WooJson.readList(json, 'create', WooProductVariation.fromJson),
        update: WooJson.readList(json, 'update', WooProductVariation.fromJson),
        delete: WooJson.readIntList(json, 'delete'),
      );
  factory WooProductVariationBatchRequest.fake() =>
      WooProductVariationBatchRequest(
        create: FakeHelper.list(() => WooProductVariation.fake()),
        update: FakeHelper.list(() => WooProductVariation.fake()),
        delete: FakeHelper.listOfIntegers(),
      );
  final List<WooProductVariation>? create;
  final List<WooProductVariation>? update;
  final List<int>? delete;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent(
        'create', create?.map((variation) => variation.toJson()).toList())
    ..putIfPresent(
        'update', update?.map((variation) => variation.toJson()).toList())
    ..putIfPresent('delete', delete);
  WooProductVariationBatchRequest copyWith({
    List<WooProductVariation>? create,
    List<WooProductVariation>? update,
    List<int>? delete,
  }) =>
      WooProductVariationBatchRequest(
        create: create ?? this.create,
        update: update ?? this.update,
        delete: delete ?? this.delete,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductVariationBatchRequest &&
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
      'WooProductVariationBatchRequest(create: ${create?.length ?? 0}, '
      'update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
}
