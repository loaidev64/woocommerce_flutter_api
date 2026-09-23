import '../../json/woo_json.dart';
import '../../helpers/fake_helper.dart';
import 'coupon.dart';

class WooCouponBatchRequest {
  WooCouponBatchRequest({this.create, this.update, this.delete});
  factory WooCouponBatchRequest.fromJson(Map<String, dynamic> json) =>
      WooCouponBatchRequest(
        create: WooJson.readList(json, 'create', WooCoupon.fromJson),
        update: WooJson.readList(json, 'update', WooCoupon.fromJson),
        delete: WooJson.readIntList(json, 'delete'),
      );
  factory WooCouponBatchRequest.fake() => WooCouponBatchRequest(
        create: FakeHelper.list(() => WooCoupon.fake()),
        update: FakeHelper.list(() => WooCoupon.fake()),
        delete: FakeHelper.listOfIntegers(),
      );
  final List<WooCoupon>? create;
  final List<WooCoupon>? update;
  final List<int>? delete;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('create', create?.map((coupon) => coupon.toJson()).toList())
    ..putIfPresent('update', update?.map((coupon) => coupon.toJson()).toList())
    ..putIfPresent('delete', delete);
  WooCouponBatchRequest copyWith({
    List<WooCoupon>? create,
    List<WooCoupon>? update,
    List<int>? delete,
  }) =>
      WooCouponBatchRequest(
        create: create ?? this.create,
        update: update ?? this.update,
        delete: delete ?? this.delete,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooCouponBatchRequest &&
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
  String toString() => 'WooCouponBatchRequest(create: ${create?.length ?? 0}, '
      'update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
}
