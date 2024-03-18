import 'package:woocommerce_flutter_api/src/base/models/metadata.dart';
import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

class WooFeeLineTax {
  /// Item ID.
  final int? id;

  /// Tax rate code.
  final String? rateCode;

  /// Tax rate ID.
  final String? rateId;

  /// Tax rate label.
  final String? label;

  /// Show if is a compound tax rate.
  final bool? compound;

  /// Tax total (not including shipping taxes).
  final double? taxTotal;

  /// Shipping tax total.
  final double? shippingTaxTotal;

  /// Meta data.
  final List<WooMetaData>? metaData;

  WooFeeLineTax({
    this.id,
    this.rateCode,
    this.rateId,
    this.label,
    this.compound,
    this.taxTotal,
    this.shippingTaxTotal,
    this.metaData,
  });

  factory WooFeeLineTax.fromJson(Map<String, dynamic> json) => WooFeeLineTax(
        id: json['id'],
        rateCode: json['rate_code'],
        rateId: json['rate_id'],
        label: json['label'],
        compound: bool.tryParse(json['compound']),
        taxTotal: double.tryParse(json['tax_total']),
        shippingTaxTotal: double.tryParse(json['shipping_tax_total']),
        metaData: (json['meta_data'] as List)
            .map((i) => WooMetaData.fromJson(i))
            .toList(),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['rate_code'] = rateCode;
    data['rate_id'] = rateId;
    data['label'] = label;
    data['compound'] = compound;
    data['tax_total'] = taxTotal;
    data['shipping_tax_total'] = shippingTaxTotal;
    if (metaData != null) {
      data['meta_data'] = metaData!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  factory WooFeeLineTax.fake() => WooFeeLineTax(
        id: FakeHelper.integer(),
        rateCode: FakeHelper.word(),
        rateId: FakeHelper.integer().toString(),
        label: FakeHelper.word(),
        compound: FakeHelper.boolean(),
        taxTotal: FakeHelper.decimal(),
        shippingTaxTotal: FakeHelper.decimal(),
        metaData: FakeHelper.list(() => WooMetaData.fake()),
      );
}
