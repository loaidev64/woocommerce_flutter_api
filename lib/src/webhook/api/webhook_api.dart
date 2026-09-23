import '../../base/enums/context.dart';
import '../../base/enums/sort.dart';
import '../../base/models/woo_delete_result.dart';
import '../../exceptions/woocommerce_exception.dart';
import '../../json/woo_json.dart';
import '../../pagination/woo_page.dart';
import '../../woocommerce_flutter_api_base.dart';
import '../enums/webhook_status.dart';
import '../models/webhook.dart';
import '../models/webhook_batch_request.dart';
import '../models/webhook_batch_response.dart';
import '../models/webhook_delivery.dart';
import 'webhook_query.dart';
part 'webhook_endpoints.dart';

extension WooWebhookApi on WooCommerce {
  Future<WooPage<WooWebhook>> getWebhooks({
    WooContext context = WooContext.view,
    int? page,
    int? perPage,
    String? search,
    DateTime? after,
    DateTime? before,
    List<int>? exclude,
    List<int>? include,
    int? offset,
    WooSort order = WooSort.desc,
    WooOrderBy orderBy = WooOrderBy.date,
    WooWebhookStatus? status,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooPage(
        items: List.generate(perPage ?? 10, (_) => WooWebhook.fake()),
        page: page ?? 1,
      );
    }
    final query = WooWebhookQuery(
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
    );
    final response = await requestGet<List<dynamic>>(
      _WebhookEndpoints.webhooks,
      queryParameters: query.toMap(),
    );
    final items = response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooWebhook.fromJson)
            .toList() ??
        const [];
    return WooPage.parse(response: response, items: items, page: page ?? 1);
  }

  Future<WooWebhook> getWebhook(int id, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooWebhook.fake();
    }
    final response = await requestGet<Map<String, dynamic>>(
      _WebhookEndpoints.singleWebhook(id),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected a webhook object for webhook $id',
        statusCode: response.statusCode,
        path: _WebhookEndpoints.singleWebhook(id),
      );
    }
    return WooWebhook.fromJson(data);
  }

  Future<WooWebhook> createWebhook(WooWebhook webhook, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return webhook;
    }
    final response = await requestPost<Map<String, dynamic>>(
      _WebhookEndpoints.webhooks,
      data: webhook.toJson(),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected a webhook object in the create response',
        statusCode: response.statusCode,
        path: _WebhookEndpoints.webhooks,
      );
    }
    return WooWebhook.fromJson(data);
  }

  Future<WooWebhook> updateWebhook(
    int id,
    WooWebhook webhook, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return webhook;
    }
    final response = await requestPut<Map<String, dynamic>>(
      _WebhookEndpoints.singleWebhook(id),
      data: webhook.toJson(),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected a webhook object in the update response',
        statusCode: response.statusCode,
        path: _WebhookEndpoints.singleWebhook(id),
      );
    }
    return WooWebhook.fromJson(data);
  }

  Future<WooDeleteResult> deleteWebhook(
    int id, {
    bool force = false,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooDeleteResult(id: id, deleted: true);
    }
    final response = await requestDelete<Map<String, dynamic>>(
      _WebhookEndpoints.singleWebhook(id),
      queryParameters: {'force': force},
    );
    return WooDeleteResult.fromJson(response.data!);
  }

  Future<WooWebhookBatchResponse> batchUpdateWebhooks(
    WooWebhookBatchRequest request, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooWebhookBatchResponse(
        create: request.create?.map((webhook) => WooWebhook.fake()).toList(),
        update: request.update,
        delete: request.delete?.map((id) => WooWebhook.fake()).toList(),
      );
    }
    final response = await requestPost<Map<String, dynamic>>(
      _WebhookEndpoints.batchWebhooks(),
      data: request.toJson(),
    );
    return WooWebhookBatchResponse.fromJson(response.data!);
  }

  Future<WooPage<WooWebhookDelivery>> getWebhookDeliveries(
    int webhookId, {
    int? page,
    int? perPage,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooPage(
        items: List.generate(perPage ?? 10, (_) => WooWebhookDelivery.fake()),
        page: page ?? 1,
      );
    }
    final response = await requestGet<List<dynamic>>(
      _WebhookEndpoints.webhookDeliveries(webhookId),
      queryParameters: <String, dynamic>{}
        ..putIfPresent('page', page)
        ..putIfPresent('per_page', perPage),
    );
    final items = response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooWebhookDelivery.fromJson)
            .toList() ??
        const [];
    return WooPage.parse(response: response, items: items, page: page ?? 1);
  }

  Future<WooDeleteResult> deleteWebhookDelivery(
    int webhookId,
    int deliveryId, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooDeleteResult(id: deliveryId, deleted: true);
    }
    final response = await requestDelete<Map<String, dynamic>>(
      _WebhookEndpoints.singleWebhookDelivery(webhookId, deliveryId),
    );
    return WooDeleteResult.fromJson(response.data!);
  }
}
