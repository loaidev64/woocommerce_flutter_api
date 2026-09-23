import '../../json/woo_json.dart';
import '../../helpers/fake_helper.dart';
import 'product_shipping_class.dart';

class WooProductShippingClassBatchResponse {
  WooProductShippingClassBatchResponse({this.create, this.update, this.delete});
  factory WooProductShippingClassBatchResponse.fromJson(
          Map<String, dynamic> json) =>
      WooProductShippingClassBatchResponse(
        create:
            WooJson.readList(json, 'create', WooProductShippingClass.fromJson),
        update:
            WooJson.readList(json, 'update', WooProductShippingClass.fromJson),
        delete:
            WooJson.readList(json, 'delete', WooProductShippingClass.fromJson),
      );
  factory WooProductShippingClassBatchResponse.fake() =>
      WooProductShippingClassBatchResponse(
        create: FakeHelper.list(() => WooProductShippingClass.fake()),
        update: FakeHelper.list(() => WooProductShippingClass.fake()),
        delete: FakeHelper.list(() => WooProductShippingClass.fake()),
      );
  final List<WooProductShippingClass>? create;
  final List<WooProductShippingClass>? update;
  final List<WooProductShippingClass>? delete;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('create',
        create?.map((shippingClass) => shippingClass.toJson()).toList())
    ..putIfPresent('update',
        update?.map((shippingClass) => shippingClass.toJson()).toList())
    ..putIfPresent('delete',
        delete?.map((shippingClass) => shippingClass.toJson()).toList());
  WooProductShippingClassBatchResponse copyWith({
    List<WooProductShippingClass>? create,
    List<WooProductShippingClass>? update,
    List<WooProductShippingClass>? delete,
  }) =>
      WooProductShippingClassBatchResponse(
        create: create ?? this.create,
        update: update ?? this.update,
        delete: delete ?? this.delete,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductShippingClassBatchResponse &&
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
      'WooProductShippingClassBatchResponse(create: ${create?.length ?? 0}, '
      'update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
}
