import 'package:woocommerce_flutter_api/src/base/models/metadata.dart';
import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

/// Represents a coupon line in a WooCommerce order.
///
/// Contains coupon information, discount amounts, and tax details for coupons
/// applied to an order. Used for discount tracking and order processing.
class WooOrderCouponLine {
  /// Unique identifier for the coupon line.
  int? id;

  /// Coupon code applied.
  String? code;

  /// Total discount amount.
  double? discount;

  /// Total discount tax amount.
  double? discountTax;

  /// Custom metadata for the coupon line.
  List<WooMetaData> metaData;

  /// Creates a new WooOrderCouponLine instance.
  WooOrderCouponLine({
    this.id,
    this.code,
    this.discount,
    this.discountTax,
    this.metaData = const [],
  });

  /// Creates a WooOrderCouponLine instance from JSON data.
  WooOrderCouponLine.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        code = json['code'],
        discount = double.tryParse(json['discount']),
        discountTax = double.tryParse(json['discount_tax']),
        metaData = (json['meta_data'] as List)
            .map((i) => WooMetaData.fromJson(i))
            .toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['discount'] = discount;
    data['discount_tax'] = discountTax;
    data['meta_data'] = metaData.map((v) => v.toJson()).toList();
    return data;
  }

  factory WooOrderCouponLine.fake() => WooOrderCouponLine(
        id: FakeHelper.integer(),
        code: FakeHelper.word(),
        discount: FakeHelper.decimal(),
        discountTax: FakeHelper.decimal(),
        metaData: FakeHelper.list(() => WooMetaData.fake()),
      );

  /// Returns a string representation of the WooOrderCouponLine instance.
  ///
  /// Displays all main fields for debugging and logging purposes.
  @override
  String toString() {
    return 'WooOrderCouponLine(id: $id, code: $code, discount: $discount, discountTax: $discountTax)';
  }
}
