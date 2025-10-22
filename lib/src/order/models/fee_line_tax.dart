import 'package:woocommerce_flutter_api/src/base/models/metadata.dart';
import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

/// Represents tax information for a fee line in a WooCommerce order.
///
/// Contains tax rate details, calculations, and amounts for taxes applied
/// to fee lines. Used for tax tracking and order processing.
class WooFeeLineTax {

  /// Creates a new WooFeeLineTax instance.
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

  /// Creates a WooFeeLineTax instance from JSON data.
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
  /// Unique identifier for the fee line tax item.
  final int? id;

  /// Tax rate code.
  final String? rateCode;

  /// Tax rate identifier.
  final String? rateId;

  /// Tax rate display label.
  final String? label;

  /// Whether this is a compound tax rate.
  final bool? compound;

  /// Tax total excluding shipping taxes.
  final double? taxTotal;

  /// Shipping tax total.
  final double? shippingTaxTotal;

  /// Custom metadata for the fee line tax item.
  final List<WooMetaData>? metaData;

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

  /// Returns a string representation of the WooFeeLineTax instance.
  ///
  /// Displays all main fields for debugging and logging purposes.
  @override
  String toString() {
    return 'WooFeeLineTax(id: $id, rateCode: $rateCode, label: $label, taxTotal: $taxTotal)';
  }
}
