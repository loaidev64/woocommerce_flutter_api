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
        dateCreated = DateTime.parse(json['date_created']),
        dateCreatedGmt = DateTime.parse(json['date_modified_gmt']),
        dateModified = DateTime.parse(json['date_modified']),
        dateModifiedGmt = DateTime.parse(json['date_created_gmt']),
        dateOnSaleFrom = DateTime.parse(json['date_on_sale_from']),
        dateOnSaleFromGmt = DateTime.parse(json['date_on_sale_from_gmt']),
        dateOnSaleTo = DateTime.parse(json['date_on_sale_to']),
        dateOnSaleToGmt = DateTime.parse(json['date_on_sale_to_gmt']),
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
