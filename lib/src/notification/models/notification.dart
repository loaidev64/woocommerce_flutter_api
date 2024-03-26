// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';
import 'package:woocommerce_flutter_api/src/notification/enums/object_type.dart';

class WooNotification {
  /// Notification id.
  final int? id;

  /// Notification title.
  final String? title;

  /// Notification body.
  final String? body;

  /// Notification object id for now it's always an order id.
  final int? objectId;

  /// Notification object type for now it's always an order.
  final WooNotificationObjectType? objectType;

  /// If notification is read or not by defualt is false.
  final bool? isRead;

  /// The date the notification was created.
  final DateTime? createdAt;

  const WooNotification({
    this.id,
    this.title,
    this.body,
    this.objectId,
    this.objectType,
    this.isRead,
    this.createdAt,
  });

  factory WooNotification.fromJson(Map<String, dynamic> map) {
    return WooNotification(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      body: map['body'] != null ? map['body'] as String : null,
      objectId: map['object_id'] != null ? map['object_id'] as int : null,
      objectType: map['object_type'] != null
          ? WooNotificationObjectType.fromString(map['object_type'])
          : null,
      isRead: map['is_read'] != null ? map['is_read'] as bool : null,
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
    );
  }

  factory WooNotification.fake() => WooNotification(
        id: FakeHelper.integer(),
        title: FakeHelper.word(),
        body: FakeHelper.sentence(),
        objectId: FakeHelper.integer(),
        objectType: WooNotificationObjectType.fake(),
        isRead: FakeHelper.boolean(),
        createdAt: FakeHelper.datetime(),
      );
}
