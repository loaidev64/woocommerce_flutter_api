import '../../base/models/metadata.dart';
import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';
import '../enums/order_tax_status.dart';
import 'fee_line_tax.dart';

class WooOrderFeeLine {
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
  factory WooOrderFeeLine.fromJson(Map<String, dynamic> json) =>
      WooOrderFeeLine(
        id: WooJson.readInt(json, 'id'),
        name: WooJson.readString(json, 'name'),
        taxClass: WooJson.readString(json, 'tax_class'),
        taxStatus:
            WooJson.readEnum(json, 'tax_status', WooOrderTaxStatus.values),
        total: WooJson.readDouble(json, 'total'),
        totalTax: WooJson.readDouble(json, 'total_tax'),
        taxes: WooJson.readListOrEmpty(json, 'taxes', WooFeeLineTax.fromJson),
        metaData:
            WooJson.readListOrEmpty(json, 'meta_data', WooMetaData.fromJson),
      );
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
  final int? id;
  final String? name;
  final String? taxClass;
  final WooOrderTaxStatus? taxStatus;
  final double? total;
  final double? totalTax;
  final List<WooFeeLineTax> taxes;
  final List<WooMetaData> metaData;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putIfPresent('name', name)
    ..putIfPresent('tax_class', taxClass)
    ..putEnum('tax_status', taxStatus)
    ..putIfPresent('total', total)
    ..putIfPresent('total_tax', totalTax)
    ..putIfPresent('taxes', taxes.map((v) => v.toJson()).toList())
    ..putIfPresent('meta_data', metaData.map((v) => v.toJson()).toList());
  WooOrderFeeLine copyWith({
    int? id,
    String? name,
    String? taxClass,
    WooOrderTaxStatus? taxStatus,
    double? totalTax,
    double? total,
    List<WooFeeLineTax>? taxes,
    List<WooMetaData>? metaData,
  }) =>
      WooOrderFeeLine(
        id: id ?? this.id,
        name: name ?? this.name,
        taxClass: taxClass ?? this.taxClass,
        taxStatus: taxStatus ?? this.taxStatus,
        totalTax: totalTax ?? this.totalTax,
        total: total ?? this.total,
        taxes: taxes ?? this.taxes,
        metaData: metaData ?? this.metaData,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooOrderFeeLine &&
          other.id == id &&
          other.name == name &&
          other.taxClass == taxClass &&
          other.taxStatus == taxStatus &&
          other.totalTax == totalTax &&
          other.total == total &&
          WooJson.listEquals(other.taxes, taxes) &&
          WooJson.listEquals(other.metaData, metaData);
  @override
  int get hashCode => Object.hashAll([
        id,
        name,
        taxClass,
        taxStatus,
        totalTax,
        total,
        ...taxes,
        ...metaData,
      ]);
  @override
  String toString() {
    return 'WooOrderFeeLine(id: $id, name: $name, total: $total, totalTax: $totalTax)';
  }
}
