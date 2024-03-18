import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'endpoints.dart';

extension WooOrderApi on WooCommerce {
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
  /// [modifiedAfter] Limit response to resources modified after a given ISO8601 compliant date.
  ///
  /// [modifiedBefore] Limit response to resources modified after a given ISO8601 compliant date.
  ///
  /// [datesAreGmt] Whether to consider GMT post dates when limiting response by published or modified date.
  ///
  /// [exclude] Ensure result set excludes specific IDs.
  ///
  /// [include] Limit result set to specific ids.
  ///
  /// [offset] Offset the result set by a specific number of items.
  ///
  /// [order] Order sort attribute ascending or descending. Options: asc and desc. Default is desc.
  ///
  /// [orderBy] Sort collection by object attribute. Options: date, id, include, title, slug, price, popularity and rating. Default is date.
  ///
  /// [parent] Limit result set to those of particular parent IDs.
  ///
  /// [parentExclude] Limit result set to all items except those of a particular parent ID.
  ///
  /// [status] Limit result set to orders assigned a specific status. Options: any, pending, processing, on-hold, completed, cancelled, refunded, failed and trash. Default is any.
  ///
  /// [customer] Limit result set to orders assigned a specific customer.
  ///
  /// [product] Limit result set to orders assigned a specific product.
  ///
  /// [dp] Number of decimal points to use in each resource. Default is 2.
  ///
  /// [useFaker], fakes the api request
  Future<List<WooOrder>> getOrders({
    WooContext context = WooContext.view,
    int page = 1,
    int perPage = 10,
    String? search,
    DateTime? after,
    DateTime? before,
    DateTime? modifiedAfter,
    DateTime? modifiedBefore,
    bool? datesAreGmt,
    List<int>? exclude,
    List<int>? include,
    int? offset,
    WooSortOrder order = WooSortOrder.desc,
    WooSortOrderBy orderBy = WooSortOrderBy.date,
    List<int>? parent,
    List<int>? parentExclude,
    List<WooOrderStatus> status = const [WooOrderStatus.any],
    int? customer,
    int? product,
    int? dp,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return List.generate(perPage, (index) => WooOrder.fake());
    }

    final response = await dio.get(
      _OrderEndpoints.orders,
      queryParameters: _resolveQueryParametersForGettingOrders(
        context: context,
        page: page,
        perPage: perPage,
        search: search,
        after: after,
        before: before,
        modifiedAfter: modifiedAfter,
        modifiedBefore: modifiedBefore,
        datesAreGmt: datesAreGmt,
        exclude: exclude,
        include: include,
        offset: offset,
        order: order,
        orderBy: orderBy,
        parent: parent,
        parentExclude: parentExclude,
        status: status,
        customer: customer,
        product: product,
        dp: dp,
      ),
    );

    return (response.data as List)
        .map((item) => WooOrder.fromJson(item))
        .toList();
  }

  Map<String, dynamic> _resolveQueryParametersForGettingOrders({
    required WooContext context,
    required int page,
    required int perPage,
    required String? search,
    required DateTime? after,
    required DateTime? before,
    required DateTime? modifiedAfter,
    required DateTime? modifiedBefore,
    required bool? datesAreGmt,
    required List<int>? exclude,
    required List<int>? include,
    required int? offset,
    required WooSortOrder order,
    required WooSortOrderBy orderBy,
    required List<int>? parent,
    required List<int>? parentExclude,
    required List<WooOrderStatus> status,
    required int? customer,
    required int? product,
    required int? dp,
  }) {
    final map = <String, dynamic>{
      'context': context.name,
      'page': page,
      'per_page': perPage,
      'order': order.name,
      'orderby': orderBy.name,
      'status': status.map((item) => item.name).join(','),
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

    if (modifiedAfter != null) {
      map['modified_after'] = modifiedAfter.toIso8601String();
    }

    if (modifiedBefore != null) {
      map['modified_before'] = modifiedBefore.toIso8601String();
    }

    if (datesAreGmt != null) {
      map['dates_are_gmt'] = datesAreGmt;
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

    if (customer != null) {
      map['customer'] = customer;
    }

    if (product != null) {
      map['product'] = product;
    }

    if (dp != null) {
      map['dp'] = dp;
    }

    return map;
  }

  Future<WooOrder> getOrder(int id, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooOrder.fake();
    }

    final response = await dio.get(_OrderEndpoints.singleOrder(id));

    return WooOrder.fromJson(response.data as Map<String, dynamic>);
  }

  Future<WooOrder> createOrder(WooOrder order, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return order;
    }

    final response = await dio.post(
      _OrderEndpoints.orders,
      data: order.toJson(),
    );

    return WooOrder.fromJson(response.data as Map<String, dynamic>);
  }

  Future<WooOrder> updateOrder(WooOrder order, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return order;
    }

    final response = await dio.put(
      _OrderEndpoints.orders,
      data: order.toJson(),
    );

    return WooOrder.fromJson(response.data as Map<String, dynamic>);
  }

  /// [force] Use true whether to permanently delete the order, Default is false.
  Future<bool> deleteOrder(
    int id, {
    bool? useFaker,
    bool force = false,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return true;
    }

    await dio.delete(
      _OrderEndpoints.singleOrder(id),
      queryParameters: {
        'force': force,
      },
    );

    return true;
  }
}
