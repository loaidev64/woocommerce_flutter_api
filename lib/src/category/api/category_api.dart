import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'endpoints.dart';

/// WooCommerce Category API Extension
///
/// This extension provides comprehensive product category management capabilities for WooCommerce stores.
/// It allows you to create, read, update, and delete product categories, as well as retrieve category lists
/// with extensive filtering and pagination options.
///
/// ## Key Features
///
/// - **Category Management**: Create, read, update, and delete product categories
/// - **Hierarchical Support**: Handle parent-child category relationships
/// - **Advanced Filtering**: Filter categories by parent, product, slug, and more
/// - **Pagination Support**: Efficiently handle large category collections
/// - **Search Capabilities**: Find categories by name or other criteria
/// - **Display Control**: Configure how categories display products and subcategories
///
/// ## Example Usage
///
/// ```dart
/// // Get all categories
/// final categories = await wooCommerce.getCategories();
///
/// // Create a new category
/// final category = WooProductCategory(
///   name: 'Electronics',
///   description: 'Electronic products and gadgets',
/// );
/// final created = await wooCommerce.createCategory(category);
/// ```
extension WooCategoryApi on WooCommerce {
  /// Retrieves a list of product categories from the WooCommerce store.
  ///
  /// This method supports extensive filtering and pagination options to help you
  /// find exactly the categories you need.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-product-categories
  ///
  /// ## Parameters
  ///
  /// * [context] - Scope under which the request is made; determines fields present in response.
  ///   - `WooContext.view`: Returns basic category information (default)
  ///   - `WooContext.edit`: Returns full category details including sensitive data
  ///
  /// * [page] - Current page of the collection (default: 1)
  /// * [perPage] - Maximum number of items to return (default: 10, max: 100)
  /// * [search] - Limit results to categories matching a search string
  /// * [exclude] - Ensure result set excludes specific category IDs
  /// * [include] - Limit result set to specific category IDs
  /// * [order] - Order sort attribute ascending or descending (default: desc)
  /// * [orderBy] - Sort collection by object attribute (default: name)
  /// * [hideEmpty] - Whether to hide categories not assigned to any products (default: false)
  /// * [parent] - Limit result set to categories assigned to a specific parent
  /// * [product] - Limit result set to categories assigned to a specific product
  /// * [slug] - Limit result set to categories with a specific slug
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooProductCategory>>` containing the category objects.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get all categories
  /// final categories = await wooCommerce.getCategories();
  ///
  /// // Search for categories
  /// final searchResults = await wooCommerce.getCategories(
  ///   search: 'electronics',
  ///   perPage: 20,
  /// );
  ///
  /// // Get subcategories of a specific parent
  /// final subcategories = await wooCommerce.getCategories(
  ///   parent: 15,
  ///   hideEmpty: true,
  /// );
  /// ```
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

  /// Resolves query parameters for the getCategories method.
  ///
  /// This private helper method converts the method parameters into the appropriate
  /// query parameters format expected by the WooCommerce REST API.
  ///
  /// ## Parameters
  ///
  /// All parameters correspond to the getCategories method parameters.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the formatted query parameters.
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

  /// Retrieves a single product category by its ID from the WooCommerce store.
  ///
  /// This method fetches detailed information about a specific category,
  /// including all its properties and relationships.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#retrieve-a-product-category
  ///
  /// ## Parameters
  ///
  /// * [id] - The unique identifier of the category to retrieve
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooProductCategory>` containing the category object.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the category is not found or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get a specific category
  /// final category = await wooCommerce.getCategory(123);
  ///
  /// // Check category details
  /// if (category.count! > 0) {
  ///   print('Category ${category.name} has ${category.count} products');
  /// }
  /// ```
  Future<WooProductCategory> getCategory(int id, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooProductCategory.fake();
    }

    final response = await dio.get(_CategoryEndpoints.singleCategory(id));

    return WooProductCategory.fromJson(response.data as Map<String, dynamic>);
  }

  /// Creates a new product category in the WooCommerce store.
  ///
  /// This method creates a new category with the specified properties and settings.
  /// The category will be immediately available for product assignment.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#create-a-product-category
  ///
  /// ## Parameters
  ///
  /// * [category] - The category object containing all the category details
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooProductCategory>` containing the created category object with server-assigned ID.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the category creation fails or validation errors occur
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a top-level category
  /// final category = WooProductCategory(
  ///   name: 'Electronics',
  ///   description: 'Electronic products and gadgets',
  ///   slug: 'electronics',
  /// );
  /// final created = await wooCommerce.createCategory(category);
  ///
  /// // Create a subcategory
  /// final subcategory = WooProductCategory(
  ///   name: 'Smartphones',
  ///   parent: created.id,
  ///   description: 'Mobile phones and accessories',
  /// );
  /// final createdSub = await wooCommerce.createCategory(subcategory);
  /// ```
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

  /// Updates an existing product category in the WooCommerce store.
  ///
  /// This method updates the properties and settings of an existing category.
  /// The category must have a valid ID to be updated.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#update-a-product-category
  ///
  /// ## Parameters
  ///
  /// * [category] - The category object with updated properties (must include valid ID)
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooProductCategory>` containing the updated category object.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the category update fails, category not found, or validation errors occur
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Update an existing category
  /// final existingCategory = await wooCommerce.getCategory(123);
  /// existingCategory.name = 'Updated Electronics';
  /// existingCategory.description = 'Updated description';
  /// final result = await wooCommerce.updateCategory(existingCategory);
  ///
  /// // Move category to different parent
  /// existingCategory.parent = 456;
  /// await wooCommerce.updateCategory(existingCategory);
  /// ```
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

  /// Deletes a product category from the WooCommerce store.
  ///
  /// This method removes a category from the store. By default, the category is moved to trash,
  /// but it can be permanently deleted using the force parameter.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#delete-a-product-category
  ///
  /// ## Parameters
  ///
  /// * [id] - The unique identifier of the category to delete
  /// * [force] - Whether to permanently delete the category instead of moving to trash (default: false)
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<bool>` indicating whether the deletion was successful.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the category deletion fails or category not found
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Move category to trash (can be restored)
  /// final success = await wooCommerce.deleteCategory(123);
  ///
  /// // Permanently delete category
  /// final permanentDelete = await wooCommerce.deleteCategory(
  ///   123,
  ///   force: true,
  /// );
  ///
  /// if (success) {
  ///   print('Category deleted successfully');
  /// }
  /// ```
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
