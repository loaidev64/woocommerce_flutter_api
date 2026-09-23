import '../../base/models/metadata.dart';
import '../../category/models/category.dart';
import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';
import '../enums/product_backorder.dart';
import '../enums/product_catalog_visibility.dart';
import '../enums/product_status.dart';
import '../enums/product_stock_status.dart';
import '../enums/product_tax_status.dart';
import '../enums/product_type.dart';
import 'product_dimension.dart';
import 'product_download.dart';
import 'product_image.dart';
import 'product_item_attribute.dart';
import 'product_tag.dart';

class WooProduct {
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
    this.downloads,
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
    this.categories,
    this.tags,
    this.images,
    this.attributes,
    this.defaultAttributes,
    this.variations,
    this.groupedProducts,
    this.menuOrder,
    this.metaData,
  });
  factory WooProduct.fromJson(Map<String, dynamic> json) {
    final dimensionsJson = WooJson.readMap(json, 'dimensions');
    return WooProduct(
      id: WooJson.readInt(json, 'id'),
      name: WooJson.readString(json, 'name'),
      slug: WooJson.readString(json, 'slug'),
      permalink: WooJson.readString(json, 'permalink'),
      type: WooJson.readEnum(json, 'type', WooProductType.values),
      status: WooJson.readEnum(json, 'status', WooProductStatus.values),
      featured: WooJson.readBool(json, 'featured'),
      catalogVisibility: WooJson.readEnum(
        json,
        'catalog_visibility',
        WooProductCatalogVisibility.values,
      ),
      dateCreated: WooJson.readDate(json, 'date_created'),
      dateCreatedGmt: WooJson.readDate(json, 'date_created_gmt'),
      dateModified: WooJson.readDate(json, 'date_modified'),
      dateModifiedGmt: WooJson.readDate(json, 'date_modified_gmt'),
      dateOnSaleFrom: WooJson.readDate(json, 'date_on_sale_from'),
      dateOnSaleFromGmt: WooJson.readDate(json, 'date_on_sale_from_gmt'),
      dateOnSaleTo: WooJson.readDate(json, 'date_on_sale_to'),
      dateOnSaleToGmt: WooJson.readDate(json, 'date_on_sale_to_gmt'),
      description: WooJson.readString(json, 'description'),
      shortDescription: WooJson.readString(json, 'short_description'),
      sku: WooJson.readString(json, 'sku'),
      price: WooJson.readDouble(json, 'price'),
      regularPrice: WooJson.readDouble(json, 'regular_price'),
      salePrice: WooJson.readDouble(json, 'sale_price'),
      priceHtml: WooJson.readString(json, 'price_html'),
      onSale: WooJson.readBool(json, 'on_sale'),
      purchasable: WooJson.readBool(json, 'purchasable'),
      totalSales: WooJson.readInt(json, 'total_sales'),
      virtual: WooJson.readBool(json, 'virtual'),
      downloadable: WooJson.readBool(json, 'downloadable'),
      downloads:
          WooJson.readList(json, 'downloads', WooProductDownload.fromJson),
      downloadLimit: WooJson.readInt(json, 'download_limit'),
      downloadExpiry: WooJson.readInt(json, 'download_expiry'),
      externalUrl: WooJson.readString(json, 'external_url'),
      buttonText: WooJson.readString(json, 'button_text'),
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
      soldIndividually: WooJson.readBool(json, 'sold_individually'),
      weight: WooJson.readString(json, 'weight'),
      dimensions: dimensionsJson == null
          ? null
          : WooProductDimension.fromJson(dimensionsJson),
      shippingRequired: WooJson.readBool(json, 'shipping_required'),
      shippingTaxable: WooJson.readBool(json, 'shipping_taxable'),
      shippingClass: WooJson.readString(json, 'shipping_class'),
      shippingClassId: WooJson.readInt(json, 'shipping_class_id'),
      reviewsAllowed: WooJson.readBool(json, 'reviews_allowed'),
      averageRating: WooJson.readDouble(json, 'average_rating'),
      ratingCount: WooJson.readInt(json, 'rating_count'),
      relatedIds: WooJson.readIntList(json, 'related_ids'),
      upsellIds: WooJson.readIntList(json, 'upsell_ids'),
      crossSellIds: WooJson.readIntList(json, 'cross_sell_ids'),
      parentId: WooJson.readInt(json, 'parent_id'),
      purchaseNote: WooJson.readString(json, 'purchase_note'),
      categories:
          WooJson.readList(json, 'categories', WooProductCategory.fromJson),
      tags: WooJson.readList(json, 'tags', WooProductTag.fromJson),
      images: WooJson.readList(json, 'images', WooProductImage.fromJson),
      attributes: WooJson.readList(
          json, 'attributes', WooProductItemAttribute.fromJson),
      defaultAttributes: WooJson.readList(
        json,
        'default_attributes',
        WooProductDefaultAttribute.fromJson,
      ),
      variations: WooJson.readIntList(json, 'variations'),
      groupedProducts: WooJson.readIntList(json, 'grouped_products'),
      menuOrder: WooJson.readInt(json, 'menu_order'),
      metaData: WooJson.readList(json, 'meta_data', WooMetaData.fromJson),
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
        averageRating: FakeHelper.decimal(),
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
  final int? id;
  final String? name;
  final String? slug;
  final String? permalink;
  final WooProductType? type;
  final WooProductStatus? status;
  final bool? featured;
  final WooProductCatalogVisibility? catalogVisibility;
  final DateTime? dateCreated;
  final DateTime? dateCreatedGmt;
  final DateTime? dateModified;
  final DateTime? dateModifiedGmt;
  final DateTime? dateOnSaleFrom;
  final DateTime? dateOnSaleFromGmt;
  final DateTime? dateOnSaleTo;
  final DateTime? dateOnSaleToGmt;
  final String? description;
  final String? shortDescription;
  final String? sku;
  final double? price;
  final double? regularPrice;
  final double? salePrice;
  final String? priceHtml;
  final bool? onSale;
  final bool? purchasable;
  final int? totalSales;
  final bool? virtual;
  final bool? downloadable;
  final List<WooProductDownload>? downloads;
  final int? downloadLimit;
  final int? downloadExpiry;
  final String? externalUrl;
  final String? buttonText;
  final WooProductTaxStatus? taxStatus;
  final String? taxClass;
  final bool? manageStock;
  final int? stockQuantity;
  final WooProductStockStatus? stockStatus;
  final WooProductBackorder? backorders;
  final bool? backordersAllowed;
  final bool? backordered;
  final bool? soldIndividually;
  final String? weight;
  final WooProductDimension? dimensions;
  final bool? shippingRequired;
  final bool? shippingTaxable;
  final String? shippingClass;
  final int? shippingClassId;
  final bool? reviewsAllowed;
  final double? averageRating;
  final int? ratingCount;
  final List<int>? relatedIds;
  final List<int>? upsellIds;
  final List<int>? crossSellIds;
  final int? parentId;
  final String? purchaseNote;
  final List<WooProductCategory>? categories;
  final List<WooProductTag>? tags;
  final List<WooProductImage>? images;
  final List<WooProductItemAttribute>? attributes;
  final List<WooProductDefaultAttribute>? defaultAttributes;
  final List<int>? variations;
  final List<int>? groupedProducts;
  final int? menuOrder;
  final List<WooMetaData>? metaData;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putIfPresent('name', name)
    ..putIfPresent('slug', slug)
    ..putIfPresent('permalink', permalink)
    ..putEnum('type', type)
    ..putEnum('status', status)
    ..putIfPresent('featured', featured)
    ..putEnum('catalog_visibility', catalogVisibility)
    ..putDate('date_created', dateCreated)
    ..putDate('date_created_gmt', dateCreatedGmt)
    ..putDate('date_modified', dateModified)
    ..putDate('date_modified_gmt', dateModifiedGmt)
    ..putDate('date_on_sale_from', dateOnSaleFrom)
    ..putDate('date_on_sale_from_gmt', dateOnSaleFromGmt)
    ..putDate('date_on_sale_to', dateOnSaleTo)
    ..putDate('date_on_sale_to_gmt', dateOnSaleToGmt)
    ..putIfPresent('description', description)
    ..putIfPresent('short_description', shortDescription)
    ..putIfPresent('sku', sku)
    ..putIfPresent('price', price)
    ..putIfPresent('regular_price', regularPrice)
    ..putIfPresent('sale_price', salePrice)
    ..putIfPresent('price_html', priceHtml)
    ..putIfPresent('on_sale', onSale)
    ..putIfPresent('purchasable', purchasable)
    ..putIfPresent('total_sales', totalSales)
    ..putIfPresent('virtual', virtual)
    ..putIfPresent('downloadable', downloadable)
    ..putIfPresent('downloads', downloads?.map((e) => e.toJson()).toList())
    ..putIfPresent('download_limit', downloadLimit)
    ..putIfPresent('download_expiry', downloadExpiry)
    ..putIfPresent('external_url', externalUrl)
    ..putIfPresent('button_text', buttonText)
    ..putEnum('tax_status', taxStatus)
    ..putIfPresent('tax_class', taxClass)
    ..putIfPresent('manage_stock', manageStock)
    ..putIfPresent('stock_quantity', stockQuantity)
    ..putEnum('stock_status', stockStatus)
    ..putEnum('backorders', backorders)
    ..putIfPresent('backorders_allowed', backordersAllowed)
    ..putIfPresent('backordered', backordered)
    ..putIfPresent('sold_individually', soldIndividually)
    ..putIfPresent('weight', weight)
    ..putIfPresent('dimensions', dimensions?.toJson())
    ..putIfPresent('shipping_required', shippingRequired)
    ..putIfPresent('shipping_taxable', shippingTaxable)
    ..putIfPresent('shipping_class', shippingClass)
    ..putIfPresent('shipping_class_id', shippingClassId)
    ..putIfPresent('reviews_allowed', reviewsAllowed)
    ..putIfPresent('average_rating', averageRating)
    ..putIfPresent('rating_count', ratingCount)
    ..putIfPresent('related_ids', relatedIds)
    ..putIfPresent('upsell_ids', upsellIds)
    ..putIfPresent('cross_sell_ids', crossSellIds)
    ..putIfPresent('parent_id', parentId)
    ..putIfPresent('purchase_note', purchaseNote)
    ..putIfPresent('categories', categories?.map((c) => c.toJson()).toList())
    ..putIfPresent('tags', tags?.map((e) => e.toJson()).toList())
    ..putIfPresent('images', images?.map((e) => e.toJson()).toList())
    ..putIfPresent('attributes', attributes?.map((e) => e.toJson()).toList())
    ..putIfPresent('default_attributes',
        defaultAttributes?.map((e) => e.toJson()).toList())
    ..putIfPresent('variations', variations)
    ..putIfPresent('grouped_products', groupedProducts)
    ..putIfPresent('menu_order', menuOrder)
    ..putIfPresent('meta_data', metaData?.map((e) => e.toJson()).toList());
  WooProduct copyWith({
    int? id,
    String? name,
    String? slug,
    String? permalink,
    WooProductType? type,
    WooProductStatus? status,
    bool? featured,
    WooProductCatalogVisibility? catalogVisibility,
    DateTime? dateCreated,
    DateTime? dateCreatedGmt,
    DateTime? dateModified,
    DateTime? dateModifiedGmt,
    DateTime? dateOnSaleFrom,
    DateTime? dateOnSaleFromGmt,
    DateTime? dateOnSaleTo,
    DateTime? dateOnSaleToGmt,
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
    double? averageRating,
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
  }) =>
      WooProduct(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        permalink: permalink ?? this.permalink,
        type: type ?? this.type,
        status: status ?? this.status,
        featured: featured ?? this.featured,
        catalogVisibility: catalogVisibility ?? this.catalogVisibility,
        dateCreated: dateCreated ?? this.dateCreated,
        dateCreatedGmt: dateCreatedGmt ?? this.dateCreatedGmt,
        dateModified: dateModified ?? this.dateModified,
        dateModifiedGmt: dateModifiedGmt ?? this.dateModifiedGmt,
        dateOnSaleFrom: dateOnSaleFrom ?? this.dateOnSaleFrom,
        dateOnSaleFromGmt: dateOnSaleFromGmt ?? this.dateOnSaleFromGmt,
        dateOnSaleTo: dateOnSaleTo ?? this.dateOnSaleTo,
        dateOnSaleToGmt: dateOnSaleToGmt ?? this.dateOnSaleToGmt,
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
  @override
  String toString() =>
      'WooProduct(id: $id, name: $name, price: $price, status: $status)';
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProduct &&
          other.id == id &&
          other.name == name &&
          other.slug == slug &&
          other.permalink == permalink &&
          other.type == type &&
          other.status == status &&
          other.featured == featured &&
          other.catalogVisibility == catalogVisibility &&
          other.dateCreated == dateCreated &&
          other.dateCreatedGmt == dateCreatedGmt &&
          other.dateModified == dateModified &&
          other.dateModifiedGmt == dateModifiedGmt &&
          other.dateOnSaleFrom == dateOnSaleFrom &&
          other.dateOnSaleFromGmt == dateOnSaleFromGmt &&
          other.dateOnSaleTo == dateOnSaleTo &&
          other.dateOnSaleToGmt == dateOnSaleToGmt &&
          other.description == description &&
          other.shortDescription == shortDescription &&
          other.sku == sku &&
          other.price == price &&
          other.regularPrice == regularPrice &&
          other.salePrice == salePrice &&
          other.priceHtml == priceHtml &&
          other.onSale == onSale &&
          other.purchasable == purchasable &&
          other.totalSales == totalSales &&
          other.virtual == virtual &&
          other.downloadable == downloadable &&
          WooJson.listEquals(other.downloads, downloads) &&
          other.downloadLimit == downloadLimit &&
          other.downloadExpiry == downloadExpiry &&
          other.externalUrl == externalUrl &&
          other.buttonText == buttonText &&
          other.taxStatus == taxStatus &&
          other.taxClass == taxClass &&
          other.manageStock == manageStock &&
          other.stockQuantity == stockQuantity &&
          other.stockStatus == stockStatus &&
          other.backorders == backorders &&
          other.backordersAllowed == backordersAllowed &&
          other.backordered == backordered &&
          other.soldIndividually == soldIndividually &&
          other.weight == weight &&
          other.dimensions == dimensions &&
          other.shippingRequired == shippingRequired &&
          other.shippingTaxable == shippingTaxable &&
          other.shippingClass == shippingClass &&
          other.shippingClassId == shippingClassId &&
          other.reviewsAllowed == reviewsAllowed &&
          other.averageRating == averageRating &&
          other.ratingCount == ratingCount &&
          WooJson.listEquals(other.relatedIds, relatedIds) &&
          WooJson.listEquals(other.upsellIds, upsellIds) &&
          WooJson.listEquals(other.crossSellIds, crossSellIds) &&
          other.parentId == parentId &&
          other.purchaseNote == purchaseNote &&
          WooJson.listEquals(other.categories, categories) &&
          WooJson.listEquals(other.tags, tags) &&
          WooJson.listEquals(other.images, images) &&
          WooJson.listEquals(other.attributes, attributes) &&
          WooJson.listEquals(other.defaultAttributes, defaultAttributes) &&
          WooJson.listEquals(other.variations, variations) &&
          WooJson.listEquals(other.groupedProducts, groupedProducts) &&
          other.menuOrder == menuOrder &&
          WooJson.listEquals(other.metaData, metaData);
  @override
  int get hashCode => Object.hashAll([
        id,
        name,
        slug,
        permalink,
        type,
        status,
        featured,
        catalogVisibility,
        dateCreated,
        dateCreatedGmt,
        dateModified,
        dateModifiedGmt,
        dateOnSaleFrom,
        dateOnSaleFromGmt,
        dateOnSaleTo,
        dateOnSaleToGmt,
        description,
        shortDescription,
        sku,
        price,
        regularPrice,
        salePrice,
        priceHtml,
        onSale,
        purchasable,
        totalSales,
        virtual,
        downloadable,
        ...(downloads ?? const []),
        downloadLimit,
        downloadExpiry,
        externalUrl,
        buttonText,
        taxStatus,
        taxClass,
        manageStock,
        stockQuantity,
        stockStatus,
        backorders,
        backordersAllowed,
        backordered,
        soldIndividually,
        weight,
        dimensions,
        shippingRequired,
        shippingTaxable,
        shippingClass,
        shippingClassId,
        reviewsAllowed,
        averageRating,
        ratingCount,
        ...(relatedIds ?? const []),
        ...(upsellIds ?? const []),
        ...(crossSellIds ?? const []),
        parentId,
        purchaseNote,
        ...(categories ?? const []),
        ...(tags ?? const []),
        ...(images ?? const []),
        ...(attributes ?? const []),
        ...(defaultAttributes ?? const []),
        ...(variations ?? const []),
        ...(groupedProducts ?? const []),
        menuOrder,
        ...(metaData ?? const []),
      ]);
}
