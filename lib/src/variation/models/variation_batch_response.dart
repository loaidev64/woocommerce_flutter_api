import '../../json/woo_json.dart';
import '../../helpers/fake_helper.dart';
import 'variation.dart';

class WooProductVariationBatchResponse {
  WooProductVariationBatchResponse({this.create, this.update, this.delete});
  factory WooProductVariationBatchResponse.fromJson(
          Map<String, dynamic> json) =>
      WooProductVariationBatchResponse(
        create: WooJson.readList(json, 'create', WooProductVariation.fromJson),
        update: WooJson.readList(json, 'update', WooProductVariation.fromJson),
        delete: WooJson.readList(json, 'delete', WooProductVariation.fromJson),
      );
  factory WooProductVariationBatchResponse.fake() =>
      WooProductVariationBatchResponse(
        create: FakeHelper.list(() => WooProductVariation.fake()),
        update: FakeHelper.list(() => WooProductVariation.fake()),
        delete: FakeHelper.list(() => WooProductVariation.fake()),
      );
  final List<WooProductVariation>? create;
  final List<WooProductVariation>? update;
  final List<WooProductVariation>? delete;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent(
        'create', create?.map((variation) => variation.toJson()).toList())
    ..putIfPresent(
        'update', update?.map((variation) => variation.toJson()).toList())
    ..putIfPresent(
        'delete', delete?.map((variation) => variation.toJson()).toList());
  WooProductVariationBatchResponse copyWith({
    List<WooProductVariation>? create,
    List<WooProductVariation>? update,
    List<WooProductVariation>? delete,
  }) =>
      WooProductVariationBatchResponse(
        create: create ?? this.create,
        update: update ?? this.update,
        delete: delete ?? this.delete,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductVariationBatchResponse &&
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
      'WooProductVariationBatchResponse(create: ${create?.length ?? 0}, '
      'update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
}
