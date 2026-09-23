import '../../json/woo_json.dart';
import '../../helpers/fake_helper.dart';
import 'customer.dart';

class WooCustomerBatchResponse {
  WooCustomerBatchResponse({this.create, this.update, this.delete});
  factory WooCustomerBatchResponse.fromJson(Map<String, dynamic> json) =>
      WooCustomerBatchResponse(
        create: WooJson.readList(json, 'create', WooCustomer.fromJson),
        update: WooJson.readList(json, 'update', WooCustomer.fromJson),
        delete: WooJson.readList(json, 'delete', WooCustomer.fromJson),
      );
  factory WooCustomerBatchResponse.fake() => WooCustomerBatchResponse(
        create: FakeHelper.list(() => WooCustomer.fake()),
        update: FakeHelper.list(() => WooCustomer.fake()),
        delete: FakeHelper.list(() => WooCustomer.fake()),
      );
  final List<WooCustomer>? create;
  final List<WooCustomer>? update;
  final List<WooCustomer>? delete;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('create', create?.map((c) => c.toJson()).toList())
    ..putIfPresent('update', update?.map((c) => c.toJson()).toList())
    ..putIfPresent('delete', delete?.map((c) => c.toJson()).toList());
  WooCustomerBatchResponse copyWith({
    List<WooCustomer>? create,
    List<WooCustomer>? update,
    List<WooCustomer>? delete,
  }) =>
      WooCustomerBatchResponse(
        create: create ?? this.create,
        update: update ?? this.update,
        delete: delete ?? this.delete,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooCustomerBatchResponse &&
          WooJson.listEquals(other.create, create) &&
          WooJson.listEquals(other.update, update) &&
          WooJson.listEquals(other.delete, delete);
  @override
  int get hashCode => Object.hashAll([create, update, delete]);
  @override
  String toString() =>
      'WooCustomerBatchResponse(create: ${create?.length ?? 0}, '
      'update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
}
