import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'webhook_endpoints.dart';

extension WooWebhookApi on WooCommerce {
  /// Get all webhooks
  ///
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
  /// [include] Limit result set to specific ids.
  ///
  /// [offset] Offset the result set by a specific number of items.
  ///
  /// [order] Order sort attribute ascending or descending. Options: asc and desc. Default is desc.
  ///
  /// [orderBy] Sort collection by object attribute. Options: date, id, and title. Default is date.
  ///
  /// [status] Limit result set to webhooks assigned a specific status. Options: all, active, paused and disabled. Default is all.
  ///
  /// [useFaker] When true, returns fake data for testing purposes
  Future<List<WooWebhook>> getWebhooks({
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
    WooWebhookStatus? status,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return List.generate(perPage, (index) => WooWebhook.fake());
    }

    final response = await dio.get(
      _WebhookEndpoints.webhooks,
      queryParameters: _resolveQueryParameters(
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
        status: status,
      ),
    );

    return (response.data as List).map((e) => WooWebhook.fromJson(e)).toList();
  }

  Map<String, dynamic> _resolveQueryParameters({
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
    required WooWebhookStatus? status,
  }) {
    final map = <String, dynamic>{
      'context': context.name,
      'page': page,
      'per_page': perPage,
      'order': order.name,
      'orderby': orderBy.name,
      'status': status?.name ?? 'all',
    };

    if (search != null) map['search'] = search;
    if (after != null) map['after'] = after.toIso8601String();
    if (before != null) map['before'] = before.toIso8601String();
    if (exclude != null) map['exclude'] = exclude.join(',');
    if (include != null) map['include'] = include.join(',');
    if (offset != null) map['offset'] = offset;

    return map;
  }

  Future<WooWebhook> getWebhook(int id, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooWebhook.fake();
    }

    final response = await dio.get(_WebhookEndpoints.singleWebhook(id));
    return WooWebhook.fromJson(response.data);
  }

  Future<WooWebhook> createWebhook(WooWebhook webhook, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return webhook;
    }

    final response = await dio.post(
      _WebhookEndpoints.webhooks,
      data: webhook.toJson(),
    );
    return WooWebhook.fromJson(response.data);
  }

  Future<WooWebhook> updateWebhook(WooWebhook webhook, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return webhook;
    }

    final response = await dio.put(
      _WebhookEndpoints.singleWebhook(webhook.id!),
      data: webhook.toJson(),
    );
    return WooWebhook.fromJson(response.data);
  }

  Future<bool> deleteWebhook(int id,
      {bool force = false, bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return true;
    }

    await dio.delete(
      _WebhookEndpoints.singleWebhook(id),
      queryParameters: {'force': force},
    );
    return true;
  }
}
