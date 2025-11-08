import 'coupon.dart';

/// WooCommerce Coupon Batch Request Model
///
/// This class represents a batch request for creating, updating, and deleting
/// multiple coupons in a single API call. It allows you to perform bulk operations
/// efficiently without making multiple individual requests.
///
/// ## Key Features
///
/// - **Bulk Creation**: Create multiple coupons in a single request
/// - **Bulk Updates**: Update multiple existing coupons simultaneously
/// - **Bulk Deletion**: Delete multiple coupons at once
/// - **Flexible Operations**: Mix create, update, and delete operations in one request
///
/// ## Usage Examples
///
/// ### Creating a Batch Request
///
/// ```dart
/// final batchRequest = WooCouponBatchRequest(
///   create: [
///     WooCoupon(
///       code: 'SAVE20',
///       discountType: 'percent',
///       amount: '20',
///     ),
///     WooCoupon(
///       code: 'FIXED10',
///       discountType: 'fixed_cart',
///       amount: '10.00',
///     ),
///   ],
///   update: [
///     existingCoupon.copyWith(amount: '25'),
///   ],
///   delete: [123, 456],
/// );
/// ```
///
/// ### Working with Batch Requests
///
/// ```dart
/// // Create a batch request with only creates
/// final createOnly = WooCouponBatchRequest(
///   create: [coupon1, coupon2, coupon3],
/// );
///
/// // Create a batch request with only updates
/// final updateOnly = WooCouponBatchRequest(
///   update: [updatedCoupon1, updatedCoupon2],
/// );
///
/// // Create a batch request with only deletes
/// final deleteOnly = WooCouponBatchRequest(
///   delete: [101, 102, 103],
/// );
/// ```
///
/// ## JSON Serialization
///
/// The class supports full JSON serialization for API communication:
///
/// ```dart
/// // Convert to JSON for API requests
/// final json = batchRequest.toJson();
///
/// // Create from JSON response
/// final batchRequest = WooCouponBatchRequest.fromJson(jsonData);
/// ```
class WooCouponBatchRequest {

  /// Creates a new WooCouponBatchRequest instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional. You can provide any combination of
  /// create, update, and delete operations.
  ///
  /// ## Optional Parameters
  ///
  /// * [create] - List of `WooCoupon` objects to create
  /// * [update] - List of `WooCoupon` objects to update (must include `id`)
  /// * [delete] - List of coupon IDs (integers) to delete
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchRequest = WooCouponBatchRequest(
  ///   create: [
  ///     WooCoupon(code: 'SAVE20', discountType: 'percent', amount: '20'),
  ///   ],
  ///   update: [
  ///     existingCoupon.copyWith(amount: '25'),
  ///   ],
  ///   delete: [123],
  /// );
  /// ```
  WooCouponBatchRequest({
    this.create,
    this.update,
    this.delete,
  });

  /// Creates a WooCouponBatchRequest instance from JSON data
  ///
  /// This factory constructor is used to deserialize batch request data
  /// received from the WooCommerce REST API.
  ///
  /// ## Parameters
  ///
  /// * [json] - A Map containing the batch request data in JSON format
  ///
  /// ## Returns
  ///
  /// A `WooCouponBatchRequest` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchRequest = WooCouponBatchRequest.fromJson(jsonData);
  /// ```
  factory WooCouponBatchRequest.fromJson(Map<String, dynamic> json) =>
      WooCouponBatchRequest(
        create: json['create'] != null
            ? (json['create'] as List)
                .map((item) => WooCoupon.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
        update: json['update'] != null
            ? (json['update'] as List)
                .map((item) => WooCoupon.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
        delete: json['delete'] != null
            ? (json['delete'] as List).cast<int>()
            : null,
      );
  /// List of coupons to create
  ///
  /// Each coupon in this list will be created as a new coupon in the store.
  /// Coupons in this list should not have an ID assigned.
  final List<WooCoupon>? create;

  /// List of coupons to update
  ///
  /// Each coupon in this list must have a valid ID and will be updated
  /// with the provided values.
  final List<WooCoupon>? update;

  /// List of coupon IDs to delete
  ///
  /// Each ID in this list represents a coupon that will be deleted from the store.
  final List<int>? delete;

  /// Converts the WooCouponBatchRequest instance to JSON format
  ///
  /// This method serializes the batch request data into a Map that can be sent
  /// to the WooCommerce REST API.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the batch request data in JSON format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final jsonData = batchRequest.toJson();
  /// ```
  Map<String, dynamic> toJson() => {
        if (create != null)
          'create': create!.map((coupon) => coupon.toJson()).toList(),
        if (update != null)
          'update': update!.map((coupon) => coupon.toJson()).toList(),
        if (delete != null) 'delete': delete,
      };

  /// Returns a string representation of the WooCouponBatchRequest instance
  ///
  /// This method provides a human-readable representation of the batch request,
  /// displaying the counts of create, update, and delete operations.
  ///
  /// ## Returns
  ///
  /// A `String` containing the batch request's operation counts in a readable format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchRequest = WooCouponBatchRequest(
  ///   create: [coupon1, coupon2],
  ///   update: [coupon3],
  ///   delete: [123, 456],
  /// );
  /// print(batchRequest.toString());
  /// // Output: WooCouponBatchRequest(create: 2, update: 1, delete: 2)
  /// ```
  @override
  String toString() {
    return 'WooCouponBatchRequest(create: ${create?.length ?? 0}, update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
  }
}
