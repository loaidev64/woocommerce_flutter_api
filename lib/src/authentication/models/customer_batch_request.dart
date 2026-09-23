import '../../json/woo_json.dart';
import '../../helpers/fake_helper.dart';
import 'customer.dart';

class WooCustomerBatchRequest {
  WooCustomerBatchRequest({this.create, this.update, this.delete});
  factory WooCustomerBatchRequest.fromJson(Map<String, dynamic> json) =>
      WooCustomerBatchRequest(
        create: WooJson.readList(json, 'create', WooCustomer.fromJson),
        update: WooJson.readList(json, 'update', WooCustomer.fromJson),
        delete: WooJson.readIntList(json, 'delete'),
      );
  factory WooCustomerBatchRequest.fake() => WooCustomerBatchRequest(
        create: FakeHelper.list(() => WooCustomer.fake()),
        update: FakeHelper.list(() => WooCustomer.fake()),
        delete: FakeHelper.listOfIntegers(),
      );
  final List<WooCustomer>? create;
  final List<WooCustomer>? update;
  final List<int>? delete;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('create', create?.map((c) => c.toJson()).toList())
    ..putIfPresent('update', update?.map((c) => c.toJson()).toList())
    ..putIfPresent('delete', delete);
  WooCustomerBatchRequest copyWith({
    List<WooCustomer>? create,
    List<WooCustomer>? update,
    List<int>? delete,
  }) =>
      WooCustomerBatchRequest(
        create: create ?? this.create,
        update: update ?? this.update,
        delete: delete ?? this.delete,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooCustomerBatchRequest &&
          WooJson.listEquals(other.create, create) &&
          WooJson.listEquals(other.update, update) &&
          WooJson.listEquals(other.delete, delete);
  @override
  int get hashCode => Object.hashAll([create, update, delete]);
  @override
  String toString() =>
      'WooCustomerBatchRequest(create: ${create?.length ?? 0}, '
      'update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
}
