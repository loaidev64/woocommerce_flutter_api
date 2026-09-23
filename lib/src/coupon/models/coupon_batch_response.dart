import '../../json/woo_json.dart';
import '../../helpers/fake_helper.dart';
import 'coupon.dart';

class WooCouponBatchResponse {
  WooCouponBatchResponse({this.create, this.update, this.delete});
  factory WooCouponBatchResponse.fromJson(Map<String, dynamic> json) =>
      WooCouponBatchResponse(
        create: WooJson.readList(json, 'create', WooCoupon.fromJson),
        update: WooJson.readList(json, 'update', WooCoupon.fromJson),
        delete: WooJson.readList(json, 'delete', WooCoupon.fromJson),
      );
  factory WooCouponBatchResponse.fake() => WooCouponBatchResponse(
        create: FakeHelper.list(() => WooCoupon.fake()),
        update: FakeHelper.list(() => WooCoupon.fake()),
        delete: FakeHelper.list(() => WooCoupon.fake()),
      );
  final List<WooCoupon>? create;
  final List<WooCoupon>? update;
  final List<WooCoupon>? delete;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('create', create?.map((coupon) => coupon.toJson()).toList())
    ..putIfPresent('update', update?.map((coupon) => coupon.toJson()).toList())
    ..putIfPresent('delete', delete?.map((coupon) => coupon.toJson()).toList());
  WooCouponBatchResponse copyWith({
    List<WooCoupon>? create,
    List<WooCoupon>? update,
    List<WooCoupon>? delete,
  }) =>
      WooCouponBatchResponse(
        create: create ?? this.create,
        update: update ?? this.update,
        delete: delete ?? this.delete,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooCouponBatchResponse &&
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
  String toString() => 'WooCouponBatchResponse(create: ${create?.length ?? 0}, '
      'update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
}
