import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'order_refund_endpoints.dart';

extension WooOrderRefundApi on WooCommerce {
  /// [context] Scope under which the request is made; determines fields present in response. Options: view and edit. Default is view.
  ///
  /// [page] Current page of the collection. Default is 1.
  ///
  /// [perPage] Maximum number of items to be returned in result set. Default is 10.
  ///
  /// [search] Limit results to those matching a string.
  ///
  /// [after] Limit response to resources published after a given ISO8601 compliant date.
  ///
  /// [before] Limit response to resources published before a given ISO8601 compliant date.
  ///
  /// [exclude] Ensure result set excludes specific IDs.
  ///
  /// [include] Limit result set to specific IDs.
  ///
  /// [offset] Offset the result set by a specific number of items.
  ///
  /// [order] Order sort attribute ascending or descending. Options: asc and desc. Default is desc.
  ///
  /// [orderby] Sort collection by object attribute. Options: date, modified, id, include, title, and slug. Default is date.
  ///
  /// [parent] Limit result set to those of particular parent IDs.
  ///
  /// [parentExclude] Limit result set to all items except those of a particular parent ID.
  ///
  /// [dp] Number of decimal points to use in each resource. Default is 2.
  ///
  /// [useFaker] Fakes the API request.
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

  /// [db] Number of decimal points to use in each resource.
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

  /// [force] Required to be true, as resource does not support trashing.
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
