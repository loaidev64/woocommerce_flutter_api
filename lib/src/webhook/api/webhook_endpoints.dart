part of 'webhook_api.dart';

abstract class _WebhookEndpoints {
  static String get webhooks => '/webhooks';
  static String singleWebhook(int id) => '/webhooks/$id';
}