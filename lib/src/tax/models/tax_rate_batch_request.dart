import '../../json/woo_json.dart';
import '../../helpers/fake_helper.dart';
import 'tax_rate.dart';

class WooTaxRateBatchRequest {
  WooTaxRateBatchRequest({this.create, this.update, this.delete});
  factory WooTaxRateBatchRequest.fromJson(Map<String, dynamic> json) =>
      WooTaxRateBatchRequest(
        create: WooJson.readList(json, 'create', WooTaxRate.fromJson),
        update: WooJson.readList(json, 'update', WooTaxRate.fromJson),
        delete: WooJson.readIntList(json, 'delete'),
      );
  factory WooTaxRateBatchRequest.fake() => WooTaxRateBatchRequest(
        create: FakeHelper.list(() => WooTaxRate.fake()),
        update: FakeHelper.list(() => WooTaxRate.fake()),
        delete: FakeHelper.listOfIntegers(),
      );
  final List<WooTaxRate>? create;
  final List<WooTaxRate>? update;
  final List<int>? delete;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putList('create', create?.map((rate) => rate.toJson()).toList())
    ..putList('update', update?.map((rate) => rate.toJson()).toList())
    ..putIfPresent('delete', delete);
  WooTaxRateBatchRequest copyWith({
    List<WooTaxRate>? create,
    List<WooTaxRate>? update,
    List<int>? delete,
  }) =>
      WooTaxRateBatchRequest(
        create: create ?? this.create,
        update: update ?? this.update,
        delete: delete ?? this.delete,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooTaxRateBatchRequest &&
        WooJson.listEquals(other.create, create) &&
        WooJson.listEquals(other.update, update) &&
        WooJson.listEquals(other.delete, delete);
  }

  @override
  int get hashCode => Object.hashAll([
        Object.hashAll(create ?? const []),
        Object.hashAll(update ?? const []),
        Object.hashAll(delete ?? const []),
      ]);
  @override
  String toString() => 'WooTaxRateBatchRequest(create: ${create?.length ?? 0}, '
      'update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
}
