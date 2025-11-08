import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'tax_rate_endpoints.dart';

/// WooCommerce Tax Rate API Extension
///
/// This extension provides comprehensive tax rate management capabilities for WooCommerce stores.
/// It enables creation, retrieval, updating, and deletion of tax rates with extensive
/// filtering and sorting options to help store owners manage complex tax configurations.
///
/// ## Key Features
///
/// - **Tax Rate Management**: Full CRUD operations for tax rates
/// - **Advanced Filtering**: Filter by tax class, geographical location, and more
/// - **Flexible Sorting**: Sort tax rates by various attributes
/// - **Geographical Targeting**: Support for country, state, city, and postal code rules
/// - **Pagination Support**: Handle large datasets with page-based navigation
///
/// ## Example Usage
///
/// ```dart
/// // Get all tax rates
/// final taxRates = await wooCommerce.getTaxRates();
///
/// // Get tax rates for a specific tax class
/// final standardRates = await wooCommerce.getTaxRates(
///   taxClass: 'standard',
///   orderBy: WooTaxRateOrderBy.rate,
/// );
///
/// // Create a new tax rate
/// final newTaxRate = WooTaxRate(
///   country: 'US',
///   state: 'CA',
///   rate: '8.25',
///   name: 'California Sales Tax',
/// );
/// final created = await wooCommerce.createTaxRate(newTaxRate);
/// ```
extension WooTaxRateApi on WooCommerce {
  /// Retrieves a list of tax rates from the WooCommerce store.
  ///
  /// This method supports extensive filtering and sorting options to help you
  /// find exactly the tax rates you need. You can filter by tax class, sort by
  /// various attributes, and use pagination for large datasets.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-tax-rates
  ///
  /// ## Parameters
  ///
  /// * [context] - Scope under which the request is made; determines fields present in response.
  ///   - `WooContext.view`: Returns basic tax rate information (default)
  ///   - `WooContext.edit`: Returns full tax rate details including sensitive data
  ///
  /// * [page] - Current page of the collection (default: 1)
  /// * [perPage] - Maximum number of items to return (default: 10, max: 100)
  /// * [offset] - Offset the result set by a specific number of items
  /// * [order] - Order sort attribute ascending or descending (default: desc)
  /// * [orderBy] - Sort collection by object attribute (default: date)
  /// * [taxClass] - Retrieve only tax rates of this tax class
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooTaxRate>>` containing the tax rate objects.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get all tax rates
  /// final taxRates = await wooCommerce.getTaxRates();
  ///
  /// // Get tax rates for standard tax class
  /// final standardRates = await wooCommerce.getTaxRates(
  ///   taxClass: 'standard',
  ///   orderBy: WooTaxRateOrderBy.rate,
  /// );
  ///
  /// // Get tax rates with pagination
  /// final pagedRates = await wooCommerce.getTaxRates(
  ///   page: 2,
  ///   perPage: 20,
  ///   order: WooSortOrder.asc,
  /// );
  /// ```
  Future<List<WooTaxRate>> getTaxRates({
    WooContext context = WooContext.view,
    int page = 1,
    int perPage = 10,
    int? offset,
    WooSortOrder order = WooSortOrder.desc,
    WooTaxRateOrderBy orderBy = WooTaxRateOrderBy.date,
    String? taxClass,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return List.generate(perPage, (index) => WooTaxRate.fake());
    }

    final response = await dio.get(
      _TaxRateEndpoints.taxes,
      queryParameters: _resolveQueryParametersForTaxRates(
        context: context,
        page: page,
        perPage: perPage,
        offset: offset,
        order: order,
        orderBy: orderBy,
        taxClass: taxClass,
      ),
    );

    return (response.data as List)
        .map((item) => WooTaxRate.fromJson(item))
        .toList();
  }

  /// Resolves query parameters for the tax rates API request.
  Map<String, dynamic> _resolveQueryParametersForTaxRates({
    required WooContext context,
    required int? page,
    required int? perPage,
    required int? offset,
    required WooSortOrder? order,
    required WooTaxRateOrderBy? orderBy,
    required String? taxClass,
  }) {
    final map = <String, dynamic>{
      'context': context.name,
    };

    if (page != null) {
      map['page'] = page;
    }

    if (perPage != null) {
      map['per_page'] = perPage;
    }

    if (offset != null) {
      map['offset'] = offset;
    }

    if (order != null) {
      map['order'] = order.name;
    }

    if (orderBy != null) {
      map['orderby'] = orderBy.name;
    }

    if (taxClass != null) {
      map['class'] = taxClass;
    }

    return map;
  }

  /// Retrieves a specific tax rate by ID from the WooCommerce store.
  ///
  /// This method fetches detailed information about a single tax rate
  /// using its unique identifier.
  ///
  /// ## Parameters
  ///
  /// * [id] - The unique identifier of the tax rate to retrieve
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooTaxRate>` containing the tax rate object.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final taxRate = await wooCommerce.getTaxRate(123);
  /// ```
  Future<WooTaxRate> getTaxRate(int id, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooTaxRate.fake();
    }

    final response = await dio.get(
      _TaxRateEndpoints.singleTax(id),
    );

    return WooTaxRate.fromJson(response.data);
  }

  /// Creates a new tax rate in the WooCommerce store.
  ///
  /// This method creates a new tax rate with the specified configuration.
  /// The tax rate will be applied based on its geographical and tax class settings.
  ///
  /// ## Parameters
  ///
  /// * [taxRate] - The tax rate object to create
  /// * [useFaker] - When true, returns the input tax rate without API call
  ///
  /// ## Returns
  ///
  /// A `Future<WooTaxRate>` containing the created tax rate object with assigned ID.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final newTaxRate = WooTaxRate(
  ///   country: 'US',
  ///   state: 'CA',
  ///   rate: '8.25',
  ///   name: 'California Sales Tax',
  /// );
  /// final created = await wooCommerce.createTaxRate(newTaxRate);
  /// ```
  Future<WooTaxRate> createTaxRate(WooTaxRate taxRate, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return taxRate;
    }

    final response = await dio.post(
      _TaxRateEndpoints.taxes,
      data: taxRate.toJson(),
    );

    return WooTaxRate.fromJson(response.data);
  }

  /// Updates an existing tax rate in the WooCommerce store.
  ///
  /// This method updates an existing tax rate with new configuration.
  /// The tax rate must have a valid ID to be updated.
  ///
  /// ## Parameters
  ///
  /// * [taxRate] - The tax rate object with updated information
  /// * [useFaker] - When true, returns the input tax rate without API call
  ///
  /// ## Returns
  ///
  /// A `Future<WooTaxRate>` containing the updated tax rate object.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final updatedTaxRate = WooTaxRate(
  ///   id: 123,
  ///   country: 'US',
  ///   state: 'CA',
  ///   rate: '9.25', // Updated rate
  ///   name: 'California Sales Tax',
  /// );
  /// final result = await wooCommerce.updateTaxRate(updatedTaxRate);
  /// ```
  Future<WooTaxRate> updateTaxRate(WooTaxRate taxRate, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return taxRate;
    }

    final response = await dio.put(
      _TaxRateEndpoints.singleTax(taxRate.id!),
      data: taxRate.toJson(),
    );

    return WooTaxRate.fromJson(response.data);
  }

  /// Deletes a tax rate from the WooCommerce store.
  ///
  /// This method permanently removes a tax rate from the store.
  /// Use with caution as this action cannot be undone.
  ///
  /// ## Parameters
  ///
  /// * [taxRateId] - The unique identifier of the tax rate to delete
  /// * [useFaker] - When true, performs no actual deletion
  ///
  /// ## Returns
  ///
  /// A `Future<void>` that completes when the deletion is successful.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// await wooCommerce.deleteTaxRate(123);
  /// ```
  Future<void> deleteTaxRate(int taxRateId, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return;
    }

    await dio.delete(
      _TaxRateEndpoints.singleTax(taxRateId),
      queryParameters: {
        'force': true,
      },
    );
  }

  /// Performs batch operations on tax rates.
  ///
  /// This method allows you to create, update, and delete multiple tax rates
  /// in a single API request, making bulk operations more efficient. This is particularly
  /// useful for managing tax configurations across multiple regions or updating
  /// tax rates in bulk when rates change.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#batch-update-tax-rates
  ///
  /// ## Parameters
  ///
  /// * [request] - The `WooTaxRateBatchRequest` object containing
  ///   the create, update, and delete operations to perform
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooTaxRateBatchResponse>` containing the results of
  /// all batch operations, including created, updated, and deleted tax rates.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a batch request with multiple operations
  /// final batchRequest = WooTaxRateBatchRequest(
  ///   create: [
  ///     WooTaxRate(
  ///       country: 'US',
  ///       state: 'CA',
  ///       rate: '8.25',
  ///       name: 'California Sales Tax',
  ///       priority: 1,
  ///     ),
  ///     WooTaxRate(
  ///       country: 'US',
  ///       state: 'NY',
  ///       rate: '8.00',
  ///       name: 'New York Sales Tax',
  ///       priority: 1,
  ///     ),
  ///   ],
  ///   update: [
  ///     WooTaxRate(
  ///       id: 123,
  ///       rate: '9.25', // Updated rate
  ///       name: 'Updated California Sales Tax',
  ///     ),
  ///   ],
  ///   delete: [456, 789],
  /// );
  ///
  /// // Execute the batch operation
  /// final response = await wooCommerce.batchUpdateTaxRates(batchRequest);
  ///
  /// // Process results
  /// print('Created ${response.create?.length ?? 0} tax rates');
  /// print('Updated ${response.update?.length ?? 0} tax rates');
  /// print('Deleted ${response.delete?.length ?? 0} tax rates');
  ///
  /// // Access individual results
  /// for (final taxRate in response.create ?? []) {
  ///   print('Created tax rate: ${taxRate.name} with ID: ${taxRate.id}');
  ///   print('Rate: ${taxRate.rate}% for ${taxRate.country}/${taxRate.state}');
  /// }
  /// ```
  ///
  /// ## Geographical Targeting Example
  ///
  /// ```dart
  /// // Create tax rates with specific geographical targeting
  /// final batchRequest = WooTaxRateBatchRequest(
  ///   create: [
  ///     WooTaxRate(
  ///       country: 'US',
  ///       state: 'CA',
  ///       cities: ['Los Angeles', 'San Francisco'],
  ///       postcodes: ['90001', '90002'],
  ///       rate: '9.50',
  ///       name: 'California City Tax',
  ///       priority: 1,
  ///     ),
  ///     WooTaxRate(
  ///       country: 'US',
  ///       state: 'NY',
  ///       cities: ['New York'],
  ///       rate: '8.875',
  ///       name: 'New York City Tax',
  ///       priority: 1,
  ///     ),
  ///   ],
  /// );
  ///
  /// final response = await wooCommerce.batchUpdateTaxRates(batchRequest);
  /// print('Created ${response.create?.length ?? 0} city-specific tax rates');
  /// ```
  ///
  /// ## Batch Operations Best Practices
  ///
  /// - **Create operations**: Tax rates should not have IDs assigned
  /// - **Update operations**: Tax rates must have valid IDs and will be updated with provided values
  /// - **Delete operations**: Provide only the IDs of tax rates to delete
  /// - **Mixed operations**: You can combine create, update, and delete in a single request
  /// - **Geographical targeting**: Use country, state, city, and postcode fields for precise targeting
  /// - **Priority management**: Set appropriate priority values when multiple rates could apply
  /// - **Error handling**: If any operation fails, the entire batch may fail depending on API behavior
  ///
  /// ## Geographical Targeting
  ///
  /// Tax rates support flexible geographical targeting:
  ///
  /// - **Country**: Two-letter ISO 3166-1 alpha-2 code (e.g., 'US', 'CA', 'GB')
  /// - **State**: State or province code within the country
  /// - **City**: Single city name (deprecated) or list of cities (modern)
  /// - **Postcode**: Single postal code (deprecated) or list of postcodes (modern)
  ///
  /// Use the modern `cities` and `postcodes` list fields for better flexibility:
  ///
  /// ```dart
  /// WooTaxRate(
  ///   country: 'US',
  ///   state: 'CA',
  ///   cities: ['Los Angeles', 'San Francisco', 'San Diego'],
  ///   postcodes: ['90001', '90002', '94102'],
  ///   rate: '9.50',
  ///   name: 'California Major Cities Tax',
  /// )
  /// ```
  Future<WooTaxRateBatchResponse> batchUpdateTaxRates(
    WooTaxRateBatchRequest request, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooTaxRateBatchResponse(
        create: request.create?.map((taxRate) => WooTaxRate.fake()).toList(),
        update: request.update,
        delete: request.delete?.map((id) => WooTaxRate.fake(id)).toList(),
      );
    }

    final response = await dio.post(
      _TaxRateEndpoints.batchTaxRates(),
      data: request.toJson(),
    );

    return WooTaxRateBatchResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
