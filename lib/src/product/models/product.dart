import 'package:woocommerce_flutter_api/src/category/models/category.dart';
import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';
import 'package:woocommerce_flutter_api/src/product/enums/product_backorder.dart';
import 'package:woocommerce_flutter_api/src/product/enums/product_catalog_visibility.dart';
import 'package:woocommerce_flutter_api/src/product/enums/product_stock_status.dart';
import 'package:woocommerce_flutter_api/src/product/enums/product_tax_status.dart';

import '../enums/product_status.dart';
import '../enums/product_type.dart';
import '../../base/models/metadata.dart';
import 'product_dimension.dart';
import 'product_download.dart';
import 'product_image.dart';
import 'product_item_attribute.dart';
import 'product_tag.dart';

/// Represents a WooCommerce product with all its attributes and metadata.
///
/// This class models a complete WooCommerce product including basic information,
/// pricing, inventory, shipping, categories, tags, images, and more.
///
/// ## Key Features
///
/// - **Product Information**: Name, description, SKU, type, status
/// - **Pricing**: Regular price, sale price, price formatting
/// - **Inventory Management**: Stock quantity, stock status, backorders
/// - **Shipping**: Weight, dimensions, shipping class
/// - **Categories & Tags**: Product categorization and tagging
/// - **Images**: Product gallery and featured images
/// - **Attributes**: Custom product attributes and variations
/// - **SEO**: Slug, permalink for search engine optimization
///
/// ## Usage Examples
///
/// ### Creating a Simple Product
///
/// ```dart
/// final product = WooProduct(
///   name: 'Sample Product',
///   type: WooProductType.simple,
///   status: WooProductStatus.publish,
///   price: 29.99,
///   description: 'A sample product description',
/// );
/// ```
///
/// ### Working with Product Data
///
/// ```dart
/// // Check if product is on sale
/// if (product.onSale == true) {
///   print('Sale price: ${product.salePrice}');
/// }
///
/// // Get product images
/// for (final image in product.images) {
///   print('Image URL: ${image.src}');
/// }
///
/// // Check stock status
/// if (product.stockStatus == WooProductStockStatus.instock) {
///   print('Product is in stock');
/// }
/// ```
///
/// ## JSON Serialization
///
/// The class supports full JSON serialization for API communication:
///
/// ```dart
/// // Convert to JSON for API requests
/// final json = product.toJson();
///
/// // Create from JSON response
/// final product = WooProduct.fromJson(jsonData);
/// ```
class WooProduct {
  /// Unique identifier for the resource.
  final int? id;

  /// Product name.
  final String? name;

  /// Product slug.
  final String? slug;

  /// Product URL.
  final String? permalink;

  /// The date the variation was created, in the site's timezone.
  DateTime? dateCreated;

  /// The date the variation was created, as GMT.
  DateTime? dateCreatedGmt;

  /// The date the variation was last modified, in the site's timezone.
  DateTime? dateModified;

  /// The date the variation was last modified, as GMT.
  DateTime? dateModifiedGmt;

  /// Product type. Options: simple, grouped, external and variable. Default is simple.
  final WooProductType? type;

  /// Product status (post status). Options: draft, pending, private and publish. Default is publish.
  final WooProductStatus? status;

  /// Featured product. Default is false.
  final bool? featured;

  /// Catalog visibility. Options: visible, catalog, search and hidden. Default is visible.
  final WooProductCatalogVisibility? catalogVisibility;

  /// Product description.
  final String? description;

  /// Product short description.
  final String? shortDescription;

  /// Unique identifier.
  final String? sku;

  /// Current product price.
  final double? price;

  /// Product regular price.
  final double? regularPrice;

  /// Product sale price.
  final double? salePrice;

  /// Start date of sale price, in the site's timezone.
  DateTime? dateOnSaleFrom;

  /// Start date of sale price, as GMT.
  DateTime? dateOnSaleFromGmt;

  /// End date of sale price, in the site's timezone.
  DateTime? dateOnSaleTo;

  /// End date of sale price, as GMT.
  DateTime? dateOnSaleToGmt;

  /// Price formatted in HTML.
  final String? priceHtml;

  /// Shows if the product is on sale.
  final bool? onSale;

  /// Shows if the product can be bought.
  final bool? purchasable;

  /// Amount of sales.
  final int? totalSales;

  /// If the product is virtual. Default is false.
  final bool? virtual;

  /// If the product is downloadable. Default is false.
  final bool? downloadable;

  /// List of downloadable files.
  final List<WooProductDownload> downloads;

  /// Number of times downloadable files can be downloaded after purchase. Default is -1.
  final int? downloadLimit;

  /// Number of days until access to downloadable files expires. Default is -1.
  final int? downloadExpiry;

  /// Product external URL. Only for external products.
  final String? externalUrl;

  /// Product external button text. Only for external products.
  final String? buttonText;

  /// Tax status. Options: taxable, shipping and none. Default is taxable.
  final WooProductTaxStatus? taxStatus;

  /// Tax class.
  final String? taxClass;

  /// Stock management at product level. Default is false.
  final bool? manageStock;

  /// Stock quantity.
  final int? stockQuantity;

  /// Controls the stock status of the product. Options: instock, outofstock, onbackorder. Default is instock.
  final WooProductStockStatus? stockStatus;

  /// If managing stock, this controls if backorders are allowed. Options: no, notify and yes. Default is no.
  final WooProductBackorder? backorders;

  /// Shows if backorders are allowed.
  final bool? backordersAllowed;

  /// Shows if the product is on backordered.
  final bool? backordered;

  /// Allow one item to be bought in a single order. Default is false.
  final bool? soldIndividually;

  /// Product weight.
  final String? weight;

  /// Product dimensions.
  final WooProductDimension? dimensions;

  /// Shows if the product need to be shipped.
  final bool? shippingRequired;

  /// Shows whether or not the product shipping is taxable.
  final bool? shippingTaxable;

  /// Shipping class slug.
  final String? shippingClass;

  /// Shipping class ID.
  final int? shippingClassId;

  /// Allow reviews. Default is true.
  final bool? reviewsAllowed;

  /// Reviews average rating.
  final String? averageRating;

  /// Amount of reviews that the product have.
  final int? ratingCount;

  /// List of related products IDs.
  final List<int>? relatedIds;

  /// List of up-sell products IDs.
  final List<int>? upsellIds;

  /// List of cross-sell products IDs.
  final List<int>? crossSellIds;

  /// Product parent ID.
  final int? parentId;

  /// Optional note to send the customer after purchase.
  final String? purchaseNote;

  /// List of categories. it just includes id, name, slug
  final List<WooProductCategory> categories;

  /// List of tags.
  final List<WooProductTag> tags;

  /// List of images.
  final List<WooProductImage> images;

  /// List of attributes.
  final List<WooProductItemAttribute> attributes;

  /// Defaults variation attributes.
  final List<WooProductDefaultAttribute> defaultAttributes;

  /// List of variations IDs.
  final List<int>? variations;

  /// List of grouped products ID.
  final List<int>? groupedProducts;

  /// Menu order, used to custom sort products.
  final int? menuOrder;

  /// Meta data
  final List<WooMetaData> metaData;

  WooProduct({
    this.id,
    this.name,
    this.slug,
    this.permalink,
    this.type,
    this.status,
    this.featured,
    this.catalogVisibility,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.dateOnSaleFrom,
    this.dateOnSaleFromGmt,
    this.dateOnSaleTo,
    this.dateOnSaleToGmt,
    this.description,
    this.shortDescription,
    this.sku,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.priceHtml,
    this.onSale,
    this.purchasable,
    this.totalSales,
    this.virtual,
    this.downloadable,
    this.downloads = const [],
    this.downloadLimit,
    this.downloadExpiry,
    this.externalUrl,
    this.buttonText,
    this.taxStatus,
    this.taxClass,
    this.manageStock,
    this.stockQuantity,
    this.stockStatus,
    this.backorders,
    this.backordersAllowed,
    this.backordered,
    this.soldIndividually,
    this.weight,
    this.dimensions,
    this.shippingRequired,
    this.shippingTaxable,
    this.shippingClass,
    this.shippingClassId,
    this.reviewsAllowed,
    this.averageRating,
    this.ratingCount,
    this.relatedIds,
    this.upsellIds,
    this.crossSellIds,
    this.parentId,
    this.purchaseNote,
    this.categories = const [],
    this.tags = const [],
    this.images = const [],
    this.attributes = const [],
    this.defaultAttributes = const [],
    this.variations,
    this.groupedProducts,
    this.menuOrder,
    this.metaData = const [],
  });

  WooProduct.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        slug = json['slug'],
        dateCreated = json['date_created'] != null
            ? DateTime.parse(json['date_created'])
            : null,
        dateCreatedGmt = json['date_created_gmt'] != null
            ? DateTime.parse(json['date_created_gmt'])
            : null,
        dateModified = json['date_modified'] != null
            ? DateTime.parse(json['date_modified'])
            : null,
        dateModifiedGmt = json['date_modified_gmt'] != null
            ? DateTime.parse(json['date_modified_gmt'])
            : null,
        dateOnSaleFrom = json['date_on_sale_from'] != null
            ? DateTime.parse(json['date_on_sale_from'])
            : null,
        dateOnSaleFromGmt = json['date_on_sale_from_gmt'] != null
            ? DateTime.parse(json['date_on_sale_from_gmt'])
            : null,
        dateOnSaleTo = json['date_on_sale_to'] != null
            ? DateTime.parse(json['date_on_sale_to'])
            : null,
        dateOnSaleToGmt = json['date_on_sale_to_gmt'] != null
            ? DateTime.parse(json['date_on_sale_to_gmt'])
            : null,
        permalink = json['permalink'],
        type = WooProductType.fromString(json['type']),
        status = WooProductStatus.fromString(json['status']),
        featured = json['featured'],
        catalogVisibility =
            WooProductCatalogVisibility.fromString(json['catalog_visibility']),
        description = json['description'],
        shortDescription = json['short_description'],
        sku = json['sku'],
        price = double.tryParse(json['price']),
        regularPrice = double.tryParse(json['regular_price']),
        salePrice = double.tryParse(json['sale_price']),
        priceHtml = json['price_html'],
        onSale = json['on_sale'],
        purchasable = json['purchasable'],
        totalSales = json['total_sales'],
        virtual = json['virtual'],
        downloadable = json['downloadable'],
        downloads = (json['downloads'] as List)
            .map((i) => WooProductDownload.fromJson(i))
            .toList(),
        downloadLimit = json['download_limit'],
        downloadExpiry = json['download_expiry'],
        externalUrl = json['external_url'],
        buttonText = json['button_text'],
        taxStatus = WooProductTaxStatus.fromString(json['tax_status']),
        taxClass = json['tax_class'],
        manageStock = json['manage_stock'],
        stockQuantity = json['stock_quantity'],
        stockStatus = WooProductStockStatus.fromString(json['stock_status']),
        backorders = WooProductBackorder.fromString(json['backorders']),
        backordersAllowed = json['backorders_allowed'],
        backordered = json['backordered'],
        soldIndividually = json['sold_individually'],
        weight = json['weight'],
        dimensions = WooProductDimension.fromJson(json['dimensions']),
        shippingRequired = json['shipping_required'],
        shippingTaxable = json['shipping_taxable'],
        shippingClass = json['shipping_class'],
        shippingClassId = json['shipping_class_id'],
        reviewsAllowed = json['reviews_allowed'],
        averageRating = json['average_rating'],
        ratingCount = json['rating_count'],
        relatedIds = json['related_ids'].cast<int>(),
        upsellIds = json['upsell_ids'].cast<int>(),
        crossSellIds = json['cross_sell_ids'].cast<int>(),
        parentId = json['parent_id'],
        purchaseNote = json['purchase_note'],
        categories = (json['categories'] as List)
            .map((i) => WooProductCategory.fromJson(i))
            .toList(),
        tags = (json['tags'] as List)
            .map((i) => WooProductTag.fromJson(i))
            .toList(),
        images = (json['images'] as List)
            .map((i) => WooProductImage.fromJson(i))
            .toList(),
        attributes = (json['attributes'] as List)
            .map((i) => WooProductItemAttribute.fromJson(i))
            .toList(),
        defaultAttributes = (json['default_attributes'] as List)
            .map((i) => WooProductDefaultAttribute.fromJson(i))
            .toList(),
        variations = json['variations'].cast<int>(),
        groupedProducts = json['grouped_products'].cast<int>(),
        menuOrder = json['menu_order'],
        metaData = (json['meta_data'] as List)
            .map((i) => WooMetaData.fromJson(i))
            .toList();

  @override
  toString() => "{id: $id}, {name: $name}, {price: $price}, {status: $status}";

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WooProduct && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }

  /// Creates a copy of this [WooProduct] with the given fields replaced with new values.
  ///
  /// This method is useful for updating product data without modifying the original object.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final updatedProduct = product.copyWith(
  ///   name: 'Updated Product Name',
  ///   price: 39.99,
  ///   onSale: true,
  /// );
  /// ```
  WooProduct copyWith({
    int? id,
    String? name,
    String? slug,
    String? permalink,
    DateTime? dateCreated,
    DateTime? dateCreatedGmt,
    DateTime? dateModified,
    DateTime? dateModifiedGmt,
    DateTime? dateOnSaleFrom,
    DateTime? dateOnSaleFromGmt,
    DateTime? dateOnSaleTo,
    DateTime? dateOnSaleToGmt,
    WooProductType? type,
    WooProductStatus? status,
    bool? featured,
    WooProductCatalogVisibility? catalogVisibility,
    String? description,
    String? shortDescription,
    String? sku,
    double? price,
    double? regularPrice,
    double? salePrice,
    String? priceHtml,
    bool? onSale,
    bool? purchasable,
    int? totalSales,
    bool? virtual,
    bool? downloadable,
    List<WooProductDownload>? downloads,
    int? downloadLimit,
    int? downloadExpiry,
    String? externalUrl,
    String? buttonText,
    WooProductTaxStatus? taxStatus,
    String? taxClass,
    bool? manageStock,
    int? stockQuantity,
    WooProductStockStatus? stockStatus,
    WooProductBackorder? backorders,
    bool? backordersAllowed,
    bool? backordered,
    bool? soldIndividually,
    String? weight,
    WooProductDimension? dimensions,
    bool? shippingRequired,
    bool? shippingTaxable,
    String? shippingClass,
    int? shippingClassId,
    bool? reviewsAllowed,
    String? averageRating,
    int? ratingCount,
    List<int>? relatedIds,
    List<int>? upsellIds,
    List<int>? crossSellIds,
    int? parentId,
    String? purchaseNote,
    List<WooProductCategory>? categories,
    List<WooProductTag>? tags,
    List<WooProductImage>? images,
    List<WooProductItemAttribute>? attributes,
    List<WooProductDefaultAttribute>? defaultAttributes,
    List<int>? variations,
    List<int>? groupedProducts,
    int? menuOrder,
    List<WooMetaData>? metaData,
  }) {
    return WooProduct(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      permalink: permalink ?? this.permalink,
      dateCreated: dateCreated ?? this.dateCreated,
      dateCreatedGmt: dateCreatedGmt ?? this.dateCreatedGmt,
      dateModified: dateModified ?? this.dateModified,
      dateModifiedGmt: dateModifiedGmt ?? this.dateModifiedGmt,
      dateOnSaleFrom: dateOnSaleFrom ?? this.dateOnSaleFrom,
      dateOnSaleFromGmt: dateOnSaleFromGmt ?? this.dateOnSaleFromGmt,
      dateOnSaleTo: dateOnSaleTo ?? this.dateOnSaleTo,
      dateOnSaleToGmt: dateOnSaleToGmt ?? this.dateOnSaleToGmt,
      type: type ?? this.type,
      status: status ?? this.status,
      featured: featured ?? this.featured,
      catalogVisibility: catalogVisibility ?? this.catalogVisibility,
      description: description ?? this.description,
      shortDescription: shortDescription ?? this.shortDescription,
      sku: sku ?? this.sku,
      price: price ?? this.price,
      regularPrice: regularPrice ?? this.regularPrice,
      salePrice: salePrice ?? this.salePrice,
      priceHtml: priceHtml ?? this.priceHtml,
      onSale: onSale ?? this.onSale,
      purchasable: purchasable ?? this.purchasable,
      totalSales: totalSales ?? this.totalSales,
      virtual: virtual ?? this.virtual,
      downloadable: downloadable ?? this.downloadable,
      downloads: downloads ?? this.downloads,
      downloadLimit: downloadLimit ?? this.downloadLimit,
      downloadExpiry: downloadExpiry ?? this.downloadExpiry,
      externalUrl: externalUrl ?? this.externalUrl,
      buttonText: buttonText ?? this.buttonText,
      taxStatus: taxStatus ?? this.taxStatus,
      taxClass: taxClass ?? this.taxClass,
      manageStock: manageStock ?? this.manageStock,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      stockStatus: stockStatus ?? this.stockStatus,
      backorders: backorders ?? this.backorders,
      backordersAllowed: backordersAllowed ?? this.backordersAllowed,
      backordered: backordered ?? this.backordered,
      soldIndividually: soldIndividually ?? this.soldIndividually,
      weight: weight ?? this.weight,
      dimensions: dimensions ?? this.dimensions,
      shippingRequired: shippingRequired ?? this.shippingRequired,
      shippingTaxable: shippingTaxable ?? this.shippingTaxable,
      shippingClass: shippingClass ?? this.shippingClass,
      shippingClassId: shippingClassId ?? this.shippingClassId,
      reviewsAllowed: reviewsAllowed ?? this.reviewsAllowed,
      averageRating: averageRating ?? this.averageRating,
      ratingCount: ratingCount ?? this.ratingCount,
      relatedIds: relatedIds ?? this.relatedIds,
      upsellIds: upsellIds ?? this.upsellIds,
      crossSellIds: crossSellIds ?? this.crossSellIds,
      parentId: parentId ?? this.parentId,
      purchaseNote: purchaseNote ?? this.purchaseNote,
      categories: categories ?? this.categories,
      tags: tags ?? this.tags,
      images: images ?? this.images,
      attributes: attributes ?? this.attributes,
      defaultAttributes: defaultAttributes ?? this.defaultAttributes,
      variations: variations ?? this.variations,
      groupedProducts: groupedProducts ?? this.groupedProducts,
      menuOrder: menuOrder ?? this.menuOrder,
      metaData: metaData ?? this.metaData,
    );
  }

  factory WooProduct.fake() => WooProduct(
        id: FakeHelper.integer(),
        name: FakeHelper.word(),
        slug: FakeHelper.word(),
        permalink: FakeHelper.url(),
        type: WooProductType.fake(),
        status: WooProductStatus.fake(),
        featured: FakeHelper.boolean(),
        catalogVisibility: WooProductCatalogVisibility.fake(),
        description: FakeHelper.sentence(),
        shortDescription: FakeHelper.sentence(),
        sku: FakeHelper.word(),
        price: FakeHelper.decimal(),
        regularPrice: FakeHelper.decimal(),
        salePrice: FakeHelper.decimal(),
        priceHtml: FakeHelper.sentence(),
        onSale: FakeHelper.boolean(),
        purchasable: FakeHelper.boolean(),
        totalSales: FakeHelper.integer(),
        virtual: FakeHelper.boolean(),
        downloadable: FakeHelper.boolean(),
        downloads: FakeHelper.list(() => WooProductDownload.fake()),
        downloadLimit: FakeHelper.integer(),
        downloadExpiry: FakeHelper.integer(),
        externalUrl: FakeHelper.url(),
        buttonText: FakeHelper.word(),
        taxStatus: WooProductTaxStatus.fake(),
        taxClass: FakeHelper.word(),
        manageStock: FakeHelper.boolean(),
        stockQuantity: FakeHelper.integer(),
        stockStatus: WooProductStockStatus.fake(),
        backorders: WooProductBackorder.fake(),
        backordersAllowed: FakeHelper.boolean(),
        backordered: FakeHelper.boolean(),
        soldIndividually: FakeHelper.boolean(),
        weight: FakeHelper.decimal().toString(),
        dimensions: WooProductDimension.fake(),
        shippingRequired: FakeHelper.boolean(),
        shippingTaxable: FakeHelper.boolean(),
        shippingClass: FakeHelper.word(),
        shippingClassId: FakeHelper.integer(),
        reviewsAllowed: FakeHelper.boolean(),
        averageRating: FakeHelper.word(),
        ratingCount: FakeHelper.integer(),
        relatedIds: FakeHelper.listOfIntegers(),
        upsellIds: FakeHelper.listOfIntegers(),
        crossSellIds: FakeHelper.listOfIntegers(),
        parentId: FakeHelper.integer(),
        purchaseNote: FakeHelper.word(),
        categories: FakeHelper.list(() => WooProductCategory.fake()),
        tags: FakeHelper.list(() => WooProductTag.fake()),
        images: FakeHelper.list(() => WooProductImage.fake()),
        attributes: FakeHelper.list(() => WooProductItemAttribute.fake()),
        defaultAttributes:
            FakeHelper.list(() => WooProductDefaultAttribute.fake()),
        variations: FakeHelper.listOfIntegers(),
        groupedProducts: FakeHelper.listOfIntegers(),
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (id != null) map['id'] = id;
    if (name != null) map['name'] = name;
    if (slug != null) map['slug'] = slug;
    if (permalink != null) map['permalink'] = permalink;
    if (dateCreated != null) {
      map['date_created'] = dateCreated!.toIso8601String();
    }
    if (dateCreatedGmt != null) {
      map['date_created_gmt'] = dateCreatedGmt!.toIso8601String();
    }
    if (dateModified != null) {
      map['date_modified'] = dateModified!.toIso8601String();
    }
    if (dateModifiedGmt != null) {
      map['date_modified_gmt'] = dateModifiedGmt!.toIso8601String();
    }
    if (dateOnSaleFrom != null) {
      map['date_on_sale_from'] = dateOnSaleFrom!.toIso8601String();
    }
    if (dateOnSaleFromGmt != null) {
      map['date_on_sale_from_gmt'] = dateOnSaleFromGmt!.toIso8601String();
    }
    if (dateOnSaleTo != null) {
      map['date_on_sale_to'] = dateOnSaleTo!.toIso8601String();
    }
    if (dateOnSaleToGmt != null) {
      map['date_on_sale_to_gmt'] = dateOnSaleToGmt!.toIso8601String();
    }
    if (type != null) map['type'] = type!.name;
    if (status != null) map['status'] = status!.name;
    if (featured != null) map['featured'] = featured;
    if (catalogVisibility != null) {
      map['catalog_visibility'] = catalogVisibility!.name;
    }
    if (description != null) map['description'] = description;
    if (shortDescription != null) map['short_description'] = shortDescription;
    if (sku != null) map['sku'] = sku;
    if (price != null) map['price'] = price!.toString();
    if (regularPrice != null) map['regular_price'] = regularPrice!.toString();
    if (salePrice != null) map['sale_price'] = salePrice!.toString();
    if (priceHtml != null) map['price_html'] = priceHtml;
    if (onSale != null) map['on_sale'] = onSale;
    if (purchasable != null) map['purchasable'] = purchasable;
    if (totalSales != null) map['total_sales'] = totalSales;
    if (virtual != null) map['virtual'] = virtual;
    if (downloadable != null) map['downloadable'] = downloadable;
    if (downloads.isNotEmpty) {
      map['downloads'] = downloads.map((e) => e.toJson()).toList();
    }
    if (downloadLimit != null) map['download_limit'] = downloadLimit;
    if (downloadExpiry != null) map['download_expiry'] = downloadExpiry;
    if (externalUrl != null) map['external_url'] = externalUrl;
    if (buttonText != null) map['button_text'] = buttonText;
    if (taxStatus != null) map['tax_status'] = taxStatus!.name;
    if (taxClass != null) map['tax_class'] = taxClass;
    if (manageStock != null) map['manage_stock'] = manageStock;
    if (stockQuantity != null) map['stock_quantity'] = stockQuantity;
    if (stockStatus != null) map['stock_status'] = stockStatus!.name;
    if (backorders != null) map['backorders'] = backorders!.name;
    if (backordersAllowed != null) {
      map['backorders_allowed'] = backordersAllowed;
    }
    if (backordered != null) map['backordered'] = backordered;
    if (soldIndividually != null) map['sold_individually'] = soldIndividually;
    if (weight != null) map['weight'] = weight;
    if (dimensions != null) map['dimensions'] = dimensions!.toJson();
    if (shippingRequired != null) map['shipping_required'] = shippingRequired;
    if (shippingTaxable != null) map['shipping_taxable'] = shippingTaxable;
    if (shippingClass != null) map['shipping_class'] = shippingClass;
    if (shippingClassId != null) map['shipping_class_id'] = shippingClassId;
    if (reviewsAllowed != null) map['reviews_allowed'] = reviewsAllowed;
    if (averageRating != null) map['average_rating'] = averageRating;
    if (ratingCount != null) map['rating_count'] = ratingCount;
    if (relatedIds != null) map['related_ids'] = relatedIds;
    if (upsellIds != null) map['upsell_ids'] = upsellIds;
    if (crossSellIds != null) map['cross_sell_ids'] = crossSellIds;
    if (parentId != null) map['parent_id'] = parentId;
    if (purchaseNote != null) map['purchase_note'] = purchaseNote;
    if (categories.isNotEmpty) {
      map['categories'] = categories.map((e) => e.toJson()).toList();
    }
    if (tags.isNotEmpty) map['tags'] = tags.map((e) => e.toJson()).toList();
    if (images.isNotEmpty) {
      map['images'] = images.map((e) => e.toJson()).toList();
    }
    if (attributes.isNotEmpty) {
      map['attributes'] = attributes.map((e) => e.toJson()).toList();
    }
    if (defaultAttributes.isNotEmpty) {
      map['default_attributes'] =
          defaultAttributes.map((e) => e.toJson()).toList();
    }
    if (variations != null) map['variations'] = variations;
    if (groupedProducts != null) map['grouped_products'] = groupedProducts;
    if (menuOrder != null) map['menu_order'] = menuOrder;
    if (metaData.isNotEmpty) {
      map['meta_data'] = metaData.map((e) => e.toJson()).toList();
    }

    return map;
  }
}
