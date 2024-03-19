import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'endpoints.dart';

extension WooVariationApi on WooCommerce {
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
  /// [sku] Limit result set to products with a specific SKU.
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
  Future<List<WooProductVariation>> getProductVaritaions(
    int productId, {
    WooContext context = WooContext.view,
    int page = 1,
    int perPage = 10,
    String? search,
    DateTime? after,
    DateTime? before,
    List<int>? exclude,
    List<int>? include,
    int? offset,
    WooSortOrder order = WooSortOrder.desc,
    WooSortOrderBy orderBy = WooSortOrderBy.date,
    List<int>? parent,
    List<int>? parentExclude,
    String? slug,
    WooFilterStatus status = WooFilterStatus.any,
    String? sku,
    String? taxClass,
    bool? onSale,
    double? minPrice,
    double? maxPrice,
    WooProductStockStatus? stockStatus,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return List.generate(perPage, (index) => WooProductVariation.fake());
    }

    final response = await dio.get(
      _VariationEndpoints.variations(productId),
      queryParameters: _resolveQueryParametersForGettingProducts(
        context: context,
        page: page,
        perPage: perPage,
        search: search,
        after: after,
        before: before,
        exclude: exclude,
        include: include,
        offset: offset,
        order: order,
        orderBy: orderBy,
        parent: parent,
        parentExclude: parentExclude,
        slug: slug,
        status: status,
        sku: sku,
        taxClass: taxClass,
        onSale: onSale,
        minPrice: minPrice,
        maxPrice: maxPrice,
        stockStatus: stockStatus,
      ),
    );

    return (response.data as List)
        .map((item) => WooProductVariation.fromJson(item))
        .toList();
  }

  Map<String, dynamic> _resolveQueryParametersForGettingProducts({
    required WooContext context,
    required int page,
    required int perPage,
    required String? search,
    required DateTime? after,
    required DateTime? before,
    required List<int>? exclude,
    required List<int>? include,
    required int? offset,
    required WooSortOrder order,
    required WooSortOrderBy orderBy,
    required List<int>? parent,
    required List<int>? parentExclude,
    required String? slug,
    required WooFilterStatus status,
    required String? sku,
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
    if (sku != null) {
      map['sku'] = sku;
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

  Future<WooProductVariation> getProductVariation(int productId, int id,
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooProductVariation.fake();
    }

    final response =
        await dio.get(_VariationEndpoints.singleVariation(productId, id));

    return WooProductVariation.fromJson(response.data as Map<String, dynamic>);
  }
}
