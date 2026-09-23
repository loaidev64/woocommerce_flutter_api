import '../../base/models/metadata.dart';
import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooTaxLine {
  WooTaxLine({
    this.id,
    this.rateCode,
    this.rateId,
    this.label,
    this.compound,
    this.taxTotal,
    this.shippingTaxTotal,
    this.metaData,
  });
  factory WooTaxLine.fromJson(Map<String, dynamic> json) => WooTaxLine(
        id: WooJson.readInt(json, 'id'),
        rateCode: WooJson.readString(json, 'rate_code'),
        rateId: WooJson.readString(json, 'rate_id'),
        label: WooJson.readString(json, 'label'),
        compound: WooJson.readBool(json, 'compound'),
        taxTotal: WooJson.readDouble(json, 'tax_total'),
        shippingTaxTotal: WooJson.readDouble(json, 'shipping_tax_total'),
        metaData: WooJson.readList(json, 'meta_data', WooMetaData.fromJson),
      );
  factory WooTaxLine.fake() => WooTaxLine(
        id: FakeHelper.integer(),
        rateCode: FakeHelper.word(),
        rateId: FakeHelper.integer().toString(),
        label: FakeHelper.word(),
        compound: FakeHelper.boolean(),
        taxTotal: FakeHelper.decimal(),
        shippingTaxTotal: FakeHelper.decimal(),
        metaData: FakeHelper.list(() => WooMetaData.fake()),
      );
  final int? id;
  final String? rateCode;
  final String? rateId;
  final String? label;
  final bool? compound;
  final double? taxTotal;
  final double? shippingTaxTotal;
  final List<WooMetaData>? metaData;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putIfPresent('rate_code', rateCode)
    ..putIfPresent('rate_id', rateId)
    ..putIfPresent('label', label)
    ..putIfPresent('compound', compound)
    ..putIfPresent('tax_total', taxTotal)
    ..putIfPresent('shipping_tax_total', shippingTaxTotal)
    ..putIfPresent('meta_data', metaData?.map((v) => v.toJson()).toList());
  WooTaxLine copyWith({
    int? id,
    String? rateCode,
    String? rateId,
    String? label,
    bool? compound,
    double? taxTotal,
    double? shippingTaxTotal,
    List<WooMetaData>? metaData,
  }) =>
      WooTaxLine(
        id: id ?? this.id,
        rateCode: rateCode ?? this.rateCode,
        rateId: rateId ?? this.rateId,
        label: label ?? this.label,
        compound: compound ?? this.compound,
        taxTotal: taxTotal ?? this.taxTotal,
        shippingTaxTotal: shippingTaxTotal ?? this.shippingTaxTotal,
        metaData: metaData ?? this.metaData,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooTaxLine &&
          other.id == id &&
          other.rateCode == rateCode &&
          other.rateId == rateId &&
          other.label == label &&
          other.compound == compound &&
          other.taxTotal == taxTotal &&
          other.shippingTaxTotal == shippingTaxTotal &&
          WooJson.listEquals(other.metaData, metaData);
  @override
  int get hashCode => Object.hashAll([
        id,
        rateCode,
        rateId,
        label,
        compound,
        taxTotal,
        shippingTaxTotal,
        ...(metaData ?? const []),
      ]);
  @override
  String toString() {
    return 'WooTaxLine(id: $id, rateCode: $rateCode, label: $label, taxTotal: $taxTotal)';
  }
}
