import 'coupon.dart';

/// WooCommerce Coupon Batch Response Model
///
/// This class represents the response from a batch coupon operation. It contains
/// the results of create, update, and delete operations performed in a single
/// batch request.
///
/// ## Key Features
///
/// - **Create Results**: List of successfully created coupons with server-assigned IDs
/// - **Update Results**: List of successfully updated coupons
/// - **Delete Results**: List of successfully deleted coupons
/// - **Comprehensive Response**: All operations results in a single response object
///
/// ## Usage Examples
///
/// ### Processing Batch Response
///
/// ```dart
/// final response = await wooCommerce.batchUpdateCoupons(batchRequest);
///
/// // Process created coupons
/// for (final coupon in response.create ?? []) {
///   print('Created coupon: ${coupon.code} with ID: ${coupon.id}');
/// }
///
/// // Process updated coupons
/// for (final coupon in response.update ?? []) {
///   print('Updated coupon: ${coupon.code}');
/// }
///
/// // Process deleted coupons
/// for (final coupon in response.delete ?? []) {
///   print('Deleted coupon: ${coupon.code}');
/// }
/// ```
///
/// ### Checking Batch Results
///
/// ```dart
/// final response = await wooCommerce.batchUpdateCoupons(batchRequest);
///
/// final createdCount = response.create?.length ?? 0;
/// final updatedCount = response.update?.length ?? 0;
/// final deletedCount = response.delete?.length ?? 0;
///
/// print('Batch operation completed:');
/// print('  Created: $createdCount');
/// print('  Updated: $updatedCount');
/// print('  Deleted: $deletedCount');
/// ```
///
/// ## JSON Serialization
///
/// The class supports full JSON serialization for API communication:
///
/// ```dart
/// // Create from JSON response
/// final batchResponse = WooCouponBatchResponse.fromJson(jsonData);
///
/// // Convert to JSON if needed
/// final json = batchResponse.toJson();
/// ```
class WooCouponBatchResponse {
  /// List of created coupons
  ///
  /// Contains the coupons that were successfully created, each with a
  /// server-assigned ID and all other properties as returned by the API.
  final List<WooCoupon>? create;

  /// List of updated coupons
  ///
  /// Contains the coupons that were successfully updated, reflecting
  /// the current state after the update operation.
  final List<WooCoupon>? update;

  /// List of deleted coupons
  ///
  /// Contains the coupons that were successfully deleted. These coupons
  /// may have limited information depending on the API response.
  final List<WooCoupon>? delete;

  /// Creates a new WooCouponBatchResponse instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional. The API may return any combination
  /// of create, update, and delete results based on the request.
  ///
  /// ## Optional Parameters
  ///
  /// * [create] - List of created `WooCoupon` objects
  /// * [update] - List of updated `WooCoupon` objects
  /// * [delete] - List of deleted `WooCoupon` objects
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchResponse = WooCouponBatchResponse(
  ///   create: [createdCoupon1, createdCoupon2],
  ///   update: [updatedCoupon1],
  ///   delete: [deletedCoupon1],
  /// );
  /// ```
  WooCouponBatchResponse({
    this.create,
    this.update,
    this.delete,
  });

  /// Creates a WooCouponBatchResponse instance from JSON data
  ///
  /// This factory constructor is used to deserialize batch response data
  /// received from the WooCommerce REST API.
  ///
  /// ## Parameters
  ///
  /// * [json] - A Map containing the batch response data in JSON format
  ///
  /// ## Returns
  ///
  /// A `WooCouponBatchResponse` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchResponse = WooCouponBatchResponse.fromJson(jsonData);
  /// ```
  factory WooCouponBatchResponse.fromJson(Map<String, dynamic> json) =>
      WooCouponBatchResponse(
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
            ? (json['delete'] as List)
                .map((item) => WooCoupon.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
      );

  /// Converts the WooCouponBatchResponse instance to JSON format
  ///
  /// This method serializes the batch response data into a Map.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the batch response data in JSON format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final jsonData = batchResponse.toJson();
  /// ```
  Map<String, dynamic> toJson() => {
        if (create != null)
          'create': create!.map((coupon) => coupon.toJson()).toList(),
        if (update != null)
          'update': update!.map((coupon) => coupon.toJson()).toList(),
        if (delete != null)
          'delete': delete!.map((coupon) => coupon.toJson()).toList(),
      };

  /// Returns a string representation of the WooCouponBatchResponse instance
  ///
  /// This method provides a human-readable representation of the batch response,
  /// displaying the counts of create, update, and delete results.
  ///
  /// ## Returns
  ///
  /// A `String` containing the batch response's result counts in a readable format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchResponse = WooCouponBatchResponse(
  ///   create: [coupon1, coupon2],
  ///   update: [coupon3],
  ///   delete: [coupon4, coupon5],
  /// );
  /// print(batchResponse.toString());
  /// // Output: WooCouponBatchResponse(create: 2, update: 1, delete: 2)
  /// ```
  @override
  String toString() {
    return 'WooCouponBatchResponse(create: ${create?.length ?? 0}, update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
  }
}
