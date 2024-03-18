import 'dart:async';

import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'endpoints.dart';

extension WooProductApi on WooCommerce {
  /// [context] Scope under which the request is made; determines fields present in response. Options: view and edit. Default is view.
  ///
  /// [page] Current page of the collection. Default is 1.
  ///
  /// [perPage] Maximum number of items to be returned in result set. Default is 10.
  ///
  /// [search] Limit results to those matching a string.
  ///
  /// [after] Limit response to resources published after a given ISO8601 compliant date.
  ///
  /// [before] Limit response to resources published before a given ISO8601 compliant date.
  ///
  /// [modifiedAfter] Limit response to resources modified after a given ISO8601 compliant date.
  ///
  /// [modifiedBefore] Limit response to resources modified after a given ISO8601 compliant date.
  ///
  /// [datesAreGmt] Whether to consider GMT post dates when limiting response by published or modified date.
  ///
  /// [exclude] Ensure result set excludes specific IDs.
  ///
  /// [include] Limit result set to specific ids.
  ///
  /// [offset] Offset the result set by a specific number of items.
  ///
  /// [order] Order sort attribute ascending or descending. Options: asc and desc. Default is desc.
  ///
  /// [orderBy] Sort collection by object attribute. Options: date, id, include, title, slug, price, popularity and rating. Default is date.
  ///
  /// [parent] Limit result set to those of particular parent IDs.
  ///
  /// [parentExclude] Limit result set to all items except those of a particular parent ID.
  ///
  /// [slug] Limit result set to products with a specific slug.
  ///
  /// [status] Limit result set to products assigned a specific status. Options: any, draft, pending, private and publish. Default is any.
  ///
  /// [type] Limit result set to products assigned a specific type. Options: simple, grouped, external and variable.
  ///
  /// [sku] Limit result set to products with a specific SKU.
  ///
  /// [featured] Limit result set to featured products.
  ///
  /// [category] Limit result set to products assigned a specific category ID.
  ///
  /// [tag] Limit result set to products assigned a specific tag ID.
  ///
  /// [shippingClass] Limit result set to products assigned a specific shipping class ID.
  ///
  /// [attribute] Limit result set to products with a specific attribute.
  ///
  /// [attributeTerm] Limit result set to products with a specific attribute term ID (required an assigned attribute).
  ///
  /// [taxClass] Limit result set to products with a specific tax class. Default options: standard, reduced-rate and zero-rate.
  ///
  /// [onSale] Limit result set to products on sale.
  ///
  /// [minPrice] Limit result set to products based on a minimum price.
  ///
  /// [maxPrice] Limit result set to products based on a maximum price.
  ///
  /// [stockStatus] Limit result set to products with specified stock status. Options: instock, outofstock and onbackorder.
  ///
  /// [useFaker], fakes the api request
  Future<List<WooProduct>> getProducts({
    WooContext context = WooContext.view,
    int page = 1,
    int perPage = 10,
    String? search,
    DateTime? after,
    DateTime? before,
    DateTime? modifiedAfter,
    DateTime? modifiedBefore,
    bool? datesAreGmt,
    List<int>? exclude,
    List<int>? include,
    int? offset,
    WooSortOrder order = WooSortOrder.desc,
    WooSortOrderBy orderBy = WooSortOrderBy.date,
    List<int>? parent,
    List<int>? parentExclude,
    String? slug,
    WooFilterStatus status = WooFilterStatus.any,
    WooProductType? type,
    String? sku,
    bool? featured,
    int? category,
    int? tag,
    int? shippingClass,
    String? attribute,
    String? attributeTerm,
    String? taxClass,
    bool? onSale,
    double? minPrice,
    double? maxPrice,
    WooProductStockStatus? stockStatus,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return List.generate(perPage, (index) => WooProduct.fake());
    }

    final response = await dio.get(
      _Endpoints.products,
      queryParameters: _resolveQueryParametersForGettingProducts(
        context: context,
        page: page,
        perPage: perPage,
        search: search,
        after: after,
        before: before,
        modifiedAfter: modifiedAfter,
        modifiedBefore: modifiedBefore,
        datesAreGmt: datesAreGmt,
        exclude: exclude,
        include: include,
        offset: offset,
        order: order,
        orderBy: orderBy,
        parent: parent,
        parentExclude: parentExclude,
        slug: slug,
        status: status,
        type: type,
        sku: sku,
        featured: featured,
        category: category,
        tag: tag,
        shippingClass: shippingClass,
        attribute: attribute,
        attributeTerm: attributeTerm,
        taxClass: taxClass,
        onSale: onSale,
        minPrice: minPrice,
        maxPrice: maxPrice,
        stockStatus: stockStatus,
      ),
    );

    return (response.data as List)
        .map((item) => WooProduct.fromJson(item))
        .toList();
  }

  Map<String, dynamic> _resolveQueryParametersForGettingProducts({
    required WooContext context,
    required int page,
    required int perPage,
    required String? search,
    required DateTime? after,
    required DateTime? before,
    required DateTime? modifiedAfter,
    required DateTime? modifiedBefore,
    required bool? datesAreGmt,
    required List<int>? exclude,
    required List<int>? include,
    required int? offset,
    required WooSortOrder order,
    required WooSortOrderBy orderBy,
    required List<int>? parent,
    required List<int>? parentExclude,
    required String? slug,
    required WooFilterStatus status,
    required WooProductType? type,
    required String? sku,
    required bool? featured,
    required int? category,
    required int? tag,
    required int? shippingClass,
    required String? attribute,
    required String? attributeTerm,
    required String? taxClass,
    required bool? onSale,
    required double? minPrice,
    required double? maxPrice,
    required WooProductStockStatus? stockStatus,
  }) {
    final map = <String, dynamic>{
      'context': context.name,
      'page': page,
      'per_page': perPage,
      'order': order.name,
      'orderby': orderBy.name,
      'status': status.name,
    };

    if (search != null) {
      map['search'] = search;
    }

    if (after != null) {
      map['after'] = after.toIso8601String();
    }

    if (before != null) {
      map['before'] = before.toIso8601String();
    }

    if (modifiedAfter != null) {
      map['modified_after'] = modifiedAfter.toIso8601String();
    }

    if (modifiedBefore != null) {
      map['modified_before'] = modifiedBefore.toIso8601String();
    }

    if (datesAreGmt != null) {
      map['dates_are_gmt'] = datesAreGmt;
    }

    if (exclude != null) {
      map['exclude'] = exclude.join(',');
    }

    if (include != null) {
      map['include'] = include.join(',');
    }

    if (offset != null) {
      map['offset'] = offset;
    }

    if (parent != null) {
      map['parent'] = parent.join(',');
    }

    if (parentExclude != null) {
      map['parent_exclude'] = parentExclude.join(',');
    }

    if (slug != null) {
      map['slug'] = slug;
    }

    if (type != null) {
      map['type'] = type.name;
    }

    if (sku != null) {
      map['sku'] = sku;
    }

    if (featured != null) {
      map['featured'] = featured;
    }

    if (category != null) {
      map['category'] = category;
    }

    if (tag != null) {
      map['tag'] = tag;
    }

    if (shippingClass != null) {
      map['shipping_class'] = shippingClass;
    }

    if (attribute != null) {
      map['attribute'] = attribute;
    }

    if (attributeTerm != null) {
      map['attribute_term'] = attributeTerm;
    }

    if (taxClass != null) {
      map['tax_class'] = taxClass;
    }

    if (onSale != null) {
      map['on_sale'] = onSale;
    }

    if (minPrice != null) {
      map['min_price'] = minPrice;
    }

    if (maxPrice != null) {
      map['max_price'] = maxPrice;
    }

    if (stockStatus != null) {
      map['stock_status'] = stockStatus.name;
    }

    return map;
  }

  Future<WooProduct> getProduct(int id, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooProduct.fake();
    }

    final response = await dio.get(_Endpoints.singleProduct(id));

    return WooProduct.fromJson(response.data as Map<String, dynamic>);
  }
}
