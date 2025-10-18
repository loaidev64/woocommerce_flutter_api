import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'product_tag_endpoints.dart';

/// WooCommerce Product Tag API Extension
///
/// This extension provides comprehensive product tag management capabilities for WooCommerce stores.
/// It allows you to retrieve, create, update, and delete product tags, which are used to categorize
/// and organize products for better discoverability and filtering.
///
/// ## Key Features
///
/// - **Retrieve Product Tags**: Get all product tags with extensive filtering options
/// - **Get Single Product Tag**: Retrieve a specific product tag by ID
/// - **Create Product Tags**: Add new product tags for product categorization
/// - **Update Product Tags**: Modify existing product tag properties
/// - **Delete Product Tags**: Remove product tags (with force deletion)
///
/// ## Example Usage
///
/// ```dart
/// // Get all product tags
/// final tags = await wooCommerce.getProductTags();
///
/// // Create a new product tag
/// final tag = WooProductTag(
///   name: 'Electronics',
///   slug: 'electronics',
///   description: 'Electronic products and devices',
/// );
/// final created = await wooCommerce.createProductTag(tag);
/// ```
extension WooProductTagApi on WooCommerce {
  /// Retrieves a list of product tags from the WooCommerce store.
  ///
  /// This method supports extensive filtering and pagination options to help you
  /// find exactly the product tags you need.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-product-tags
  ///
  /// ## Parameters
  ///
  /// * [context] - Scope under which the request is made; determines fields present in response.
  ///   - `WooContext.view`: Returns basic tag information (default)
  ///   - `WooContext.edit`: Returns full tag details including sensitive data
  /// * [page] - Current page of the collection (default: 1)
  /// * [perPage] - Maximum number of items to return (default: 10, max: 100)
  /// * [search] - Limit results to tags matching a search string
  /// * [exclude] - Ensure result set excludes specific tag IDs
  /// * [include] - Limit result set to specific tag IDs
  /// * [offset] - Offset the result set by a specific number of items
  /// * [order] - Order sort attribute ascending or descending (default: asc)
  /// * [orderBy] - Sort collection by resource attribute (default: name)
  /// * [hideEmpty] - Whether to hide tags not assigned to any products (default: false)
  /// * [product] - Limit result set to tags assigned to a specific product
  /// * [slug] - Limit result set to tags with a specific slug
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooProductTag>>` containing the product tag objects.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get all product tags
  /// final tags = await wooCommerce.getProductTags();
  ///
  /// // Search for tags with pagination
  /// final searchResults = await wooCommerce.getProductTags(
  ///   search: 'electronics',
  ///   perPage: 20,
  ///   page: 1,
  /// );
  ///
  /// // Get tags for a specific product
  /// final productTags = await wooCommerce.getProductTags(
  ///   product: 123,
  /// );
  /// ```
  Future<List<WooProductTag>> getProductTags({
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
      return List.generate(perPage, (index) => WooProductTag.fake());
    }

    final response = await dio.get(
      _ProductTagEndpoints.tags,
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
        .map((item) => WooProductTag.fromJson(item))
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

  /// Retrieves a specific product tag by its ID.
  ///
  /// This method fetches a single product tag associated with the given ID.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#retrieve-a-product-tag
  ///
  /// ## Parameters
  ///
  /// * [id] - The ID of the product tag to retrieve
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooProductTag>` containing the product tag object.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get a specific product tag
  /// final tag = await wooCommerce.getProductTag(123);
  /// ```
  Future<WooProductTag> getProductTag(int id, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooProductTag.fake();
    }

    final response = await dio.get(
      _ProductTagEndpoints.singleTag(id),
    );

    return WooProductTag.fromJson(response.data as Map<String, dynamic>);
  }

  /// Creates a new product tag.
  ///
  /// This method adds a new product tag to the WooCommerce store.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#create-a-product-tag
  ///
  /// ## Parameters
  ///
  /// * [tag] - The WooProductTag object containing the tag data
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooProductTag>` containing the created product tag object.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a new product tag
  /// final tag = WooProductTag(
  ///   name: 'Electronics',
  ///   slug: 'electronics',
  ///   description: 'Electronic products and devices',
  /// );
  /// final created = await wooCommerce.createProductTag(tag);
  /// ```
  Future<WooProductTag> createProductTag(WooProductTag tag,
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return tag;
    }

    final response = await dio.post(
      _ProductTagEndpoints.tags,
      data: tag.toJson(),
    );

    return WooProductTag.fromJson(response.data as Map<String, dynamic>);
  }

  /// Updates an existing product tag.
  ///
  /// This method modifies an existing product tag in the WooCommerce store.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#update-a-product-tag
  ///
  /// ## Parameters
  ///
  /// * [tag] - The WooProductTag object containing the updated tag data
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooProductTag>` containing the updated product tag object.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Update an existing product tag
  /// final updatedTag = WooProductTag(
  ///   id: 123,
  ///   name: 'Premium Electronics',
  ///   slug: 'premium-electronics',
  ///   description: 'High-end electronic products and devices',
  /// );
  /// final updated = await wooCommerce.updateProductTag(updatedTag);
  /// ```
  Future<WooProductTag> updateProductTag(WooProductTag tag,
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return tag;
    }

    final response = await dio.put(
      _ProductTagEndpoints.singleTag(tag.id!),
      data: tag.toJson(),
    );

    return WooProductTag.fromJson(response.data as Map<String, dynamic>);
  }

  /// Deletes a specific product tag.
  ///
  /// This method permanently removes a product tag from the WooCommerce store.
  /// Note: The force parameter is required to be true as product tags do not support trashing.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#delete-a-product-tag
  ///
  /// ## Parameters
  ///
  /// * [tagId] - The ID of the product tag to delete
  /// * [useFaker] - When true, simulates successful deletion for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooProductTag>` containing the deleted product tag object.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Delete a product tag
  /// final deleted = await wooCommerce.deleteProductTag(123);
  /// if (deleted != null) {
  ///   print('Product tag deleted successfully');
  /// }
  /// ```
  Future<WooProductTag> deleteProductTag(int tagId, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooProductTag.fake(tagId);
    }

    final response = await dio
        .delete(_ProductTagEndpoints.singleTag(tagId), queryParameters: {
      'force': true,
    });

    return WooProductTag.fromJson(response.data as Map<String, dynamic>);
  }
}
