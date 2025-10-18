import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'endpoints.dart';

/// WooCommerce Product Variation API Extension
///
/// This extension provides comprehensive product variation management capabilities for WooCommerce stores.
/// Product variations are different versions of a variable product, each with their own attributes,
/// pricing, inventory, and other properties.
///
/// ## Key Features
///
/// - **Variation Retrieval**: Get all variations for a product or a specific variation
/// - **Advanced Filtering**: Filter variations by price, stock status, SKU, and more
/// - **Pagination Support**: Handle large product catalogs with efficient pagination
/// - **Search Capabilities**: Find variations using search terms and filters
/// - **Fake Data Support**: Generate fake variation data for testing and development
///
/// ## Example Usage
///
/// ```dart
/// // Get all variations for a product
/// final variations = await wooCommerce.getProductVaritaions(productId: 123);
///
/// // Get a specific variation
/// final variation = await wooCommerce.getProductVariation(productId: 123, id: 456);
///
/// // Search variations with filters
/// final filteredVariations = await wooCommerce.getProductVaritaions(
///   productId: 123,
///   search: 'red',
///   stockStatus: WooProductStockStatus.instock,
///   minPrice: 10.0,
///   maxPrice: 100.0,
/// );
/// ```
extension WooVariationApi on WooCommerce {
  /// Retrieves a list of product variations from the WooCommerce store.
  ///
  /// This method supports extensive filtering and pagination options to help you
  /// find exactly the variations you need for a specific product.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-product-variations
  ///
  /// ## Parameters
  ///
  /// * [productId] - The ID of the parent product to get variations for
  /// * [context] - Scope under which the request is made; determines fields present in response.
  ///   - `WooContext.view`: Returns basic variation information (default)
  ///   - `WooContext.edit`: Returns full variation details including sensitive data
  /// * [page] - Current page of the collection (default: 1)
  /// * [perPage] - Maximum number of items to return (default: 10, max: 100)
  /// * [search] - Limit results to variations matching a search string
  /// * [after] - Limit response to variations published after a given ISO8601 compliant date
  /// * [before] - Limit response to variations published before a given ISO8601 compliant date
  /// * [exclude] - Ensure result set excludes specific variation IDs
  /// * [include] - Limit result set to specific variation IDs
  /// * [offset] - Offset the result set by a specific number of items
  /// * [order] - Order sort attribute ascending or descending (default: desc)
  /// * [orderBy] - Sort collection by object attribute (default: date)
  /// * [parent] - Limit result set to variations of particular parent IDs
  /// * [parentExclude] - Limit result set to all items except those of a particular parent ID
  /// * [slug] - Limit result set to variations with a specific slug
  /// * [status] - Limit result set to variations assigned a specific status (default: any)
  /// * [sku] - Limit result set to variations with a specific SKU
  /// * [taxClass] - Limit result set to variations with a specific tax class
  /// * [onSale] - Limit result set to variations on sale
  /// * [minPrice] - Limit result set to variations based on a minimum price
  /// * [maxPrice] - Limit result set to variations based on a maximum price
  /// * [stockStatus] - Limit result set to variations with specified stock status
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooProductVariation>>` containing the variation objects.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get all variations for a product
  /// final variations = await wooCommerce.getProductVaritaions(productId: 123);
  ///
  /// // Search for variations with filters
  /// final searchResults = await wooCommerce.getProductVaritaions(
  ///   productId: 123,
  ///   search: 'red',
  ///   stockStatus: WooProductStockStatus.instock,
  ///   perPage: 20,
  /// );
  ///
  /// // Get variations on sale
  /// final saleVariations = await wooCommerce.getProductVaritaions(
  ///   productId: 123,
  ///   onSale: true,
  ///   minPrice: 10.0,
  ///   maxPrice: 100.0,
  /// );
  /// ```
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

  /// Retrieves a specific product variation by ID.
  ///
  /// This method fetches detailed information about a single product variation,
  /// including all its attributes, pricing, inventory, and metadata.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#retrieve-a-product-variation
  ///
  /// ## Parameters
  ///
  /// * [productId] - The ID of the parent product
  /// * [id] - The ID of the specific variation to retrieve
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooProductVariation>` containing the variation object.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  /// * `WooCommerceException` if the variation or parent product is not found
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get a specific variation
  /// final variation = await wooCommerce.getProductVariation(
  ///   productId: 123,
  ///   id: 456,
  /// );
  ///
  /// // Check variation properties
  /// if (variation.onSale == true) {
  ///   print('Variation is on sale: ${variation.salePrice}');
  /// }
  /// ```
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
