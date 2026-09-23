import '../../json/woo_json.dart';
import '../../helpers/fake_helper.dart';
import 'category.dart';

class WooProductCategoryBatchResponse {
  WooProductCategoryBatchResponse({this.create, this.update, this.delete});
  factory WooProductCategoryBatchResponse.fromJson(Map<String, dynamic> json) =>
      WooProductCategoryBatchResponse(
        create: WooJson.readList(json, 'create', WooProductCategory.fromJson),
        update: WooJson.readList(json, 'update', WooProductCategory.fromJson),
        delete: WooJson.readList(json, 'delete', WooProductCategory.fromJson),
      );
  factory WooProductCategoryBatchResponse.fake() =>
      WooProductCategoryBatchResponse(
        create: FakeHelper.list(() => WooProductCategory.fake()),
        update: FakeHelper.list(() => WooProductCategory.fake()),
        delete: FakeHelper.list(() => WooProductCategory.fake()),
      );
  final List<WooProductCategory>? create;
  final List<WooProductCategory>? update;
  final List<WooProductCategory>? delete;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent(
        'create', create?.map((category) => category.toJson()).toList())
    ..putIfPresent(
        'update', update?.map((category) => category.toJson()).toList())
    ..putIfPresent(
        'delete', delete?.map((category) => category.toJson()).toList());
  WooProductCategoryBatchResponse copyWith({
    List<WooProductCategory>? create,
    List<WooProductCategory>? update,
    List<WooProductCategory>? delete,
  }) =>
      WooProductCategoryBatchResponse(
        create: create ?? this.create,
        update: update ?? this.update,
        delete: delete ?? this.delete,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductCategoryBatchResponse &&
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
      'WooProductCategoryBatchResponse(create: ${create?.length ?? 0}, '
      'update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
}
