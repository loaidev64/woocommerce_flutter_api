import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'webhook_endpoints.dart';

/// WooCommerce Webhooks API Extension
///
/// This extension provides comprehensive webhook management capabilities for WooCommerce stores.
/// Webhooks allow you to receive real-time notifications when specific events occur in your store,
/// such as when orders are created, products are updated, or customers are registered.
///
/// ## Webhook Overview
///
/// Webhooks are HTTP callbacks that are triggered by specific events in your WooCommerce store.
/// They provide a way to integrate with external systems and receive real-time updates about
/// store activities without constantly polling the API.
///
/// ## Key Features
///
/// - **Event-driven notifications**: Get notified instantly when important events occur
/// - **Flexible delivery**: Configure custom URLs to receive webhook payloads
/// - **Security**: Optional secret keys for HMAC-SHA256 signature verification
/// - **Status management**: Control webhook delivery (active, paused, disabled)
/// - **Topic-based filtering**: Subscribe to specific resource events
///
/// ## Webhook Lifecycle
///
/// 1. **Creation**: Define webhook with topic, delivery URL, and optional secret
/// 2. **Activation**: Set status to 'active' to start receiving notifications
/// 3. **Delivery**: WooCommerce sends HTTP POST requests to your delivery URL
/// 4. **Verification**: Use the secret to verify webhook authenticity
/// 5. **Management**: Update, pause, or delete webhooks as needed
///
/// ## Supported Topics
///
/// - **Coupons**: `coupon.created`, `coupon.updated`, `coupon.deleted`
/// - **Customers**: `customer.created`, `customer.updated`, `customer.deleted`
/// - **Orders**: `order.created`, `order.updated`, `order.deleted`
/// - **Products**: `product.created`, `product.updated`, `product.deleted`
///
/// ## Example Usage
///
/// ```dart
/// // Get all webhooks
/// final webhooks = await wooCommerce.getWebhooks();
///
/// // Create a new webhook for order updates
/// final webhook = WooWebhook(
///   name: 'Order Updates',
///   topic: 'order.updated',
///   deliveryUrl: 'https://your-app.com/webhooks/orders',
///   secret: 'your-secret-key',
/// );
/// final createdWebhook = await wooCommerce.createWebhook(webhook);
///
/// // Update webhook status
/// webhook.status = WooWebhookStatus.paused;
/// await wooCommerce.updateWebhook(webhook);
/// ```
extension WooWebhookApi on WooCommerce {
  /// Retrieves a paginated list of webhooks from the WooCommerce store.
  ///
  /// This method allows you to fetch webhooks with various filtering and sorting options.
  /// It's particularly useful for managing multiple webhooks or monitoring webhook status.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-webhooks 
  ///
  /// ## Parameters
  ///
  /// * [context] - Scope under which the request is made; determines fields present in response.
  ///   - `WooContext.view`: Returns basic webhook information (default)
  ///   - `WooContext.edit`: Returns full webhook details including sensitive data
  ///
  /// * [page] - Current page of the collection (default: 1)
  /// * [perPage] - Maximum number of items to return (default: 10, max: 100)
  /// * [search] - Limit results to webhooks matching a search string
  /// * [after] - Limit response to webhooks created after this date
  /// * [before] - Limit response to webhooks created before this date
  /// * [exclude] - Exclude webhooks with specific IDs from results
  /// * [include] - Only include webhooks with specific IDs
  /// * [offset] - Offset the result set by a specific number of items
  /// * [order] - Sort order: `WooSortOrder.asc` or `WooSortOrder.desc` (default: desc)
  /// * [orderBy] - Sort by: `WooSortOrderBy.date`, `WooSortOrderBy.id`, or `WooSortOrderBy.title` (default: date)
  /// * [status] - Filter by webhook status: `WooWebhookStatus.active`, `WooWebhookStatus.paused`, `WooWebhookStatus.disabled`
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooWebhook>>` containing the webhook objects.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get all active webhooks
  /// final activeWebhooks = await wooCommerce.getWebhooks(
  ///   status: WooWebhookStatus.active,
  ///   perPage: 50,
  /// );
  ///
  /// // Search for webhooks containing "order"
  /// final orderWebhooks = await wooCommerce.getWebhooks(
  ///   search: 'order',
  ///   orderBy: WooSortOrderBy.date,
  ///   order: WooSortOrder.desc,
  /// );
  ///
  /// // Get webhooks created in the last 30 days
  /// final recentWebhooks = await wooCommerce.getWebhooks(
  ///   after: DateTime.now().subtract(Duration(days: 30)),
  /// );
  /// ```
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

  /// Retrieves a specific webhook by its ID.
  ///
  /// This method fetches detailed information about a single webhook, including
  /// its configuration, status, and delivery settings.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#retrieve-a-webhook 
  ///
  /// ## Parameters
  ///
  /// * [id] - The unique identifier of the webhook to retrieve
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooWebhook>` containing the webhook details.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the webhook is not found or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get a specific webhook
  /// final webhook = await wooCommerce.getWebhook(123);
  /// print('Webhook: ${webhook.name}');
  /// print('Status: ${webhook.status}');
  /// print('Topic: ${webhook.topic}');
  /// ```
  Future<WooWebhook> getWebhook(int id, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooWebhook.fake();
    }

    final response = await dio.get(_WebhookEndpoints.singleWebhook(id));
    return WooWebhook.fromJson(response.data);
  }

  /// Creates a new webhook in the WooCommerce store.
  ///
  /// This method allows you to set up automated notifications for specific events
  /// in your store. The webhook will be created with the specified configuration
  /// and can be activated immediately.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#create-a-webhook
  /// ## Parameters
  ///
  /// * [webhook] - The webhook object containing all configuration details
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooWebhook>` containing the created webhook with assigned ID.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if webhook creation fails or validation errors occur
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a webhook for order updates
  /// final webhook = WooWebhook(
  ///   name: 'Order Updates Webhook',
  ///   topic: 'order.updated',
  ///   deliveryUrl: 'https://your-app.com/webhooks/orders',
  ///   secret: 'your-secret-key',
  ///   status: WooWebhookStatus.active,
  /// );
  ///
  /// final createdWebhook = await wooCommerce.createWebhook(webhook);
  /// print('Created webhook with ID: ${createdWebhook.id}');
  /// ```
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

  /// Updates an existing webhook in the WooCommerce store.
  ///
  /// This method allows you to modify webhook configuration, including status,
  /// delivery URL, secret, and other settings. The webhook must have a valid ID.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#update-a-webhook 
  /// 
  /// ## Parameters
  ///
  /// * [webhook] - The webhook object with updated configuration
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<WooWebhook>` containing the updated webhook.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if webhook update fails or webhook not found
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Update webhook status to paused
  /// webhook.status = WooWebhookStatus.paused;
  /// final updatedWebhook = await wooCommerce.updateWebhook(webhook);
  ///
  /// // Update delivery URL
  /// webhook.deliveryUrl = 'https://new-endpoint.com/webhooks';
  /// await wooCommerce.updateWebhook(webhook);
  /// ```
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

  /// Deletes a webhook from the WooCommerce store.
  ///
  /// This method permanently removes a webhook and all its associated data.
  /// Use with caution as this action cannot be undone.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#delete-a-webhook 
  /// 
  /// ## Parameters
  ///
  /// * [id] - The unique identifier of the webhook to delete
  /// * [force] - Whether to force delete the webhook (default: false)
  ///   - `false`: Move to trash (can be restored)
  ///   - `true`: Permanently delete (cannot be restored)
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<bool>` indicating whether the deletion was successful.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if webhook deletion fails or webhook not found
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Soft delete (move to trash)
  /// await wooCommerce.deleteWebhook(123);
  ///
  /// // Force delete (permanent)
  /// await wooCommerce.deleteWebhook(123, force: true);
  /// ```
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
