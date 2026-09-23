import '../../base/models/metadata.dart';
import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';
import '../../product/enums/product_backorder.dart';
import '../../product/enums/product_status.dart';
import '../../product/enums/product_stock_status.dart';
import '../../product/enums/product_tax_status.dart';
import '../../product/models/product_dimension.dart';
import '../../product/models/product_download.dart';
import '../../product/models/product_image.dart';
import '../../product/models/product_item_attribute.dart';

class WooProductVariation {
  WooProductVariation({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.description,
    this.permalink,
    this.sku,
    this.price,
    this.attributes,
    this.regularPrice,
    this.salePrice,
    this.dateOnSaleFrom,
    this.dateOnSaleFromGmt,
    this.dateOnSaleTo,
    this.dateOnSaleToGmt,
    this.onSale,
    this.status,
    this.purchasable,
    this.virtual,
    this.downloadable,
    this.downloads,
    this.downloadLimit,
    this.downloadExpiry,
    this.taxStatus,
    this.taxClass,
    this.manageStock,
    this.stockQuantity,
    this.stockStatus,
    this.backorders,
    this.backordersAllowed,
    this.backordered,
    this.weight,
    this.shippingClass,
    this.shippingClassId,
    this.menuOrder,
    this.dimensions,
    this.metaData,
    this.image,
  });
  factory WooProductVariation.fromJson(Map<String, dynamic> json) {
    final imageJson = WooJson.readMap(json, 'image');
    final dimensionsJson = WooJson.readMap(json, 'dimensions');
    return WooProductVariation(
      id: WooJson.readInt(json, 'id'),
      dateCreated: WooJson.readDate(json, 'date_created'),
      dateCreatedGmt: WooJson.readDate(json, 'date_created_gmt'),
      dateModified: WooJson.readDate(json, 'date_modified'),
      dateModifiedGmt: WooJson.readDate(json, 'date_modified_gmt'),
      description: WooJson.readString(json, 'description'),
      permalink: WooJson.readString(json, 'permalink'),
      sku: WooJson.readString(json, 'sku'),
      price: WooJson.readDouble(json, 'price'),
      attributes: WooJson.readList(
        json,
        'attributes',
        WooProductItemAttribute.fromJson,
      ),
      regularPrice: WooJson.readDouble(json, 'regular_price'),
      salePrice: WooJson.readDouble(json, 'sale_price'),
      dateOnSaleFrom: WooJson.readDate(json, 'date_on_sale_from'),
      dateOnSaleFromGmt: WooJson.readDate(json, 'date_on_sale_from_gmt'),
      dateOnSaleTo: WooJson.readDate(json, 'date_on_sale_to'),
      dateOnSaleToGmt: WooJson.readDate(json, 'date_on_sale_to_gmt'),
      onSale: WooJson.readBool(json, 'on_sale'),
      status: WooJson.readEnum(json, 'status', WooProductStatus.values),
      purchasable: WooJson.readBool(json, 'purchasable'),
      virtual: WooJson.readBool(json, 'virtual'),
      downloadable: WooJson.readBool(json, 'downloadable'),
      downloads:
          WooJson.readList(json, 'downloads', WooProductDownload.fromJson),
      downloadLimit: WooJson.readInt(json, 'download_limit'),
      downloadExpiry: WooJson.readInt(json, 'download_expiry'),
      taxStatus:
          WooJson.readEnum(json, 'tax_status', WooProductTaxStatus.values),
      taxClass: WooJson.readString(json, 'tax_class'),
      manageStock: WooJson.readBool(json, 'manage_stock'),
      stockQuantity: WooJson.readInt(json, 'stock_quantity'),
      stockStatus: WooJson.readEnum(
        json,
        'stock_status',
        WooProductStockStatus.values,
      ),
      backorders:
          WooJson.readEnum(json, 'backorders', WooProductBackorder.values),
      backordersAllowed: WooJson.readBool(json, 'backorders_allowed'),
      backordered: WooJson.readBool(json, 'backordered'),
      weight: WooJson.readString(json, 'weight'),
      shippingClass: WooJson.readString(json, 'shipping_class'),
      shippingClassId: WooJson.readInt(json, 'shipping_class_id'),
      menuOrder: WooJson.readInt(json, 'menu_order'),
      dimensions: dimensionsJson == null
          ? null
          : WooProductDimension.fromJson(dimensionsJson),
      metaData: WooJson.readList(json, 'meta_data', WooMetaData.fromJson),
      image: imageJson == null ? null : WooProductImage.fromJson(imageJson),
    );
  }
  factory WooProductVariation.fake() => WooProductVariation(
        id: FakeHelper.integer(),
        permalink: FakeHelper.url(),
        status: WooProductStatus.fake(),
        description: FakeHelper.sentence(),
        sku: FakeHelper.word(),
        price: FakeHelper.decimal(),
        regularPrice: FakeHelper.decimal(),
        salePrice: FakeHelper.decimal(),
        onSale: FakeHelper.boolean(),
        purchasable: FakeHelper.boolean(),
        virtual: FakeHelper.boolean(),
        downloadable: FakeHelper.boolean(),
        downloads: FakeHelper.list(() => WooProductDownload.fake()),
        downloadLimit: FakeHelper.integer(),
        downloadExpiry: FakeHelper.integer(),
        taxStatus: WooProductTaxStatus.fake(),
        taxClass: FakeHelper.word(),
        manageStock: FakeHelper.boolean(),
        stockQuantity: FakeHelper.integer(),
        stockStatus: WooProductStockStatus.fake(),
        backorders: WooProductBackorder.fake(),
        backordersAllowed: FakeHelper.boolean(),
        backordered: FakeHelper.boolean(),
        weight: FakeHelper.decimal().toString(),
        dimensions: WooProductDimension.fake(),
        shippingClass: FakeHelper.word(),
        shippingClassId: FakeHelper.integer(),
        image: WooProductImage.fake(),
        attributes: FakeHelper.list(() => WooProductItemAttribute.fake()),
        menuOrder: FakeHelper.integer(),
        metaData: FakeHelper.list(() => WooMetaData.fake()),
        dateCreated: FakeHelper.datetime(),
        dateCreatedGmt: FakeHelper.datetime(),
        dateModified: FakeHelper.datetime(),
        dateModifiedGmt: FakeHelper.datetime(),
        dateOnSaleFrom: FakeHelper.datetime(),
        dateOnSaleFromGmt: FakeHelper.datetime(),
        dateOnSaleTo: FakeHelper.datetime(),
        dateOnSaleToGmt: FakeHelper.datetime(),
      );
  final int? id;
  final DateTime? dateCreated;
  final DateTime? dateCreatedGmt;
  final DateTime? dateModified;
  final DateTime? dateModifiedGmt;
  final String? description;
  final String? permalink;
  final String? sku;
  final double? price;
  final List<WooProductItemAttribute>? attributes;
  final double? regularPrice;
  final double? salePrice;
  final DateTime? dateOnSaleFrom;
  final DateTime? dateOnSaleFromGmt;
  final DateTime? dateOnSaleTo;
  final DateTime? dateOnSaleToGmt;
  final bool? onSale;
  final WooProductStatus? status;
  final bool? purchasable;
  final bool? virtual;
  final bool? downloadable;
  final List<WooProductDownload>? downloads;
  final int? downloadLimit;
  final int? downloadExpiry;
  final WooProductTaxStatus? taxStatus;
  final String? taxClass;
  final bool? manageStock;
  final int? stockQuantity;
  final WooProductStockStatus? stockStatus;
  final WooProductBackorder? backorders;
  final bool? backordersAllowed;
  final bool? backordered;
  final String? weight;
  final String? shippingClass;
  final int? shippingClassId;
  final int? menuOrder;
  final WooProductDimension? dimensions;
  final List<WooMetaData>? metaData;
  final WooProductImage? image;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putDate('date_created', dateCreated)
    ..putDate('date_created_gmt', dateCreatedGmt)
    ..putDate('date_modified', dateModified)
    ..putDate('date_modified_gmt', dateModifiedGmt)
    ..putIfPresent('description', description)
    ..putIfPresent('permalink', permalink)
    ..putIfPresent('sku', sku)
    ..putIfPresent('price', price)
    ..putIfPresent('regular_price', regularPrice)
    ..putIfPresent('sale_price', salePrice)
    ..putDate('date_on_sale_from', dateOnSaleFrom)
    ..putDate('date_on_sale_from_gmt', dateOnSaleFromGmt)
    ..putDate('date_on_sale_to', dateOnSaleTo)
    ..putDate('date_on_sale_to_gmt', dateOnSaleToGmt)
    ..putIfPresent('on_sale', onSale)
    ..putEnum('status', status)
    ..putIfPresent('purchasable', purchasable)
    ..putIfPresent('virtual', virtual)
    ..putIfPresent('downloadable', downloadable)
    ..putIfPresent('downloads', downloads?.map((e) => e.toJson()).toList())
    ..putIfPresent('download_limit', downloadLimit)
    ..putIfPresent('download_expiry', downloadExpiry)
    ..putEnum('tax_status', taxStatus)
    ..putIfPresent('tax_class', taxClass)
    ..putIfPresent('manage_stock', manageStock)
    ..putIfPresent('stock_quantity', stockQuantity)
    ..putEnum('stock_status', stockStatus)
    ..putEnum('backorders', backorders)
    ..putIfPresent('backorders_allowed', backordersAllowed)
    ..putIfPresent('backordered', backordered)
    ..putIfPresent('weight', weight)
    ..putIfPresent('shipping_class', shippingClass)
    ..putIfPresent('shipping_class_id', shippingClassId)
    ..putIfPresent('menu_order', menuOrder)
    ..putIfPresent('dimensions', dimensions?.toJson())
    ..putIfPresent('meta_data', metaData?.map((e) => e.toJson()).toList())
    ..putIfPresent('image', image?.toJson())
    ..putIfPresent('attributes', attributes?.map((e) => e.toJson()).toList());
  WooProductVariation copyWith({
    int? id,
    DateTime? dateCreated,
    DateTime? dateCreatedGmt,
    DateTime? dateModified,
    DateTime? dateModifiedGmt,
    String? description,
    String? permalink,
    String? sku,
    double? price,
    List<WooProductItemAttribute>? attributes,
    double? regularPrice,
    double? salePrice,
    DateTime? dateOnSaleFrom,
    DateTime? dateOnSaleFromGmt,
    DateTime? dateOnSaleTo,
    DateTime? dateOnSaleToGmt,
    bool? onSale,
    WooProductStatus? status,
    bool? purchasable,
    bool? virtual,
    bool? downloadable,
    List<WooProductDownload>? downloads,
    int? downloadLimit,
    int? downloadExpiry,
    WooProductTaxStatus? taxStatus,
    String? taxClass,
    bool? manageStock,
    int? stockQuantity,
    WooProductStockStatus? stockStatus,
    WooProductBackorder? backorders,
    bool? backordersAllowed,
    bool? backordered,
    String? weight,
    String? shippingClass,
    int? shippingClassId,
    int? menuOrder,
    WooProductDimension? dimensions,
    List<WooMetaData>? metaData,
    WooProductImage? image,
  }) =>
      WooProductVariation(
        id: id ?? this.id,
        dateCreated: dateCreated ?? this.dateCreated,
        dateCreatedGmt: dateCreatedGmt ?? this.dateCreatedGmt,
        dateModified: dateModified ?? this.dateModified,
        dateModifiedGmt: dateModifiedGmt ?? this.dateModifiedGmt,
        description: description ?? this.description,
        permalink: permalink ?? this.permalink,
        sku: sku ?? this.sku,
        price: price ?? this.price,
        attributes: attributes ?? this.attributes,
        regularPrice: regularPrice ?? this.regularPrice,
        salePrice: salePrice ?? this.salePrice,
        dateOnSaleFrom: dateOnSaleFrom ?? this.dateOnSaleFrom,
        dateOnSaleFromGmt: dateOnSaleFromGmt ?? this.dateOnSaleFromGmt,
        dateOnSaleTo: dateOnSaleTo ?? this.dateOnSaleTo,
        dateOnSaleToGmt: dateOnSaleToGmt ?? this.dateOnSaleToGmt,
        onSale: onSale ?? this.onSale,
        status: status ?? this.status,
        purchasable: purchasable ?? this.purchasable,
        virtual: virtual ?? this.virtual,
        downloadable: downloadable ?? this.downloadable,
        downloads: downloads ?? this.downloads,
        downloadLimit: downloadLimit ?? this.downloadLimit,
        downloadExpiry: downloadExpiry ?? this.downloadExpiry,
        taxStatus: taxStatus ?? this.taxStatus,
        taxClass: taxClass ?? this.taxClass,
        manageStock: manageStock ?? this.manageStock,
        stockQuantity: stockQuantity ?? this.stockQuantity,
        stockStatus: stockStatus ?? this.stockStatus,
        backorders: backorders ?? this.backorders,
        backordersAllowed: backordersAllowed ?? this.backordersAllowed,
        backordered: backordered ?? this.backordered,
        weight: weight ?? this.weight,
        shippingClass: shippingClass ?? this.shippingClass,
        shippingClassId: shippingClassId ?? this.shippingClassId,
        menuOrder: menuOrder ?? this.menuOrder,
        dimensions: dimensions ?? this.dimensions,
        metaData: metaData ?? this.metaData,
        image: image ?? this.image,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductVariation &&
          other.id == id &&
          other.dateCreated == dateCreated &&
          other.dateCreatedGmt == dateCreatedGmt &&
          other.dateModified == dateModified &&
          other.dateModifiedGmt == dateModifiedGmt &&
          other.description == description &&
          other.permalink == permalink &&
          other.sku == sku &&
          other.price == price &&
          WooJson.listEquals(other.attributes, attributes) &&
          other.regularPrice == regularPrice &&
          other.salePrice == salePrice &&
          other.dateOnSaleFrom == dateOnSaleFrom &&
          other.dateOnSaleFromGmt == dateOnSaleFromGmt &&
          other.dateOnSaleTo == dateOnSaleTo &&
          other.dateOnSaleToGmt == dateOnSaleToGmt &&
          other.onSale == onSale &&
          other.status == status &&
          other.purchasable == purchasable &&
          other.virtual == virtual &&
          other.downloadable == downloadable &&
          WooJson.listEquals(other.downloads, downloads) &&
          other.downloadLimit == downloadLimit &&
          other.downloadExpiry == downloadExpiry &&
          other.taxStatus == taxStatus &&
          other.taxClass == taxClass &&
          other.manageStock == manageStock &&
          other.stockQuantity == stockQuantity &&
          other.stockStatus == stockStatus &&
          other.backorders == backorders &&
          other.backordersAllowed == backordersAllowed &&
          other.backordered == backordered &&
          other.weight == weight &&
          other.shippingClass == shippingClass &&
          other.shippingClassId == shippingClassId &&
          other.menuOrder == menuOrder &&
          other.dimensions == dimensions &&
          WooJson.listEquals(other.metaData, metaData) &&
          other.image == image;
  @override
  int get hashCode => Object.hashAll([
        id,
        dateCreated,
        dateCreatedGmt,
        dateModified,
        dateModifiedGmt,
        description,
        permalink,
        sku,
        price,
        ...(attributes ?? const []),
        regularPrice,
        salePrice,
        dateOnSaleFrom,
        dateOnSaleFromGmt,
        dateOnSaleTo,
        dateOnSaleToGmt,
        onSale,
        status,
        purchasable,
        virtual,
        downloadable,
        ...(downloads ?? const []),
        downloadLimit,
        downloadExpiry,
        taxStatus,
        taxClass,
        manageStock,
        stockQuantity,
        stockStatus,
        backorders,
        backordersAllowed,
        backordered,
        weight,
        shippingClass,
        shippingClassId,
        menuOrder,
        dimensions,
        ...(metaData ?? const []),
        image,
      ]);
  @override
  String toString() => 'WooProductVariation(id: $id, sku: $sku, price: $price, '
      'status: $status, stockStatus: $stockStatus)';
}
