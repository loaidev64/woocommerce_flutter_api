import 'product_review.dart';

/// WooCommerce Product Review Batch Response Model
///
/// This class represents the response from a batch product review operation. It contains
/// the results of create, update, and delete operations performed in a single
/// batch request.
///
/// ## Key Features
///
/// - **Create Results**: List of successfully created reviews with server-assigned IDs
/// - **Update Results**: List of successfully updated reviews
/// - **Delete Results**: List of successfully deleted reviews
/// - **Comprehensive Response**: All operations results in a single response object
///
/// ## Usage Examples
///
/// ### Processing Batch Response
///
/// ```dart
/// final response = await wooCommerce.batchUpdateProductReviews(batchRequest);
///
/// // Process created reviews
/// for (final review in response.create ?? []) {
///   print('Created review: ${review.reviewer} with ID: ${review.id}');
///   print('Status: ${review.status}');
/// }
///
/// // Process updated reviews
/// for (final review in response.update ?? []) {
///   print('Updated review: ${review.reviewer}');
///   print('New status: ${review.status}');
/// }
///
/// // Process deleted reviews
/// for (final review in response.delete ?? []) {
///   print('Deleted review: ${review.reviewer}');
/// }
/// ```
///
/// ### Checking Batch Results
///
/// ```dart
/// final response = await wooCommerce.batchUpdateProductReviews(batchRequest);
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
/// ### Handling Review Status Changes
///
/// ```dart
/// final response = await wooCommerce.batchUpdateProductReviews(batchRequest);
///
/// // Check which reviews were approved
/// final approvedReviews = response.update
///     ?.where((review) => review.status == WooProductReviewStatus.approved)
///     .toList() ?? [];
///
/// print('Approved ${approvedReviews.length} reviews');
/// ```
///
/// ## JSON Serialization
///
/// The class supports full JSON serialization for API communication:
///
/// ```dart
/// // Create from JSON response
/// final batchResponse = WooProductReviewBatchResponse.fromJson(jsonData);
///
/// // Convert to JSON if needed
/// final json = batchResponse.toJson();
/// ```
class WooProductReviewBatchResponse {

  /// Creates a new WooProductReviewBatchResponse instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional. The API may return any combination
  /// of create, update, and delete results based on the request.
  ///
  /// ## Optional Parameters
  ///
  /// * [create] - List of created `WooProductReview` objects
  /// * [update] - List of updated `WooProductReview` objects
  /// * [delete] - List of deleted `WooProductReview` objects
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchResponse = WooProductReviewBatchResponse(
  ///   create: [createdReview1, createdReview2],
  ///   update: [updatedReview1],
  ///   delete: [deletedReview1],
  /// );
  /// ```
  WooProductReviewBatchResponse({
    this.create,
    this.update,
    this.delete,
  });

  /// Creates a WooProductReviewBatchResponse instance from JSON data
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
  /// A `WooProductReviewBatchResponse` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchResponse = WooProductReviewBatchResponse.fromJson(jsonData);
  /// ```
  factory WooProductReviewBatchResponse.fromJson(Map<String, dynamic> json) =>
      WooProductReviewBatchResponse(
        create: json['create'] != null
            ? (json['create'] as List)
                .map((item) =>
                    WooProductReview.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
        update: json['update'] != null
            ? (json['update'] as List)
                .map((item) =>
                    WooProductReview.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
        delete: json['delete'] != null
            ? (json['delete'] as List)
                .map((item) =>
                    WooProductReview.fromJson(item as Map<String, dynamic>))
                .toList()
            : null,
      );
  /// List of created reviews
  ///
  /// Contains the reviews that were successfully created, each with a
  /// server-assigned ID and all other properties as returned by the API.
  final List<WooProductReview>? create;

  /// List of updated reviews
  ///
  /// Contains the reviews that were successfully updated, reflecting
  /// the current state after the update operation, including any status changes.
  final List<WooProductReview>? update;

  /// List of deleted reviews
  ///
  /// Contains the reviews that were successfully deleted. These reviews
  /// may have limited information depending on the API response.
  final List<WooProductReview>? delete;

  /// Converts the WooProductReviewBatchResponse instance to JSON format
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
          'create': create!.map((review) => review.toJson()).toList(),
        if (update != null)
          'update': update!.map((review) => review.toJson()).toList(),
        if (delete != null)
          'delete': delete!.map((review) => review.toJson()).toList(),
      };

  /// Returns a string representation of the WooProductReviewBatchResponse instance
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
  /// final batchResponse = WooProductReviewBatchResponse(
  ///   create: [review1, review2],
  ///   update: [review3],
  ///   delete: [review4, review5],
  /// );
  /// print(batchResponse.toString());
  /// // Output: WooProductReviewBatchResponse(create: 2, update: 1, delete: 2)
  /// ```
  @override
  String toString() {
    return 'WooProductReviewBatchResponse(create: ${create?.length ?? 0}, update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
  }
}

