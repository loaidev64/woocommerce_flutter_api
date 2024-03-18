import 'package:woocommerce_flutter_api/src/base/models/metadata.dart';
import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';
import 'package:woocommerce_flutter_api/src/order/enums/order_tax_status.dart';
import 'package:woocommerce_flutter_api/src/order/models/fee_line_tax.dart';

class WooOrderFeeLine {
  /// Item ID.
  int? id;

  /// Fee name.
  String? name;

  /// Tax class of fee.
  String? taxClass;

  /// Tax status of fee. Options: taxable and none.
  WooOrderTaxStatus? taxStatus;

  /// Line total (after discounts).
  double? total;

  /// Line total tax (after discounts).
  double? totalTax;

  /// Line taxes.
  List<WooFeeLineTax> taxes;

  /// Meta data.
  List<WooMetaData> metaData;

  WooOrderFeeLine({
    this.id,
    this.name,
    this.taxClass,
    this.taxStatus,
    this.totalTax,
    this.total,
    this.taxes = const [],
    this.metaData = const [],
  });

  WooOrderFeeLine.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        taxClass = json['tax_class'],
        taxStatus = WooOrderTaxStatus.fromString('tax_status'),
        total = double.tryParse(json['total']),
        totalTax = double.tryParse(json['total_tax']),
        taxes = (json['taxes'] as List)
            .map((i) => WooFeeLineTax.fromJson(i))
            .toList(),
        metaData = (json['meta_data'] as List)
            .map((i) => WooMetaData.fromJson(i))
            .toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['tax_class'] = taxClass;
    data['tax_status'] = taxStatus;
    data['total'] = total;
    data['total_tax'] = totalTax;
    data['taxes'] = taxes;
    data['meta_data'] = metaData.map((v) => v.toJson()).toList();
    return data;
  }

  factory WooOrderFeeLine.fake() => WooOrderFeeLine(
        id: FakeHelper.integer(),
        name: FakeHelper.word(),
        taxClass: FakeHelper.word(),
        taxStatus: WooOrderTaxStatus.fake(),
        totalTax: FakeHelper.decimal(),
        total: FakeHelper.decimal(),
        taxes: FakeHelper.list(() => WooFeeLineTax.fake()),
        metaData: FakeHelper.list(() => WooMetaData.fake()),
      );
}
