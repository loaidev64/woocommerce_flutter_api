import 'package:faker/faker.dart';

enum WooNotificationObjectType {
  order;

  static WooNotificationObjectType fake() {
    return values[Faker().randomGenerator.integer(values.length - 1)];
  }

  static WooNotificationObjectType fromString(String type) {
    if (type == 'order') {
      return WooNotificationObjectType.order;
    }
    return WooNotificationObjectType.order;
  }
}
