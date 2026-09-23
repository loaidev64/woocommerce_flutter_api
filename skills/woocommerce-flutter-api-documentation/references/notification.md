# notification

## notification_api

### extension WooNotificationApi on WooCommerce

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooPage<WooNotification>> getNotifications({bool? useFaker}) async

Gets all of the notifications of the logged in user

[useFaker], fakes the api request

### Future<bool> readNotifications() async

Reads all of the notifications of the logged in user

### Future<bool> storeFcm(String token) async

Stores fcm tokens

## object_type

### enum WooNotificationObjectType implements WooEnum

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### order('order'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### unknown('unknown')

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooNotificationObjectType(this.value)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String value

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static WooNotificationObjectType fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## notification

### class WooNotification

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooNotification({ this.id, this.title, this.body, this.objectId, this.objectType, this.isRead, this.createdAt, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooNotification.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooNotification.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? id

Notification id.

### final String? title

Notification title.

### final String? body

Notification body.

### final int? objectId

Notification object id for now it's always an order id.

### final WooNotificationObjectType? objectType

Notification object type for now it's always an order.

### final bool? isRead

If notification is read or not by defualt is false.

### final DateTime? createdAt

The date the notification was created.

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooNotification copyWith({ int? id, String? title, String? body, int? objectId, WooNotificationObjectType? objectType, bool? isRead, DateTime? createdAt, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

