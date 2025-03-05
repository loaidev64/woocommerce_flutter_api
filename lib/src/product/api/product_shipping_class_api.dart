import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'product_shipping_class_endpoints.dart';

extension WooProductShippingClassApi on WooCommerce {
  /// [context] Scope under which the request is made; determines fields present in response. Options: view and edit. Default is view.
  ///
  /// [page] Current page of the collection. Default is 1.
  ///
  /// [perPage] Maximum number of items to be returned in result set. Default is 10.
  ///
  /// [search] Limit results to those matching a string.
  ///
  /// [exclude] Ensure result set excludes specific IDs.
  ///
  /// [include] Limit result set to specific IDs.
  ///
  /// [offset] Offset the result set by a specific number of items.
  ///
  /// [order] Order sort attribute ascending or descending. Options: asc and desc. Default is asc.
  ///
  /// [orderBy] Sort collection by resource attribute. Options: id, include, name, slug, term_group, description, and count. Default is name.
  ///
  /// [hideEmpty] Whether to hide resources not assigned to any products. Default is false.
  ///
  /// [product] Limit result set to resources assigned to a specific product.
  ///
  /// [slug] Limit result set to resources with a specific slug.
  ///
  /// [useFaker] If true, returns fake data instead of making an API request.
  Future<List<WooProductShippingClass>> getProductShippingClasses({
    WooContext context = WooContext.view,
    int page = 1,
    int perPage = 10,
    String? search,
    List<int>? exclude,
    List<int>? include,
    int? offset,
    WooSortOrder order = WooSortOrder.asc,
    WooSortProductTag orderBy = WooSortProductTag.name,
    bool hideEmpty = false,
    int? product,
    String? slug,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return List.generate(perPage, (index) => WooProductShippingClass.fake());
    }

    final response = await dio.get(
      _ProductShippingClassEndpoints.shippingClasses,
      queryParameters: _resolveQueryParametersForGettingProductTags(
        context: context,
        page: page,
        perPage: perPage,
        search: search,
        exclude: exclude,
        include: include,
        offset: offset,
        order: order,
        orderBy: orderBy,
        hideEmpty: hideEmpty,
        product: product,
        slug: slug,
      ),
    );

    return (response.data as List)
        .map((item) => WooProductShippingClass.fromJson(item))
        .toList();
  }

  Map<String, dynamic> _resolveQueryParametersForGettingProductTags({
    required WooContext context,
    required int page,
    required int perPage,
    required String? search,
    required List<int>? exclude,
    required List<int>? include,
    required int? offset,
    required WooSortOrder order,
    required WooSortProductTag orderBy,
    required bool hideEmpty,
    required int? product,
    required String? slug,
  }) {
    final map = {
      'context': context.name,
      'page': page,
      'per_page': perPage,
      'order': order.name,
      'orderby': orderBy.name,
      'hide_empty': hideEmpty,
    };

    if (search != null) {
      map['search'] = search;
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

    if (product != null) {
      map['product'] = product;
    }

    if (slug != null) {
      map['slug'] = slug;
    }

    return map;
  }

  Future<WooProductShippingClass> getProductShippingClass(int id,
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooProductShippingClass.fake();
    }

    final response = await dio.get(
      _ProductShippingClassEndpoints.singleShippingClass(id),
    );

    return WooProductShippingClass.fromJson(
        response.data as Map<String, dynamic>);
  }

  Future<WooProductShippingClass> createProductShippingClass(
      WooProductShippingClass shippingClass,
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return shippingClass;
    }

    final response = await dio.post(
      _ProductShippingClassEndpoints.shippingClasses,
      data: shippingClass.toJson(),
    );

    return WooProductShippingClass.fromJson(
        response.data as Map<String, dynamic>);
  }

  Future<WooProductShippingClass> updateProductShippingClass(
      WooProductShippingClass shippingClass,
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return shippingClass;
    }

    final response = await dio.put(
      _ProductShippingClassEndpoints.singleShippingClass(shippingClass.id!),
      data: shippingClass.toJson(),
    );

    return WooProductShippingClass.fromJson(
        response.data as Map<String, dynamic>);
  }

  Future<WooProductShippingClass> deleteProductShippingClass(
      int shippingClassId,
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooProductShippingClass.fake(shippingClassId);
    }

    final response = await dio.delete(
        _ProductShippingClassEndpoints.singleShippingClass(shippingClassId),
        queryParameters: {
          'force': true,
        });

    return WooProductShippingClass.fromJson(
        response.data as Map<String, dynamic>);
  }
}
