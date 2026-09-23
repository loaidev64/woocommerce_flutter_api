import '../../json/woo_json.dart';
import '../../helpers/fake_helper.dart';
import 'product_shipping_class.dart';

class WooProductShippingClassBatchRequest {
  WooProductShippingClassBatchRequest({this.create, this.update, this.delete});
  factory WooProductShippingClassBatchRequest.fromJson(
          Map<String, dynamic> json) =>
      WooProductShippingClassBatchRequest(
        create:
            WooJson.readList(json, 'create', WooProductShippingClass.fromJson),
        update:
            WooJson.readList(json, 'update', WooProductShippingClass.fromJson),
        delete: WooJson.readIntList(json, 'delete'),
      );
  factory WooProductShippingClassBatchRequest.fake() =>
      WooProductShippingClassBatchRequest(
        create: FakeHelper.list(() => WooProductShippingClass.fake()),
        update: FakeHelper.list(() => WooProductShippingClass.fake()),
        delete: FakeHelper.listOfIntegers(),
      );
  final List<WooProductShippingClass>? create;
  final List<WooProductShippingClass>? update;
  final List<int>? delete;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('create',
        create?.map((shippingClass) => shippingClass.toJson()).toList())
    ..putIfPresent('update',
        update?.map((shippingClass) => shippingClass.toJson()).toList())
    ..putIfPresent('delete', delete);
  WooProductShippingClassBatchRequest copyWith({
    List<WooProductShippingClass>? create,
    List<WooProductShippingClass>? update,
    List<int>? delete,
  }) =>
      WooProductShippingClassBatchRequest(
        create: create ?? this.create,
        update: update ?? this.update,
        delete: delete ?? this.delete,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductShippingClassBatchRequest &&
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
      'WooProductShippingClassBatchRequest(create: ${create?.length ?? 0}, '
      'update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
}
