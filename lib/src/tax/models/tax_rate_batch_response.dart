import '../../json/woo_json.dart';
import '../../helpers/fake_helper.dart';
import 'tax_rate.dart';

class WooTaxRateBatchResponse {
  WooTaxRateBatchResponse({this.create, this.update, this.delete});
  factory WooTaxRateBatchResponse.fromJson(Map<String, dynamic> json) =>
      WooTaxRateBatchResponse(
        create: WooJson.readList(json, 'create', WooTaxRate.fromJson),
        update: WooJson.readList(json, 'update', WooTaxRate.fromJson),
        delete: WooJson.readList(json, 'delete', WooTaxRate.fromJson),
      );
  factory WooTaxRateBatchResponse.fake() => WooTaxRateBatchResponse(
        create: FakeHelper.list(() => WooTaxRate.fake()),
        update: FakeHelper.list(() => WooTaxRate.fake()),
        delete: FakeHelper.list(() => WooTaxRate.fake()),
      );
  final List<WooTaxRate>? create;
  final List<WooTaxRate>? update;
  final List<WooTaxRate>? delete;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putList('create', create?.map((rate) => rate.toJson()).toList())
    ..putList('update', update?.map((rate) => rate.toJson()).toList())
    ..putList('delete', delete?.map((rate) => rate.toJson()).toList());
  WooTaxRateBatchResponse copyWith({
    List<WooTaxRate>? create,
    List<WooTaxRate>? update,
    List<WooTaxRate>? delete,
  }) =>
      WooTaxRateBatchResponse(
        create: create ?? this.create,
        update: update ?? this.update,
        delete: delete ?? this.delete,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooTaxRateBatchResponse &&
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
  String toString() =>
      'WooTaxRateBatchResponse(create: ${create?.length ?? 0}, '
      'update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
}
