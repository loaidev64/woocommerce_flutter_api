import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'customer_endpoints.dart';

extension WooCustomernApi on WooCommerce {
  /// [context]	Scope under which the request is made; determines fields present in response. Options: view and edit. Default is view.
  ///
  /// [page] integer	Current page of the collection. Default is 1.
  ///
  /// [perPage] integer	Maximum number of items to be returned in result set. Default is 10.
  ///
  /// [search] Limit results to those matching a string.
  ///
  /// [exclude] Ensure result set excludes specific IDs.
  ///
  /// [include] Limit result set to specific ids.
  ///
  /// [offset] Offset the result set by a specific number of items.
  ///
  /// [order] Order sort attribute ascending or descending. Options: asc and desc. Default is asc.
  ///
  /// [orderby] Sort collection by object attribute. Options: id, include, name and registered_date. Default is name.
  ///
  /// [email] Limit result set to resources with a specific email.
  ///
  /// [role] Limit result set to resources with a specific role. Options: all, administrator, editor, author, contributor, subscriber, customer and shop_manager. Default is customer.
  ///
  Future<List<WooCustomer>> getCustomers({
    WooContext context = WooContext.view,
    int page = 1,
    int perPage = 10,
    String? search,
    List<int>? exclude,
    List<int>? include,
    int? offset,
    WooSortOrder order = WooSortOrder.asc,
    WooCustomerSort orderby = WooCustomerSort.name,
    String? email,
    WooCustomerRole role = WooCustomerRole.customer,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return List.generate(perPage, (index) => WooCustomer.fake());
    }

    final response = await dio.get(
      _CustomerEndpoints.customers,
      queryParameters: _resolveQueryParametersForGettingCustomers(
        context: context,
        page: page,
        perPage: perPage,
        search: search,
        exclude: exclude,
        include: include,
        offset: offset,
        order: order,
        orderBy: orderby,
        email: email,
        role: role,
      ),
    );

    return (response.data as List)
        .map((item) => WooCustomer.fromJson(item))
        .toList();
  }

  Map<String, dynamic> _resolveQueryParametersForGettingCustomers({
    required WooContext context,
    required int page,
    required int perPage,
    required String? search,
    required List<int>? exclude,
    required List<int>? include,
    required int? offset,
    required WooSortOrder order,
    required WooCustomerSort orderBy,
    required String? email,
    required WooCustomerRole role,
  }) {
    final map = <String, dynamic>{
      'context': context.name,
      'page': page,
      'per_page': perPage,
      'order': order.name,
      'orderby': orderBy.name,
      'role': role.name,
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

    if (email != null) {
      map['email'] = email;
    }

    return map;
  }

  Future<WooCustomer> getCustomer(int id, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooCustomer.fake(id);
    }

    final response = await dio.get(
      _CustomerEndpoints.singleCustomer(id),
    );

    return WooCustomer.fromJson(response.data as Map<String, dynamic>);
  }

  Future<WooCustomer> createCustomer(WooCustomer customer,
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return customer;
    }

    final response = await dio.post(
      _CustomerEndpoints.customers,
      data: customer.toJson(),
    );

    return WooCustomer.fromJson(response.data as Map<String, dynamic>);
  }

  Future<WooCustomer> updateCustomer(WooCustomer customer,
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return customer;
    }

    final response = await dio.put(
      _CustomerEndpoints.singleCustomer(customer.id!),
      data: customer.toJson(),
    );

    return WooCustomer.fromJson(response.data as Map<String, dynamic>);
  }

  /// [force] Required to be true, as resource does not support trashing.
  ///
  /// [reassign] User ID to reassign posts to.
  Future<bool> deleteCustomer(
    int id, {
    bool? useFaker,
    int? reassign,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return true;
    }

    await dio.delete(
      _CustomerEndpoints.singleCustomer(id),
      queryParameters: {
        'force': true,
        if (reassign != null) 'reassign': reassign,
      },
    );

    return true;
  }

  Future<List<WooCustomerDownload>> getCustomerDownloads(
    int customerId, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(() => WooCustomerDownload.fake());
    }

    final response = await dio.get(_CustomerEndpoints.downloads(customerId));

    return (response.data as List)
        .map((item) => WooCustomerDownload.fromJson(item))
        .toList();
  }

  /// Performs batch operations on customers (create, update, delete) in a single request.
  ///
  /// This method allows you to create, update, and delete multiple customers
  /// efficiently in a single API call, reducing the number of requests needed
  /// for bulk operations.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#batch-update-customers
  ///
  /// ## Parameters
  ///
  /// * [request] - The batch request containing customers to create, update, and/or delete
  ///   - `create`: List of `WooCustomer` objects to create (should not have IDs)
  ///   - `update`: List of `WooCustomer` objects to update (must include valid IDs)
  ///   - `delete`: List of customer IDs (integers) to delete
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooCustomerBatchResponse>` containing the results of all batch operations:
  /// - `create`: List of successfully created customers with server-assigned IDs
  /// - `update`: List of successfully updated customers
  /// - `delete`: List of successfully deleted customers
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the batch operation fails or validation errors occur
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a batch request with multiple operations
  /// final batchRequest = WooCustomerBatchRequest(
  ///   create: [
  ///     WooCustomer(
  ///       email: 'customer1@example.com',
  ///       firstName: 'John',
  ///       lastName: 'Doe',
  ///       username: 'johndoe',
  ///     ),
  ///     WooCustomer(
  ///       email: 'customer2@example.com',
  ///       firstName: 'Jane',
  ///       lastName: 'Smith',
  ///       username: 'janesmith',
  ///     ),
  ///   ],
  ///   update: [
  ///     existingCustomer..firstName = 'Updated Name',
  ///   ],
  ///   delete: [123, 456],
  /// );
  ///
  /// // Execute the batch operation
  /// final response = await wooCommerce.batchUpdateCustomers(batchRequest);
  ///
  /// // Process results
  /// print('Created ${response.create?.length ?? 0} customers');
  /// print('Updated ${response.update?.length ?? 0} customers');
  /// print('Deleted ${response.delete?.length ?? 0} customers');
  ///
  /// // Access individual results
  /// for (final customer in response.create ?? []) {
  ///   print('Created customer: ${customer.email} with ID: ${customer.id}');
  /// }
  /// ```
  ///
  /// ## Batch Operations Best Practices
  ///
  /// - **Create operations**: Customers should not have IDs assigned
  /// - **Update operations**: Customers must have valid IDs and will be updated with provided values
  /// - **Delete operations**: Provide only the IDs of customers to delete
  /// - **Mixed operations**: You can combine create, update, and delete in a single request
  /// - **Error handling**: If any operation fails, the entire batch may fail depending on API behavior
  Future<WooCustomerBatchResponse> batchUpdateCustomers(
    WooCustomerBatchRequest request, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooCustomerBatchResponse(
        create: request.create
            ?.map((customer) => WooCustomer.fake())
            .toList(),
        update: request.update,
        delete: request.delete
            ?.map((id) => WooCustomer.fake(id))
            .toList(),
      );
    }

    final response = await dio.post(
      _CustomerEndpoints.batchCustomers(),
      data: request.toJson(),
    );

    return WooCustomerBatchResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
