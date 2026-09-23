import '../../base/models/metadata.dart';
import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';
import 'tax.dart';

class WooShippingLine {
  WooShippingLine({
    this.id,
    this.methodTitle,
    this.methodId,
    this.total,
    this.totalTax,
    this.taxes,
    this.metaData,
  });
  factory WooShippingLine.fromJson(Map<String, dynamic> json) =>
      WooShippingLine(
        id: WooJson.readInt(json, 'id'),
        methodTitle: WooJson.readString(json, 'method_title'),
        methodId: WooJson.readString(json, 'method_id'),
        total: WooJson.readDouble(json, 'total'),
        totalTax: WooJson.readDouble(json, 'total_tax'),
        taxes: WooJson.readList(json, 'taxes', WooTax.fromJson),
        metaData: WooJson.readList(json, 'meta_data', WooMetaData.fromJson),
      );
  factory WooShippingLine.fake() => WooShippingLine(
        id: FakeHelper.integer(),
        methodId: FakeHelper.integer().toString(),
        methodTitle: FakeHelper.word(),
        total: FakeHelper.decimal(),
        totalTax: FakeHelper.decimal(),
        taxes: FakeHelper.list(() => WooTax.fake()),
        metaData: FakeHelper.list(() => WooMetaData.fake()),
      );
  final int? id;
  final String? methodTitle;
  final String? methodId;
  final double? total;
  final double? totalTax;
  final List<WooTax>? taxes;
  final List<WooMetaData>? metaData;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putIfPresent('method_title', methodTitle)
    ..putIfPresent('method_id', methodId)
    ..putIfPresent('total', total)
    ..putIfPresent('total_tax', totalTax)
    ..putIfPresent('taxes', taxes?.map((v) => v.toJson()).toList())
    ..putIfPresent('meta_data', metaData?.map((v) => v.toJson()).toList());
  WooShippingLine copyWith({
    int? id,
    String? methodTitle,
    String? methodId,
    double? total,
    double? totalTax,
    List<WooTax>? taxes,
    List<WooMetaData>? metaData,
  }) =>
      WooShippingLine(
        id: id ?? this.id,
        methodTitle: methodTitle ?? this.methodTitle,
        methodId: methodId ?? this.methodId,
        total: total ?? this.total,
        totalTax: totalTax ?? this.totalTax,
        taxes: taxes ?? this.taxes,
        metaData: metaData ?? this.metaData,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooShippingLine &&
          other.id == id &&
          other.methodTitle == methodTitle &&
          other.methodId == methodId &&
          other.total == total &&
          other.totalTax == totalTax &&
          WooJson.listEquals(other.taxes, taxes) &&
          WooJson.listEquals(other.metaData, metaData);
  @override
  int get hashCode => Object.hashAll([
        id,
        methodTitle,
        methodId,
        total,
        totalTax,
        ...(taxes ?? const []),
        ...(metaData ?? const []),
      ]);
  @override
  String toString() {
    return 'WooShippingLine(id: $id, methodTitle: $methodTitle, methodId: $methodId, total: $total)';
  }
}
