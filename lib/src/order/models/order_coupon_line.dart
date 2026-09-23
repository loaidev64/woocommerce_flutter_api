import '../../base/models/metadata.dart';
import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooOrderCouponLine {
  WooOrderCouponLine({
    this.id,
    this.code,
    this.discount,
    this.discountTax,
    this.metaData = const [],
  });
  factory WooOrderCouponLine.fromJson(Map<String, dynamic> json) =>
      WooOrderCouponLine(
        id: WooJson.readInt(json, 'id'),
        code: WooJson.readString(json, 'code'),
        discount: WooJson.readDouble(json, 'discount'),
        discountTax: WooJson.readDouble(json, 'discount_tax'),
        metaData:
            WooJson.readListOrEmpty(json, 'meta_data', WooMetaData.fromJson),
      );
  factory WooOrderCouponLine.fake() => WooOrderCouponLine(
        id: FakeHelper.integer(),
        code: FakeHelper.word(),
        discount: FakeHelper.decimal(),
        discountTax: FakeHelper.decimal(),
        metaData: FakeHelper.list(() => WooMetaData.fake()),
      );
  final int? id;
  final String? code;
  final double? discount;
  final double? discountTax;
  final List<WooMetaData> metaData;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putIfPresent('code', code)
    ..putIfPresent('discount', discount)
    ..putIfPresent('discount_tax', discountTax)
    ..putIfPresent('meta_data', metaData.map((v) => v.toJson()).toList());
  WooOrderCouponLine copyWith({
    int? id,
    String? code,
    double? discount,
    double? discountTax,
    List<WooMetaData>? metaData,
  }) =>
      WooOrderCouponLine(
        id: id ?? this.id,
        code: code ?? this.code,
        discount: discount ?? this.discount,
        discountTax: discountTax ?? this.discountTax,
        metaData: metaData ?? this.metaData,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooOrderCouponLine &&
          other.id == id &&
          other.code == code &&
          other.discount == discount &&
          other.discountTax == discountTax &&
          WooJson.listEquals(other.metaData, metaData);
  @override
  int get hashCode =>
      Object.hashAll([id, code, discount, discountTax, ...metaData]);
  @override
  String toString() {
    return 'WooOrderCouponLine(id: $id, code: $code, discount: $discount, discountTax: $discountTax)';
  }
}
