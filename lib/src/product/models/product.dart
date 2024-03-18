import 'package:faker/faker.dart';
import 'package:woocommerce_flutter_api/src/category/models/category.dart';
import 'package:woocommerce_flutter_api/src/product/enums/product_backorder.dart';
import 'package:woocommerce_flutter_api/src/product/enums/product_catalog_visibility.dart';
import 'package:woocommerce_flutter_api/src/product/enums/product_stock_status.dart';
import 'package:woocommerce_flutter_api/src/product/enums/product_tax_status.dart';

import '../enums/product_status.dart';
import '../enums/product_type.dart';
import 'metadata.dart';
import 'product_dimension.dart';
import 'product_download.dart';
import 'product_image.dart';
import 'product_item_attribute.dart';
import 'product_item_tag.dart';

class WooProduct {
  /// Unique identifier for the resource.
  final int? id;

  /// Product name.
  final String? name;

  /// Product slug.
  final String? slug;

  ///  	Product URL.
  final String? permalink;

  //TODO:: add the dates

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

  //TODO:: add the on sale dates

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
  final List<WooProductItemTag> tags;

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
            .map((i) => WooProductItemTag.fromJson(i))
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
        id: Faker().randomGenerator.integer(100),
        name: Faker().lorem.word(),
        slug: Faker().lorem.word(),
        permalink: Faker().internet.httpsUrl(),
        type: WooProductType.fake(),
        status: WooProductStatus.fake(),
        featured: Faker().randomGenerator.boolean(),
        catalogVisibility: WooProductCatalogVisibility.fake(),
        description: Faker().lorem.sentence(),
        shortDescription: Faker().lorem.sentence(),
        sku: Faker().lorem.word(),
        price: Faker().randomGenerator.decimal(),
        regularPrice: Faker().randomGenerator.decimal(),
        salePrice: Faker().randomGenerator.decimal(),
        priceHtml: Faker().lorem.sentence(),
        onSale: Faker().randomGenerator.boolean(),
        purchasable: Faker().randomGenerator.boolean(),
        totalSales: Faker().randomGenerator.integer(100),
        virtual: Faker().randomGenerator.boolean(),
        downloadable: Faker().randomGenerator.boolean(),
        downloads: List.generate(Faker().randomGenerator.integer(10),
            (index) => WooProductDownload.fake()),
        downloadLimit: Faker().randomGenerator.integer(100),
        downloadExpiry: Faker().randomGenerator.integer(100),
        externalUrl: Faker().internet.httpsUrl(),
        buttonText: Faker().lorem.word(),
        taxStatus: WooProductTaxStatus.fake(),
        taxClass: Faker().lorem.word(),
        manageStock: Faker().randomGenerator.boolean(),
        stockQuantity: Faker().randomGenerator.integer(100),
        stockStatus: WooProductStockStatus.fake(),
        backorders: WooProductBackorder.fake(),
        backordersAllowed: Faker().randomGenerator.boolean(),
        backordered: Faker().randomGenerator.boolean(),
        soldIndividually: Faker().randomGenerator.boolean(),
        weight: Faker().randomGenerator.decimal().toString(),
        dimensions: WooProductDimension.fake(),
        shippingRequired: Faker().randomGenerator.boolean(),
        shippingTaxable: Faker().randomGenerator.boolean(),
        shippingClass: Faker().lorem.word(),
        shippingClassId: Faker().randomGenerator.integer(100),
        reviewsAllowed: Faker().randomGenerator.boolean(),
        averageRating: Faker().lorem.word(),
        ratingCount: Faker().randomGenerator.integer(100),
        relatedIds: Faker().randomGenerator.numbers(100, 20),
        upsellIds: Faker().randomGenerator.numbers(100, 20),
        crossSellIds: Faker().randomGenerator.numbers(100, 20),
        parentId: Faker().randomGenerator.integer(100),
        purchaseNote: Faker().lorem.word(),
        categories: List.generate(Faker().randomGenerator.integer(100),
            (index) => WooProductCategory.fake()),
        tags: List.generate(Faker().randomGenerator.integer(100),
            (index) => WooProductItemTag.fake()),
        images: List.generate(Faker().randomGenerator.integer(100),
            (index) => WooProductImage.fake()),
        attributes: List.generate(Faker().randomGenerator.integer(100),
            (index) => WooProductItemAttribute.fake()),
        defaultAttributes: List.generate(Faker().randomGenerator.integer(100),
            (index) => WooProductDefaultAttribute.fake()),
        variations: Faker().randomGenerator.numbers(100, 20),
        groupedProducts: Faker().randomGenerator.numbers(100, 20),
        menuOrder: Faker().randomGenerator.integer(100),
        metaData: List.generate(Faker().randomGenerator.integer(100),
            (index) => WooMetaData.fake()),
      );
}
