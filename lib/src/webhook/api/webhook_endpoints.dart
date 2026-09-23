part of 'webhook_api.dart';

abstract class _WebhookEndpoints {
  static String get webhooks => '/webhooks';
  static String singleWebhook(int id) => '/webhooks/$id';

  static String batchWebhooks() => '/webhooks/batch';

  static String webhookDeliveries(int webhookId) =>
      '/webhooks/$webhookId/deliveries';

  static String singleWebhookDelivery(int webhookId, int deliveryId) =>
      '/webhooks/$webhookId/deliveries/$deliveryId';
}
