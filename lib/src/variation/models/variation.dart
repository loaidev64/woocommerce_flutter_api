import 'package:woocommerce_flutter_api/src/base/base.dart';
import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';
import 'package:woocommerce_flutter_api/src/product/enums/enums.dart';
import 'package:woocommerce_flutter_api/src/product/models/models.dart';

class WooProductVariation {
  /// Unique identifier for the resource.
  int? id;

  /// The date the variation was created, in the site's timezone.
  DateTime? dateCreated;

  /// The date the variation was created, as GMT.
  DateTime? dateCreatedGmt;

  /// The date the variation was last modified, in the site's timezone.
  DateTime? dateModified;

  /// The date the variation was last modified, as GMT.
  DateTime? dateModifiedGmt;

  /// Variation description.
  String? description;

  /// Variation URL.
  String? permalink;

  /// Unique identifier.
  String? sku;

  /// Current variation price.
  double? price;

  /// Variation regular price.
  double? regularPrice;

  /// Variation sale price.
  double? salePrice;

  /// Start date of sale price, in the site's timezone.
  DateTime? dateOnSaleFrom;

  /// Start date of sale price, as GMT.
  DateTime? dateOnSaleFromGmt;

  /// End date of sale price, in the site's timezone.
  DateTime? dateOnSaleTo;

  /// End date of sale price, as GMT.
  DateTime? dateOnSaleToGmt;

  /// Shows if the variation is on sale.
  bool? onSale;

  /// Variation status. Options: draft, pending, private and publish. Default is publish.
  WooProductStatus? status;

  /// Shows if the variation can be bought.
  bool? purchasable;

  /// If the variation is virtual. Default is false.
  bool? virtual;

  /// If the variation is downloadable. Default is false.
  bool? downloadable;

  /// If the variation is downloadable. Default is false.
  List<WooProductDownload> downloads;

  /// Number of times downloadable files can be downloaded after purchase. Default is -1.
  int? downloadLimit;

  /// Number of days until access to downloadable files expires. Default is -1.
  int? downloadExpiry;

  /// Tax status. Options: taxable, shipping and none. Default is taxable.
  WooProductTaxStatus? taxStatus;

  /// Tax class.
  String? taxClass;

  /// Stock management at variation level. Default is false.
  bool? manageStock;

  /// Stock quantity.
  int? stockQuantity;

  /// Controls the stock status of the product. Options: instock, outofstock, onbackorder. Default is instock.
  WooProductStockStatus? stockStatus;

  /// If managing stock, this controls if backorders are allowed. Options: no, notify and yes. Default is no.
  WooProductBackorder? backorders;

  /// Shows if backorders are allowed.
  bool? backordersAllowed;

  /// Shows if the variation is on backordered.
  bool? backordered;

  /// Variation weight.
  String? weight;

  /// Variation dimensions.
  WooProductDimension dimensions;

  /// Shipping class slug.
  String? shippingClass;

  /// Shipping class ID.
  int? shippingClassId;

  /// Variation image data.
  WooProductImage? image;

  /// List of attributes.
  List<WooProductItemAttribute> attributes;

  /// Menu order, used to custom sort products.
  int? menuOrder;

  /// Meta data.
  List<WooMetaData> metaData;

  WooProductVariation(
      {this.id,
      this.dateCreated,
      this.dateCreatedGmt,
      this.dateModified,
      this.dateModifiedGmt,
      this.description,
      this.permalink,
      this.sku,
      this.price,
      this.attributes = const [],
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
      this.downloads = const [],
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
      this.dimensions = const WooProductDimension(),
      this.metaData = const [],
      this.image});

  WooProductVariation.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        permalink = json['permalink'],
        status = json['status'],
        description = json['description'],
        dateCreated = DateTime.parse(json['date_created']),
        dateCreatedGmt = DateTime.parse(json['date_modified_gmt']),
        dateModified = DateTime.parse(json['date_modified']),
        dateModifiedGmt = DateTime.parse(json['date_created_gmt']),
        dateOnSaleFrom = DateTime.parse(json['date_on_sale_from']),
        dateOnSaleFromGmt = DateTime.parse(json['date_on_sale_from_gmt']),
        dateOnSaleTo = DateTime.parse(json['date_on_sale_to']),
        dateOnSaleToGmt = DateTime.parse(json['date_on_sale_to_gmt']),
        sku = json['sku'],
        price = double.tryParse(json['price']),
        regularPrice = double.tryParse(json['regular_price']),
        salePrice = double.tryParse(json['sale_price']),
        onSale = json['on_sale'],
        purchasable = json['purchasable'],
        virtual = json['virtual'],
        downloadable = json['downloadable'],
        downloads = (json['downloads'] as List)
            .map((i) => WooProductDownload.fromJson(i))
            .toList(),
        downloadLimit = json['download_limit'],
        downloadExpiry = json['download_expiry'],
        taxStatus = json['tax_status'],
        taxClass = json['tax_class'],
        manageStock =
            (json['manage_stock'] != null && json['manage_stock'] is bool)
                ? json['manage_stock']
                : false,
        stockQuantity = json['stock_quantity'],
        stockStatus = json['stock_status'],
        backorders = json['backorders'],
        backordersAllowed = json['backorders_allowed'],
        backordered = json['backordered'],
        weight = json['weight'],
        image = WooProductImage.fromJson(json['image']),
        dimensions = WooProductDimension.fromJson(json['dimensions']),
        shippingClass = json['shipping_class'],
        shippingClassId = json['shipping_class_id'],
        menuOrder = json['menu_order'],
        attributes = (json['attributes'] as List)
            .map((i) => WooProductItemAttribute.fromJson(i))
            .toList(),
        metaData = (json['meta_data'] as List)
            .map((i) => WooMetaData.fromJson(i))
            .toList();

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
}
