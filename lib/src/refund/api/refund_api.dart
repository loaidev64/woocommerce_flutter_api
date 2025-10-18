import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'endpoints.dart';

/// WooCommerce Refund API Extension
///
/// This extension provides comprehensive refund management capabilities for WooCommerce stores.
/// It enables retrieval of refund information with extensive filtering and pagination options
/// to help store owners track and manage order refunds effectively.
///
/// ## Key Features
///
/// - **Refund Retrieval**: Get detailed refund information with comprehensive filtering
/// - **Advanced Filtering**: Filter by date ranges, parent orders, and specific criteria
/// - **Pagination Support**: Handle large datasets with page-based navigation
/// - **Search Capabilities**: Find refunds by specific search terms
/// - **Sorting Options**: Sort refunds by various attributes (date, amount, etc.)
///
/// ## Example Usage
///
/// ```dart
/// // Get all refunds
/// final refunds = await wooCommerce.getRefunds();
///
/// // Get refunds for a specific order
/// final orderRefunds = await wooCommerce.getRefunds(
///   parent: [123],
///   perPage: 50,
/// );
///
/// // Search for refunds by reason
/// final searchResults = await wooCommerce.getRefunds(
///   search: 'defective product',
///   orderBy: WooSortOrderBy.date,
/// );
/// ```
extension WooRefundApi on WooCommerce {
  /// Retrieves a list of refunds from the WooCommerce store.
  ///
  /// This method supports extensive filtering and pagination options to help you
  /// find exactly the refunds you need. You can filter by date ranges, parent orders,
  /// search terms, and more.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-refunds
  ///
  /// ## Parameters
  ///
  /// * [context] - Scope under which the request is made; determines fields present in response.
  ///   - `WooContext.view`: Returns basic refund information (default)
  ///   - `WooContext.edit`: Returns full refund details including sensitive data
  ///
  /// * [page] - Current page of the collection (default: 1)
  /// * [perPage] - Maximum number of items to return (default: 10, max: 100)
  /// * [search] - Limit results to refunds matching a search string
  /// * [after] - Limit response to refunds created after a given ISO8601 compliant date
  /// * [before] - Limit response to refunds created before a given ISO8601 compliant date
  /// * [exclude] - Ensure result set excludes specific refund IDs
  /// * [include] - Limit result set to specific refund IDs
  /// * [offset] - Offset the result set by a specific number of items
  /// * [order] - Order sort attribute ascending or descending (default: desc)
  /// * [orderBy] - Sort collection by object attribute (default: date)
  /// * [parent] - Limit result set to refunds of particular parent order IDs
  /// * [parentExclude] - Limit result set to all refunds except those of particular parent order IDs
  /// * [dp] - Number of decimal points to use in each resource (default: 2)
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooRefund>>` containing the refund objects.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get all refunds
  /// final refunds = await wooCommerce.getRefunds();
  ///
  /// // Get refunds for a specific order
  /// final orderRefunds = await wooCommerce.getRefunds(
  ///   parent: [123],
  ///   perPage: 50,
  /// );
  ///
  /// // Search for refunds by reason
  /// final searchResults = await wooCommerce.getRefunds(
  ///   search: 'defective product',
  ///   orderBy: WooSortOrderBy.date,
  /// );
  ///
  /// // Get refunds within date range
  /// final recentRefunds = await wooCommerce.getRefunds(
  ///   after: DateTime(2024, 1, 1),
  ///   before: DateTime(2024, 12, 31),
  ///   order: WooSortOrder.asc,
  /// );
  /// ```
  Future<List<WooRefund>> getRefunds({
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
    int? dp,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return List.generate(perPage, (index) => WooRefund.fake());
    }

    final response = await dio.get(
      _RefundEndpoints.refunds,
      queryParameters: _resolveQueryParametersForGettingOrders(
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
        dp: dp,
      ),
    );

    return (response.data as List).map((e) => WooRefund.fromJson(e)).toList();
  }

  Map<String, dynamic> _resolveQueryParametersForGettingOrders({
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
    required int? dp,
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

    if (dp != null) {
      map['dp'] = dp;
    }

    return map;
  }
}
