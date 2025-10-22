import 'package:woocommerce_flutter_api/src/base/base.dart';
import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';
import 'package:woocommerce_flutter_api/src/product/enums/enums.dart';
import 'package:woocommerce_flutter_api/src/product/models/models.dart';

/// WooCommerce Product Variation Model
///
/// Represents a product variation in WooCommerce, which is a specific version of a variable product
/// with its own attributes, pricing, inventory, and other properties. Variations allow customers
/// to choose different options like size, color, material, etc., for the same base product.
///
/// ## Key Features
///
/// - **Attribute Management**: Store and manage variation-specific attributes
/// - **Pricing Control**: Set individual prices, sale prices, and sale periods
/// - **Inventory Management**: Track stock levels, backorders, and stock status
/// - **Download Support**: Handle downloadable products with download limits and expiry
/// - **Shipping Configuration**: Set weight, dimensions, and shipping class
/// - **Tax Configuration**: Configure tax status and tax class per variation
///
/// ## Usage Examples
///
/// ### Creating a Product Variation
///
/// ```dart
/// final variation = WooProductVariation(
///   sku: 'T-SHIRT-RED-L',
///   price: 25.99,
///   regularPrice: 29.99,
///   salePrice: 25.99,
///   stockQuantity: 50,
///   stockStatus: WooProductStockStatus.instock,
/// );
/// ```
///
/// ### Working with Variation Data
///
/// ```dart
/// // Check if variation is on sale
/// if (variation.onSale == true) {
///   print('Sale price: ${variation.salePrice}');
/// }
///
/// // Check stock availability
/// if (variation.stockStatus == WooProductStockStatus.instock) {
///   print('Available quantity: ${variation.stockQuantity}');
/// }
/// ```
///
/// ## JSON Serialization
///
/// The class supports full JSON serialization for API communication:
///
/// ```dart
/// // Convert to JSON for API requests
/// final json = variation.toJson();
///
/// // Create from JSON response
/// final variation = WooProductVariation.fromJson(jsonData);
/// ```
class WooProductVariation {

  /// Creates a new WooProductVariation instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional for flexibility in creating variations.
  ///
  /// ## Optional Parameters
  ///
  /// * [id] - Unique identifier for the variation
  /// * [sku] - Stock Keeping Unit identifier
  /// * [price] - Current variation price
  /// * [regularPrice] - Regular price before any discounts
  /// * [salePrice] - Sale price when on sale
  /// * [stockQuantity] - Available stock quantity
  /// * [stockStatus] - Current stock status (instock, outofstock, onbackorder)
  /// * [status] - Variation status (draft, pending, private, publish)
  /// * [description] - Variation description
  /// * [attributes] - List of variation attributes
  /// * [image] - Variation image
  /// * [dimensions] - Product dimensions (weight, length, width, height)
  /// * [metaData] - Additional metadata
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final variation = WooProductVariation(
  ///   sku: 'T-SHIRT-RED-L',
  ///   price: 25.99,
  ///   regularPrice: 29.99,
  ///   stockQuantity: 50,
  ///   stockStatus: WooProductStockStatus.instock,
  /// );
  /// ```
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

  /// Creates a WooProductVariation instance from JSON data
  ///
  /// This factory constructor is used to deserialize variation data received
  /// from the WooCommerce REST API.
  ///
  /// ## Parameters
  ///
  /// * [json] - A Map containing the variation data in JSON format
  ///
  /// ## Returns
  ///
  /// A `WooProductVariation` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final variation = WooProductVariation.fromJson(jsonData);
  /// ```
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

  /// Creates a fake WooProductVariation instance for testing purposes
  ///
  /// This factory constructor generates a variation with random but realistic
  /// data, making it useful for testing and development.
  ///
  /// ## Returns
  ///
  /// A `WooProductVariation` instance with randomly generated fake data.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final fakeVariation = WooProductVariation.fake();
  /// ```
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

  /// Converts the WooProductVariation instance to JSON format
  ///
  /// This method serializes the variation data into a Map that can be sent
  /// to the WooCommerce REST API.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the variation data in JSON format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final jsonData = variation.toJson();
  /// ```
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date_created': dateCreated?.toIso8601String(),
      'date_created_gmt': dateCreatedGmt?.toIso8601String(),
      'date_modified': dateModified?.toIso8601String(),
      'date_modified_gmt': dateModifiedGmt?.toIso8601String(),
      'description': description,
      'permalink': permalink,
      'sku': sku,
      'price': price?.toString(),
      'regular_price': regularPrice?.toString(),
      'sale_price': salePrice?.toString(),
      'date_on_sale_from': dateOnSaleFrom?.toIso8601String(),
      'date_on_sale_from_gmt': dateOnSaleFromGmt?.toIso8601String(),
      'date_on_sale_to': dateOnSaleTo?.toIso8601String(),
      'date_on_sale_to_gmt': dateOnSaleToGmt?.toIso8601String(),
      'on_sale': onSale,
      'status': status?.name,
      'purchasable': purchasable,
      'virtual': virtual,
      'downloadable': downloadable,
      'downloads': downloads.map((download) => download.toJson()).toList(),
      'download_limit': downloadLimit,
      'download_expiry': downloadExpiry,
      'tax_status': taxStatus?.name,
      'tax_class': taxClass,
      'manage_stock': manageStock,
      'stock_quantity': stockQuantity,
      'stock_status': stockStatus?.name,
      'backorders': backorders?.name,
      'backorders_allowed': backordersAllowed,
      'backordered': backordered,
      'weight': weight,
      'dimensions': dimensions.toJson(),
      'shipping_class': shippingClass,
      'shipping_class_id': shippingClassId,
      'image': image?.toJson(),
      'attributes': attributes.map((attr) => attr.toJson()).toList(),
      'menu_order': menuOrder,
      'meta_data': metaData.map((meta) => meta.toJson()).toList(),
    };
  }

  /// Returns a string representation of the WooProductVariation instance
  ///
  /// This method provides a human-readable representation of the variation,
  /// displaying all main fields for debugging and logging purposes.
  ///
  /// ## Returns
  ///
  /// A `String` containing the variation's main field values in a readable format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final variation = WooProductVariation(sku: 'T-SHIRT-RED-L', price: 25.99);
  /// print(variation.toString());
  /// // Output: WooProductVariation(id: 1, sku: T-SHIRT-RED-L, price: 25.99, status: publish, stockStatus: instock)
  /// ```
  @override
  String toString() {
    return 'WooProductVariation(id: $id, sku: $sku, price: $price, status: $status, stockStatus: $stockStatus)';
  }
}
