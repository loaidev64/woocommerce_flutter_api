import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'endpoints.dart';

extension WooCategoryApi on WooCommerce {
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
  /// [include] Limit result set to specific ids.
  ///
  /// [order] Order sort attribute ascending or descending. Options: asc and desc. Default is desc.
  ///
  /// [orderBy] Sort collection by resource attribute. Options: id, include, name, slug, term_group, description and count. Default is name.
  ///
  /// [hideEmpty] Whether to hide resources not assigned to any products. Default is false.
  ///
  /// [parent] Limit result set to resources assigned to a specific parent.
  ///
  /// [product] Limit result set to resources assigned to a specific product.
  ///
  /// [slug] Limit result set to products with a specific slug.
  ///
  /// [useFaker], fakes the api request
  Future<List<WooProductCategory>> getCategories({
    WooContext context = WooContext.view,
    int page = 1,
    int perPage = 10,
    String? search,
    List<int>? exclude,
    List<int>? include,
    WooSortOrder order = WooSortOrder.desc,
    WooCategoryOrderBy orderBy = WooCategoryOrderBy.name,
    bool? hideEmpty,
    int? parent,
    int? product,
    String? slug,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return List.generate(perPage, (index) => WooProductCategory.fake());
    }

    final response = await dio.get(
      _CategoryEndpoints.categories,
      queryParameters: _resolveQueryParametersForGettingCategories(
        context: context,
        page: page,
        perPage: perPage,
        search: search,
        exclude: exclude,
        include: include,
        order: order,
        orderBy: orderBy,
        hideEmpty: hideEmpty,
        parent: parent,
        product: product,
        slug: slug,
      ),
    );

    return (response.data as List)
        .map((item) => WooProductCategory.fromJson(item))
        .toList();
  }

  Map<String, dynamic> _resolveQueryParametersForGettingCategories({
    required WooContext context,
    required int page,
    required int perPage,
    required String? search,
    required List<int>? exclude,
    required List<int>? include,
    required WooSortOrder order,
    required WooCategoryOrderBy orderBy,
    required bool? hideEmpty,
    required int? parent,
    required int? product,
    required String? slug,
  }) {
    final map = <String, dynamic>{
      'context': context.name,
      'page': page,
      'per_page': perPage,
      'order': order.name,
      'orderby': orderBy.name,
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

    if (parent != null) {
      map['parent'] = parent;
    }

    if (slug != null) {
      map['slug'] = slug;
    }

    if (hideEmpty != null) {
      map['hide_empty'] = hideEmpty;
    }

    if (product != null) {
      map['product'] = product;
    }

    return map;
  }

  Future<WooProductCategory> getCategory(int id, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooProductCategory.fake();
    }

    final response = await dio.get(_CategoryEndpoints.singleCategory(id));

    return WooProductCategory.fromJson(response.data as Map<String, dynamic>);
  }

  Future<WooProductCategory> createCategory(
    WooProductCategory category, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooProductCategory.fake();
    }

    final response = await dio.post(
      _CategoryEndpoints.categories,
      data: category.toJson(),
    );

    return WooProductCategory.fromJson(response.data as Map<String, dynamic>);
  }

  Future<WooProductCategory> updateCategory(
    WooProductCategory category, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooProductCategory.fake();
    }

    final response = await dio.put(
      _CategoryEndpoints.singleCategory(category.id!),
      data: category.toJson(),
    );

    return WooProductCategory.fromJson(response.data as Map<String, dynamic>);
  }

  /// [force] Whether to permanently delete the category instead of moving to trash. Default is false.
  ///
  /// [useFaker] Fakes the api request for testing purposes.
  Future<bool> deleteCategory(
    int id, {
    bool force = false,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return true;
    }

    await dio.delete(
      _CategoryEndpoints.singleCategory(id),
      queryParameters: {
        'force': force,
      },
    );

    return true;
  }
}
