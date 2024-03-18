import 'package:faker/faker.dart';

enum WooOrderStatus {
  any,
  pending,
  processing,
  onHold,
  completed,
  cancelled,
  refunded,
  failed,
  trash;

  static WooOrderStatus fake() {
    return values[Faker().randomGenerator.integer(values.length - 1)];
  }

  static WooOrderStatus fromString(String type) {
    if (type == 'pending') {
      return WooOrderStatus.pending;
    }

    if (type == 'processing') {
      return WooOrderStatus.processing;
    }

    if (type == 'on-hold') {
      return WooOrderStatus.onHold;
    }

    if (type == 'completed') {
      return WooOrderStatus.completed;
    }

    if (type == 'cancelled') {
      return WooOrderStatus.cancelled;
    }

    if (type == 'refunded') {
      return WooOrderStatus.refunded;
    }

    if (type == 'failed') {
      return WooOrderStatus.failed;
    }

    if (type == 'trash') {
      return WooOrderStatus.trash;
    }

    return WooOrderStatus.pending;
  }
}
