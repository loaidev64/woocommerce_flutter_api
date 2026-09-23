import '../../json/woo_json.dart';
import '../../helpers/fake_helper.dart';
import 'category.dart';

class WooProductCategoryBatchRequest {
  WooProductCategoryBatchRequest({this.create, this.update, this.delete});
  factory WooProductCategoryBatchRequest.fromJson(Map<String, dynamic> json) =>
      WooProductCategoryBatchRequest(
        create: WooJson.readList(json, 'create', WooProductCategory.fromJson),
        update: WooJson.readList(json, 'update', WooProductCategory.fromJson),
        delete: WooJson.readIntList(json, 'delete'),
      );
  factory WooProductCategoryBatchRequest.fake() =>
      WooProductCategoryBatchRequest(
        create: FakeHelper.list(() => WooProductCategory.fake()),
        update: FakeHelper.list(() => WooProductCategory.fake()),
        delete: FakeHelper.listOfIntegers(),
      );
  final List<WooProductCategory>? create;
  final List<WooProductCategory>? update;
  final List<int>? delete;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent(
        'create', create?.map((category) => category.toJson()).toList())
    ..putIfPresent(
        'update', update?.map((category) => category.toJson()).toList())
    ..putIfPresent('delete', delete);
  WooProductCategoryBatchRequest copyWith({
    List<WooProductCategory>? create,
    List<WooProductCategory>? update,
    List<int>? delete,
  }) =>
      WooProductCategoryBatchRequest(
        create: create ?? this.create,
        update: update ?? this.update,
        delete: delete ?? this.delete,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductCategoryBatchRequest &&
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
      'WooProductCategoryBatchRequest(create: ${create?.length ?? 0}, '
      'update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
}
