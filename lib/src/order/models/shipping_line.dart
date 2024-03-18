import 'package:woocommerce_flutter_api/src/base/models/metadata.dart';
import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';
import 'package:woocommerce_flutter_api/src/order/models/tax.dart';

class WooShippingLine {
  /// Item ID.
  int? id;

  /// Shipping method name.
  String? methodTitle;

  /// Shipping method ID.
  String? methodId;

  /// Line total (after discounts).
  double? total;

  /// Line total tax (after discounts).
  double? totalTax;

  /// Line taxes.
  List<WooTax>? taxes;

  /// Meta data.
  List<WooMetaData>? metaData;

  WooShippingLine(
      {this.id,
      this.methodTitle,
      this.methodId,
      this.total,
      this.totalTax,
      this.taxes,
      this.metaData});

  WooShippingLine.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    methodTitle = json['method_title'];
    methodId = json['method_id'];
    total = double.tryParse(json['total']);
    totalTax = double.tryParse(json['total_tax']);

    taxes = (json['taxes'] as List).map((i) => WooTax.fromJson(i)).toList();
    metaData = (json['meta_data'] as List)
        .map((i) => WooMetaData.fromJson(i))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['method_title'] = methodTitle;
    data['method_id'] = methodId;
    data['total'] = total;
    data['total_tax'] = totalTax;
    if (taxes != null) {
      data['taxes'] = taxes!.map((v) => v.toJson()).toList();
    }
    if (metaData != null) {
      data['meta_data'] = metaData!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  factory WooShippingLine.fake() => WooShippingLine(
        id: FakeHelper.integer(),
        methodId: FakeHelper.integer().toString(),
        methodTitle: FakeHelper.word(),
        total: FakeHelper.decimal(),
        totalTax: FakeHelper.decimal(),
        taxes: FakeHelper.list(() => WooTax.fake()),
        metaData: FakeHelper.list(() => WooMetaData.fake()),
      );
}
