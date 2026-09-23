import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';
import '../enums/object_type.dart';

class WooNotification {
  WooNotification({
    this.id,
    this.title,
    this.body,
    this.objectId,
    this.objectType,
    this.isRead,
    this.createdAt,
  });
  factory WooNotification.fromJson(Map<String, dynamic> json) =>
      WooNotification(
        id: WooJson.readInt(json, 'id'),
        title: WooJson.readString(json, 'title'),
        body: WooJson.readString(json, 'body'),
        objectId: WooJson.readInt(json, 'object_id'),
        objectType: WooJson.readEnum(
          json,
          'object_type',
          WooNotificationObjectType.values,
        ),
        isRead: WooJson.readBool(json, 'is_read'),
        createdAt: WooJson.readDate(json, 'created_at'),
      );
  factory WooNotification.fake() => WooNotification(
        id: FakeHelper.integer(),
        title: FakeHelper.word(),
        body: FakeHelper.sentence(),
        objectId: FakeHelper.integer(),
        objectType: WooNotificationObjectType.fake(),
        isRead: FakeHelper.boolean(),
        createdAt: FakeHelper.datetime(),
      );
  final int? id;
  final String? title;
  final String? body;
  final int? objectId;
  final WooNotificationObjectType? objectType;
  final bool? isRead;
  final DateTime? createdAt;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putIfPresent('title', title)
    ..putIfPresent('body', body)
    ..putIfPresent('object_id', objectId)
    ..putEnum('object_type', objectType)
    ..putIfPresent('is_read', isRead)
    ..putDate('created_at', createdAt);
  WooNotification copyWith({
    int? id,
    String? title,
    String? body,
    int? objectId,
    WooNotificationObjectType? objectType,
    bool? isRead,
    DateTime? createdAt,
  }) =>
      WooNotification(
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
        objectId: objectId ?? this.objectId,
        objectType: objectType ?? this.objectType,
        isRead: isRead ?? this.isRead,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooNotification &&
          other.id == id &&
          other.title == title &&
          other.body == body &&
          other.objectId == objectId &&
          other.objectType == objectType &&
          other.isRead == isRead &&
          other.createdAt == createdAt;
  @override
  int get hashCode => Object.hashAll([
        id,
        title,
        body,
        objectId,
        objectType,
        isRead,
        createdAt,
      ]);
  @override
  String toString() => 'WooNotification(id: $id, title: $title)';
}
