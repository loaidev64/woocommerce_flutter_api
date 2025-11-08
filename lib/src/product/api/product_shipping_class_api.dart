import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'product_shipping_class_endpoints.dart';

/// WooCommerce Product Shipping Class API Extension
///
/// This extension provides comprehensive product shipping class management capabilities for WooCommerce stores.
/// It allows you to retrieve, create, update, and delete shipping classes, which are used to group
/// products with similar shipping requirements.
///
/// ## Key Features
///
/// - **Retrieve Shipping Classes**: Get all shipping classes with extensive filtering options
/// - **Get Single Shipping Class**: Retrieve a specific shipping class by ID
/// - **Create Shipping Classes**: Add new shipping classes for product grouping
/// - **Update Shipping Classes**: Modify existing shipping class properties
/// - **Delete Shipping Classes**: Remove shipping classes (with force deletion)
///
/// ## Example Usage
///
/// ```dart
/// // Get all shipping classes
/// final shippingClasses = await wooCommerce.getProductShippingClasses();
///
/// // Create a new shipping class
/// final shippingClass = WooProductShippingClass(
///   name: 'Express Shipping',
///   slug: 'express-shipping',
///   description: 'Fast delivery option',
/// );
/// final created = await wooCommerce.createProductShippingClass(shippingClass);
/// ```
extension WooProductShippingClassApi on WooCommerce {
  /// Retrieves a list of product shipping classes from the WooCommerce store.
  ///
  /// This method supports extensive filtering and pagination options to help you
  /// find exactly the shipping classes you need.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-product-shipping-classes
  ///
  /// ## Parameters
  ///
  /// * [context] - Scope under which the request is made; determines fields present in response.
  ///   - `WooContext.view`: Returns basic shipping class information (default)
  ///   - `WooContext.edit`: Returns full shipping class details including sensitive data
  /// * [page] - Current page of the collection (default: 1)
  /// * [perPage] - Maximum number of items to return (default: 10, max: 100)
  /// * [search] - Limit results to shipping classes matching a search string
  /// * [exclude] - Ensure result set excludes specific shipping class IDs
  /// * [include] - Limit result set to specific shipping class IDs
  /// * [offset] - Offset the result set by a specific number of items
  /// * [order] - Order sort attribute ascending or descending (default: asc)
  /// * [orderBy] - Sort collection by resource attribute (default: name)
  /// * [hideEmpty] - Whether to hide shipping classes not assigned to any products (default: false)
  /// * [product] - Limit result set to shipping classes assigned to a specific product
  /// * [slug] - Limit result set to shipping classes with a specific slug
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooProductShippingClass>>` containing the shipping class objects.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get all shipping classes
  /// final shippingClasses = await wooCommerce.getProductShippingClasses();
  ///
  /// // Search for shipping classes with pagination
  /// final searchResults = await wooCommerce.getProductShippingClasses(
  ///   search: 'express',
  ///   perPage: 20,
  ///   page: 1,
  /// );
  ///
  /// // Get shipping classes for a specific product
  /// final productShippingClasses = await wooCommerce.getProductShippingClasses(
  ///   product: 123,
  /// );
  /// ```
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

  /// Retrieves a specific product shipping class by its ID.
  ///
  /// This method fetches a single shipping class associated with the given ID.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#retrieve-a-product-shipping-class
  ///
  /// ## Parameters
  ///
  /// * [id] - The ID of the shipping class to retrieve
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooProductShippingClass>` containing the shipping class object.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get a specific shipping class
  /// final shippingClass = await wooCommerce.getProductShippingClass(123);
  /// ```
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

  /// Creates a new product shipping class.
  ///
  /// This method adds a new shipping class to the WooCommerce store.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#create-a-product-shipping-class
  ///
  /// ## Parameters
  ///
  /// * [shippingClass] - The WooProductShippingClass object containing the shipping class data
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooProductShippingClass>` containing the created shipping class object.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a new shipping class
  /// final shippingClass = WooProductShippingClass(
  ///   name: 'Express Shipping',
  ///   slug: 'express-shipping',
  ///   description: 'Fast delivery option',
  /// );
  /// final created = await wooCommerce.createProductShippingClass(shippingClass);
  /// ```
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

  /// Updates an existing product shipping class.
  ///
  /// This method modifies an existing shipping class in the WooCommerce store.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#update-a-product-shipping-class
  ///
  /// ## Parameters
  ///
  /// * [shippingClass] - The WooProductShippingClass object containing the updated shipping class data
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooProductShippingClass>` containing the updated shipping class object.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Update an existing shipping class
  /// final updatedShippingClass = WooProductShippingClass(
  ///   id: 123,
  ///   name: 'Premium Express Shipping',
  ///   slug: 'premium-express-shipping',
  ///   description: 'Premium fast delivery option',
  /// );
  /// final updated = await wooCommerce.updateProductShippingClass(updatedShippingClass);
  /// ```
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

  /// Deletes a specific product shipping class.
  ///
  /// This method permanently removes a shipping class from the WooCommerce store.
  /// Note: The force parameter is required to be true as shipping classes do not support trashing.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#delete-a-product-shipping-class
  ///
  /// ## Parameters
  ///
  /// * [shippingClassId] - The ID of the shipping class to delete
  /// * [useFaker] - When true, simulates successful deletion for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooProductShippingClass>` containing the deleted shipping class object.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Delete a shipping class
  /// final deleted = await wooCommerce.deleteProductShippingClass(123);
  /// if (deleted != null) {
  ///   print('Shipping class deleted successfully');
  /// }
  /// ```
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

  /// Performs batch operations on product shipping classes.
  ///
  /// This method allows you to create, update, and delete multiple shipping classes
  /// in a single API request, making bulk operations more efficient.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#batch-update-product-shipping-classes
  ///
  /// ## Parameters
  ///
  /// * [request] - The `WooProductShippingClassBatchRequest` object containing
  ///   the create, update, and delete operations to perform
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooProductShippingClassBatchResponse>` containing the results of
  /// all batch operations, including created, updated, and deleted shipping classes.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a batch request with multiple operations
  /// final batchRequest = WooProductShippingClassBatchRequest(
  ///   create: [
  ///     WooProductShippingClass(
  ///       name: 'Express Shipping',
  ///       slug: 'express-shipping',
  ///       description: 'Fast delivery option',
  ///     ),
  ///     WooProductShippingClass(
  ///       name: 'Standard Shipping',
  ///       slug: 'standard-shipping',
  ///       description: 'Regular delivery option',
  ///     ),
  ///   ],
  ///   update: [
  ///     WooProductShippingClass(
  ///       id: 123,
  ///       name: 'Updated Express Shipping',
  ///       slug: 'updated-express-shipping',
  ///       description: 'Updated fast delivery option',
  ///     ),
  ///   ],
  ///   delete: [456, 789],
  /// );
  ///
  /// // Execute the batch operation
  /// final response = await wooCommerce.batchUpdateProductShippingClasses(batchRequest);
  ///
  /// // Process results
  /// print('Created ${response.create?.length ?? 0} shipping classes');
  /// print('Updated ${response.update?.length ?? 0} shipping classes');
  /// print('Deleted ${response.delete?.length ?? 0} shipping classes');
  ///
  /// // Access individual results
  /// for (final shippingClass in response.create ?? []) {
  ///   print('Created shipping class: ${shippingClass.name} with ID: ${shippingClass.id}');
  /// }
  /// ```
  ///
  /// ## Batch Operations Best Practices
  ///
  /// - **Create operations**: Shipping classes should not have IDs assigned
  /// - **Update operations**: Shipping classes must have valid IDs and will be updated with provided values
  /// - **Delete operations**: Provide only the IDs of shipping classes to delete
  /// - **Mixed operations**: You can combine create, update, and delete in a single request
  /// - **Error handling**: If any operation fails, the entire batch may fail depending on API behavior
  Future<WooProductShippingClassBatchResponse> batchUpdateProductShippingClasses(
    WooProductShippingClassBatchRequest request, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooProductShippingClassBatchResponse(
        create: request.create?.map((shippingClass) => WooProductShippingClass.fake()).toList(),
        update: request.update,
        delete: request.delete?.map((id) => WooProductShippingClass.fake(id)).toList(),
      );
    }

    final response = await dio.post(
      _ProductShippingClassEndpoints.batchProductShippingClasses(),
      data: request.toJson(),
    );

    return WooProductShippingClassBatchResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
