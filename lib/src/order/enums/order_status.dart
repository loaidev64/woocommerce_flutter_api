import 'package:faker/faker.dart';

/// WooCommerce Order Status Enumeration
///
/// Defines the different statuses that an order can have in WooCommerce.
/// Each status represents a stage in the order fulfillment process.
///
/// ## Usage Examples
///
/// ```dart
/// // Create an order with specific status
/// final order = WooOrder(
///   id: 123,
///   status: WooOrderStatus.pending,
///   total: 99.99,
/// );
///
/// // Check order status
/// if (order.status == WooOrderStatus.completed) {
///   print('Order has been fulfilled');
/// }
///
/// // Update order status
/// order.status = WooOrderStatus.processing;
/// await wooCommerce.updateOrder(order);
/// ```
enum WooOrderStatus {
  /// Any status (used for filtering)
  ///
  /// This value is used in API queries to retrieve orders
  /// regardless of their current status.
  any,

  /// Order is created but payment is pending
  ///
  /// The order has been placed but payment has not yet been
  /// confirmed or processed.
  pending,

  /// Payment is confirmed and order is being prepared
  ///
  /// The order has been paid and is being prepared for
  /// fulfillment or shipping.
  processing,

  /// Order is temporarily paused
  ///
  /// The order is on hold, typically awaiting payment
  /// confirmation or other administrative action.
  onHold,

  /// Order has been fulfilled and delivered
  ///
  /// The order has been completed and delivered to the customer.
  /// This is the final successful status.
  completed,

  /// Order has been cancelled
  ///
  /// The order was cancelled before completion, either by
  /// the customer or an administrator.
  cancelled,

  /// Order has been refunded
  ///
  /// The order was completed but has since been refunded
  /// to the customer.
  refunded,

  /// Payment failed
  ///
  /// The order could not be completed due to a payment failure.
  failed,

  /// Order has been deleted
  ///
  /// The order has been moved to trash and is no longer
  /// accessible through normal operations.
  trash;

  /// Creates a fake WooOrderStatus instance for testing purposes
  ///
  /// This method generates a random order status from the available options,
  /// making it useful for testing and development.
  ///
  /// ## Returns
  ///
  /// A `WooOrderStatus` instance with randomly selected status.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final fakeStatus = WooOrderStatus.fake();
  /// ```
  static WooOrderStatus fake() {
    return values[Faker().randomGenerator.integer(values.length - 1)];
  }

  /// Creates a WooOrderStatus instance from a string value
  ///
  /// This method converts string status values from API responses into
  /// the appropriate enum value.
  ///
  /// ## Parameters
  ///
  /// * [type] - String value representing the order status (e.g., 'pending', 'completed')
  ///
  /// ## Returns
  ///
  /// A `WooOrderStatus` instance corresponding to the string value.
  /// Returns `pending` if the string doesn't match any known statuses.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final status = WooOrderStatus.fromString('completed');
  /// final pendingStatus = WooOrderStatus.fromString('pending');
  /// ```
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
