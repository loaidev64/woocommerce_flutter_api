import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';
import '../enums/webhook_status.dart';
import '../enums/webhook_topic.dart';

class WooWebhook {
  WooWebhook({
    required this.name,
    required this.topic,
    required this.deliveryUrl,
    this.id,
    this.status = WooWebhookStatus.active,
    this.resource,
    this.event,
    this.hooks,
    this.secret,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
  });
  factory WooWebhook.fromJson(Map<String, dynamic> json) => WooWebhook(
        id: WooJson.readInt(json, 'id'),
        name: WooJson.readString(json, 'name'),
        status: WooJson.readEnum(json, 'status', WooWebhookStatus.values) ??
            WooWebhookStatus.active,
        topic: WooJson.readString(json, 'topic'),
        resource: WooJson.readString(json, 'resource'),
        event: WooJson.readString(json, 'event'),
        hooks: _readStringList(json, 'hooks'),
        deliveryUrl: WooJson.readString(json, 'delivery_url'),
        secret: WooJson.readString(json, 'secret'),
        dateCreated: WooJson.readDate(json, 'date_created'),
        dateCreatedGmt: WooJson.readDate(json, 'date_created_gmt'),
        dateModified: WooJson.readDate(json, 'date_modified'),
        dateModifiedGmt: WooJson.readDate(json, 'date_modified_gmt'),
      );
  factory WooWebhook.fake() => WooWebhook(
        name: FakeHelper.sentence(),
        status: WooWebhookStatus.fake(),
        topic: WooWebhookTopic.randomTopic(),
        deliveryUrl: FakeHelper.url(),
        secret: FakeHelper.code(),
      );
  static List<String>? _readStringList(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is! List) return null;
    return [
      for (final element in value)
        if (element != null) element.toString()
    ];
  }

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
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putIfPresent('name', name)
    ..putEnum('status', status)
    ..putIfPresent('topic', topic)
    ..putIfPresent('resource', resource)
    ..putIfPresent('event', event)
    ..putIfPresent('hooks', hooks)
    ..putIfPresent('delivery_url', deliveryUrl)
    ..putIfPresent('secret', secret)
    ..putDate('date_created', dateCreated)
    ..putDate('date_created_gmt', dateCreatedGmt)
    ..putDate('date_modified', dateModified)
    ..putDate('date_modified_gmt', dateModifiedGmt);
  WooWebhook copyWith({
    int? id,
    String? name,
    WooWebhookStatus? status,
    String? topic,
    String? resource,
    String? event,
    List<String>? hooks,
    String? deliveryUrl,
    String? secret,
    DateTime? dateCreated,
    DateTime? dateCreatedGmt,
    DateTime? dateModified,
    DateTime? dateModifiedGmt,
  }) =>
      WooWebhook(
        id: id ?? this.id,
        name: name ?? this.name,
        status: status ?? this.status,
        topic: topic ?? this.topic,
        resource: resource ?? this.resource,
        event: event ?? this.event,
        hooks: hooks ?? this.hooks,
        deliveryUrl: deliveryUrl ?? this.deliveryUrl,
        secret: secret ?? this.secret,
        dateCreated: dateCreated ?? this.dateCreated,
        dateCreatedGmt: dateCreatedGmt ?? this.dateCreatedGmt,
        dateModified: dateModified ?? this.dateModified,
        dateModifiedGmt: dateModifiedGmt ?? this.dateModifiedGmt,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooWebhook &&
          other.id == id &&
          other.name == name &&
          other.status == status &&
          other.topic == topic &&
          other.resource == resource &&
          other.event == event &&
          WooJson.listEquals(other.hooks, hooks) &&
          other.deliveryUrl == deliveryUrl &&
          other.secret == secret &&
          other.dateCreated == dateCreated &&
          other.dateCreatedGmt == dateCreatedGmt &&
          other.dateModified == dateModified &&
          other.dateModifiedGmt == dateModifiedGmt;
  @override
  int get hashCode => Object.hashAll([
        id,
        name,
        status,
        topic,
        resource,
        event,
        ...(hooks ?? const []),
        deliveryUrl,
        secret,
        dateCreated,
        dateCreatedGmt,
        dateModified,
        dateModifiedGmt,
      ]);
  @override
  String toString() =>
      'WooWebhook(id: $id, name: $name, topic: $topic, status: $status)';
}
