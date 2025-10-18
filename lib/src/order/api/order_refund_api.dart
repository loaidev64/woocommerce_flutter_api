import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'order_refund_endpoints.dart';

/// WooCommerce Order Refund API Extension
///
/// This extension provides comprehensive order refund management capabilities for WooCommerce stores.
/// It allows you to retrieve, create, and delete order refunds, which represent money returned
/// to customers for orders.
///
/// ## Key Features
///
/// - **Retrieve Order Refunds**: Get all refunds for a specific order with extensive filtering
/// - **Get Single Refund**: Retrieve a specific order refund by ID
/// - **Create Refunds**: Process new refunds for orders
/// - **Delete Refunds**: Remove order refunds (with force deletion)
///
/// ## Example Usage
///
/// ```dart
/// // Get all refunds for an order
/// final refunds = await wooCommerce.getOrderRefunds(123);
///
/// // Create a new refund
/// final refund = WooOrderRefund(
///   amount: '25.00',
///   reason: 'Product defect',
/// );
/// final created = await wooCommerce.createOrderRefund(123, refund);
/// ```
extension WooOrderRefundApi on WooCommerce {
  /// Retrieves a list of order refunds for a specific order.
  ///
  /// This method supports extensive filtering and pagination options to help you
  /// find exactly the refunds you need.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-order-refunds
  ///
  /// ## Parameters
  ///
  /// * [orderId] - The ID of the order to retrieve refunds for
  /// * [context] - Scope under which the request is made; determines fields present in response.
  ///   - `WooContext.view`: Returns basic refund information (default)
  ///   - `WooContext.edit`: Returns full refund details including sensitive data
  /// * [page] - Current page of the collection (default: 1)
  /// * [perPage] - Maximum number of items to return (default: 10, max: 100)
  /// * [search] - Limit results to refunds matching a search string
  /// * [after] - Limit response to refunds created after a given ISO8601 compliant date
  /// * [before] - Limit response to refunds created before a given ISO8601 compliant date
  /// * [exclude] - Ensure result set excludes specific refund IDs
  /// * [include] - Limit result set to specific refund IDs
  /// * [offset] - Offset the result set by a specific number of items
  /// * [order] - Order sort attribute ascending or descending (default: desc)
  /// * [orderby] - Sort collection by object attribute (default: date)
  /// * [parent] - Limit result set to those of particular parent IDs
  /// * [parentExclude] - Limit result set to all items except those of a particular parent ID
  /// * [dp] - Number of decimal points to use in each resource (default: 2)
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooOrderRefund>>` containing the order refund objects.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get all refunds for an order
  /// final refunds = await wooCommerce.getOrderRefunds(123);
  ///
  /// // Search for refunds with pagination
  /// final searchResults = await wooCommerce.getOrderRefunds(
  ///   123,
  ///   search: 'defect',
  ///   perPage: 20,
  ///   page: 1,
  /// );
  ///
  /// // Get refunds within date range
  /// final recentRefunds = await wooCommerce.getOrderRefunds(
  ///   123,
  ///   after: DateTime.now().subtract(Duration(days: 30)),
  ///   before: DateTime.now(),
  /// );
  /// ```
  Future<List<WooOrderRefund>> getOrderRefunds(
    int orderId, {
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
    WooSortRefund orderby = WooSortRefund.date,
    List<int>? parent,
    List<int>? parentExclude,
    int dp = 2,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooOrderRefund.fake);
    }

    final response = await dio.get(
      _OrderRefundEndpoints.refunds(orderId),
      queryParameters: _resolveQueryParametersForGettingOrderRefunds(
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
        orderby: orderby,
        parent: parent,
        parentExclude: parentExclude,
        dp: dp,
      ),
    );

    return (response.data as List)
        .map((item) => WooOrderRefund.fromJson(item))
        .toList();
  }

  Map<String, dynamic> _resolveQueryParametersForGettingOrderRefunds({
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
    required WooSortRefund orderby,
    required List<int>? parent,
    required List<int>? parentExclude,
    required int dp,
  }) {
    final map = <String, dynamic>{
      'context': context.name,
      'page': page,
      'per_page': perPage,
      'order': order.name,
      'orderby': orderby.name,
      'dp': dp,
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

    return map;
  }

  /// Retrieves a specific order refund by its ID.
  ///
  /// This method fetches a single order refund associated with the given order ID and refund ID.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#retrieve-an-order-refund
  ///
  /// ## Parameters
  ///
  /// * [orderId] - The ID of the order that contains the refund
  /// * [refundId] - The ID of the specific refund to retrieve
  /// * [db] - Number of decimal points to use in each resource
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooOrderRefund>` containing the order refund object.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get a specific order refund
  /// final refund = await wooCommerce.getOrderRefund(123, 456);
  ///
  /// // Get refund with specific decimal precision
  /// final preciseRefund = await wooCommerce.getOrderRefund(123, 456, db: 4);
  /// ```
  Future<WooOrderRefund> getOrderRefund(
    int orderId,
    int refundId, {
    int? db,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooOrderRefund.fake();
    }

    final response = await dio.get(
        _OrderRefundEndpoints.singleRefund(orderId, refundId),
        queryParameters: {
          if (db != null) 'db': db,
        });

    return WooOrderRefund.fromJson(response.data as Map<String, dynamic>);
  }

  /// Creates a new order refund for a specific order.
  ///
  /// This method processes a new refund for the specified order. The refund amount
  /// and reason should be specified in the WooOrderRefund object.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#create-an-order-refund
  ///
  /// ## Parameters
  ///
  /// * [orderId] - The ID of the order to create the refund for
  /// * [refund] - The WooOrderRefund object containing the refund data
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooOrderRefund>` containing the created order refund object.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a full refund
  /// final refund = WooOrderRefund(
  ///   amount: '99.99',
  ///   reason: 'Customer requested full refund',
  /// );
  /// final created = await wooCommerce.createOrderRefund(123, refund);
  ///
  /// // Create a partial refund
  /// final partialRefund = WooOrderRefund(
  ///   amount: '25.00',
  ///   reason: 'Product defect - partial refund',
  /// );
  /// final createdPartial = await wooCommerce.createOrderRefund(123, partialRefund);
  /// ```
  Future<WooOrderRefund> createOrderRefund(
    int orderId,
    WooOrderRefund refund, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooOrderRefund.fake();
    }

    final response = await dio.post(_OrderRefundEndpoints.refunds(orderId),
        data: refund.toJson());

    return WooOrderRefund.fromJson(response.data as Map<String, dynamic>);
  }

  /// Deletes a specific order refund.
  ///
  /// This method permanently removes an order refund from the specified order.
  /// Note: The force parameter is required to be true as order refunds do not support trashing.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#delete-an-order-refund
  ///
  /// ## Parameters
  ///
  /// * [orderId] - The ID of the order that contains the refund
  /// * [refundId] - The ID of the refund to delete
  /// * [useFaker] - When true, simulates successful deletion for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<bool>` indicating whether the deletion was successful.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Delete an order refund
  /// final success = await wooCommerce.deleteOrderRefund(123, 456);
  /// if (success) {
  ///   print('Order refund deleted successfully');
  /// }
  /// ```
  Future<bool> deleteOrderRefund(
    int orderId,
    int refundId, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return true;
    }

    await dio.delete(
      _OrderRefundEndpoints.singleRefund(orderId, refundId),
      queryParameters: {
        'force': true,
      },
    );

    return true;
  }
}
