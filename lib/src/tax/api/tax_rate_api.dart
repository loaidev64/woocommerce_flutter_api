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
}
