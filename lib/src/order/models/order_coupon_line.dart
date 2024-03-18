import 'package:woocommerce_flutter_api/src/base/models/metadata.dart';
import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

class WooOrderCouponLine {
  /// Item ID.
  int? id;

  /// Coupon code.
  String? code;

  /// Discount total.
  double? discount;

  /// Discount total tax.
  double? discountTax;

  /// Meta data.
  List<WooMetaData> metaData;

  WooOrderCouponLine({
    this.id,
    this.code,
    this.discount,
    this.discountTax,
    this.metaData = const [],
  });

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
}
