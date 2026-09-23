import '../../base/models/metadata.dart';
import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';
import 'tax.dart';

class WooLineItem {
  WooLineItem({
    this.id,
    this.name,
    this.productId,
    this.variationId,
    this.quantity,
    this.taxClass,
    this.subtotal,
    this.subtotalTax,
    this.total,
    this.totalTax,
    this.taxes,
    this.metaData,
    this.sku,
    this.price,
  });
  factory WooLineItem.fromJson(Map<String, dynamic> json) => WooLineItem(
        id: WooJson.readInt(json, 'id'),
        name: WooJson.readString(json, 'name'),
        productId: WooJson.readInt(json, 'product_id'),
        variationId: WooJson.readInt(json, 'variation_id'),
        quantity: WooJson.readInt(json, 'quantity'),
        taxClass: WooJson.readString(json, 'tax_class'),
        subtotal: WooJson.readDouble(json, 'subtotal'),
        subtotalTax: WooJson.readDouble(json, 'subtotal_tax'),
        total: WooJson.readDouble(json, 'total'),
        totalTax: WooJson.readDouble(json, 'total_tax'),
        taxes: WooJson.readList(json, 'taxes', WooTax.fromJson),
        metaData: WooJson.readList(json, 'meta_data', WooMetaData.fromJson),
        sku: WooJson.readString(json, 'sku'),
        price: WooJson.readDouble(json, 'price'),
      );
  factory WooLineItem.fake() => WooLineItem(
        id: FakeHelper.integer(),
        name: FakeHelper.word(),
        productId: FakeHelper.integer(),
        variationId: FakeHelper.integer(),
        quantity: FakeHelper.integer(),
        taxClass: FakeHelper.word(),
        subtotal: FakeHelper.decimal(),
        subtotalTax: FakeHelper.decimal(),
        total: FakeHelper.decimal(),
        totalTax: FakeHelper.decimal(),
        taxes: FakeHelper.list(() => WooTax.fake()),
        metaData: FakeHelper.list(() => WooMetaData.fake()),
        sku: FakeHelper.word(),
        price: FakeHelper.decimal(),
      );
  final int? id;
  final String? name;
  final int? productId;
  final int? variationId;
  final int? quantity;
  final String? taxClass;
  final double? subtotal;
  final double? subtotalTax;
  final double? total;
  final double? totalTax;
  final List<WooTax>? taxes;
  final List<WooMetaData>? metaData;
  final String? sku;
  final double? price;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putIfPresent('name', name)
    ..putIfPresent('product_id', productId)
    ..putIfPresent('variation_id', variationId)
    ..putIfPresent('quantity', quantity)
    ..putIfPresent('tax_class', taxClass)
    ..putIfPresent('subtotal', subtotal)
    ..putIfPresent('subtotal_tax', subtotalTax)
    ..putIfPresent('total', total)
    ..putIfPresent('total_tax', totalTax)
    ..putIfPresent('taxes', taxes?.map((v) => v.toJson()).toList())
    ..putIfPresent('meta_data', metaData?.map((v) => v.toJson()).toList())
    ..putIfPresent('sku', sku)
    ..putIfPresent('price', price);
  WooLineItem copyWith({
    int? id,
    String? name,
    int? productId,
    int? variationId,
    int? quantity,
    String? taxClass,
    double? subtotal,
    double? subtotalTax,
    double? total,
    double? totalTax,
    List<WooTax>? taxes,
    List<WooMetaData>? metaData,
    String? sku,
    double? price,
  }) =>
      WooLineItem(
        id: id ?? this.id,
        name: name ?? this.name,
        productId: productId ?? this.productId,
        variationId: variationId ?? this.variationId,
        quantity: quantity ?? this.quantity,
        taxClass: taxClass ?? this.taxClass,
        subtotal: subtotal ?? this.subtotal,
        subtotalTax: subtotalTax ?? this.subtotalTax,
        total: total ?? this.total,
        totalTax: totalTax ?? this.totalTax,
        taxes: taxes ?? this.taxes,
        metaData: metaData ?? this.metaData,
        sku: sku ?? this.sku,
        price: price ?? this.price,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooLineItem &&
          other.id == id &&
          other.name == name &&
          other.productId == productId &&
          other.variationId == variationId &&
          other.quantity == quantity &&
          other.taxClass == taxClass &&
          other.subtotal == subtotal &&
          other.subtotalTax == subtotalTax &&
          other.total == total &&
          other.totalTax == totalTax &&
          WooJson.listEquals(other.taxes, taxes) &&
          WooJson.listEquals(other.metaData, metaData) &&
          other.sku == sku &&
          other.price == price;
  @override
  int get hashCode => Object.hashAll([
        id,
        name,
        productId,
        variationId,
        quantity,
        taxClass,
        subtotal,
        subtotalTax,
        total,
        totalTax,
        ...(taxes ?? const []),
        ...(metaData ?? const []),
        sku,
        price,
      ]);
  @override
  String toString() {
    return 'WooLineItem(id: $id, name: $name, productId: $productId, quantity: $quantity, total: $total)';
  }
}
