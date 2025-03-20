import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';
import '../enums/webhook_status.dart';
import '../enums/webhook_topic.dart';

class WooWebhook {
  final int? id;
  final String? name;
  final WooWebhookStatus? status;
  final String? topic;
  final String? resource;
  final String? event;
  final List<String>? hooks;
  final String? deliveryUrl;
  final String? secret;
  final DateTime? dateCreated;
  final DateTime? dateCreatedGmt;
  final DateTime? dateModified;
  final DateTime? dateModifiedGmt;

  WooWebhook({
    this.id,
    required this.name,
    this.status = WooWebhookStatus.active,
    required this.topic,
    this.resource,
    this.event,
    this.hooks,
    required this.deliveryUrl,
    this.secret,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
  });

  factory WooWebhook.fromJson(Map<String, dynamic> json) => WooWebhook(
        id: json['id'],
        name: json['name'],
        status: WooWebhookStatus.values.firstWhere(
          (e) => e.name == json['status'],
          orElse: () => WooWebhookStatus.active,
        ),
        topic: json['topic'],
        resource: json['resource'],
        event: json['event'],
        hooks: json['hooks'] != null ? List<String>.from(json['hooks']) : null,
        deliveryUrl: json['delivery_url'],
        secret: json['secret'],
        dateCreated: DateTime.parse(json['date_created']),
        dateCreatedGmt: DateTime.parse(json['date_created_gmt']),
        dateModified: DateTime.parse(json['date_modified']),
        dateModifiedGmt: DateTime.parse(json['date_modified_gmt']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'status': status?.name,
        'topic': topic,
        'resource': resource,
        'event': event,
        'hooks': hooks,
        'delivery_url': deliveryUrl,
        'secret': secret,
        'date_created': dateCreated?.toIso8601String(),
        'date_created_gmt': dateCreatedGmt?.toIso8601String(),
        'date_modified': dateModified?.toIso8601String(),
        'date_modified_gmt': dateModifiedGmt?.toIso8601String(),
      };

  factory WooWebhook.fake() => WooWebhook(
        name: FakeHelper.sentence(),
        status: FakeHelper.randomItem(WooWebhookStatus.values),
        topic: WooWebhookTopic.randomTopic(),
        deliveryUrl: FakeHelper.url(),
        secret: FakeHelper.code(),
      );
}
