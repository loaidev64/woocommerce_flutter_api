import 'product_review.dart';

/// WooCommerce Product Review Batch Request Model
///
/// This class represents a batch request for creating, updating, and deleting
/// multiple product reviews in a single API call. It allows you to perform bulk operations
/// efficiently without making multiple individual requests.
///
/// ## Key Features
///
/// - **Bulk Creation**: Create multiple reviews in a single request
/// - **Bulk Updates**: Update multiple existing reviews simultaneously
/// - **Bulk Deletion**: Delete multiple reviews at once
/// - **Flexible Operations**: Mix create, update, and delete operations in one request
/// - **Status Management**: Control review approval status (approved, hold, spam, trash)
///
/// ## Usage Examples
///
/// ### Creating a Batch Request
///
/// ```dart
/// final batchRequest = WooProductReviewBatchRequest(
///   create: [
///     WooProductReview(
///       productId: 123,
///       reviewer: 'John Doe',
///       reviewerEmail: 'john@example.com',
///       review: 'Great product! Highly recommended.',
///       rating: 5,
///       status: WooProductReviewStatus.approved,
///     ),
///     WooProductReview(
///       productId: 456,
///       reviewer: 'Jane Smith',
///       reviewerEmail: 'jane@example.com',
///       review: 'Good quality, fast shipping.',
///       rating: 4,
///       status: WooProductReviewStatus.hold,
///     ),
///   ],
///   update: [
///     WooProductReview(
///       id: 789,
///       status: WooProductReviewStatus.approved,
///       review: 'Updated review text',
///     ),
///   ],
///   delete: [101, 102],
/// );
/// ```
///
/// ### Working with Batch Requests
///
/// ```dart
/// // Create a batch request with only creates
/// final createOnly = WooProductReviewBatchRequest(
///   create: [review1, review2, review3],
/// );
///
/// // Create a batch request with only updates (e.g., approve pending reviews)
/// final updateOnly = WooProductReviewBatchRequest(
///   update: pendingReviews.map((review) => WooProductReview(
///     id: review.id,
///     status: WooProductReviewStatus.approved,
///   )).toList(),
/// );
///
/// // Create a batch request with only deletes
/// final deleteOnly = WooProductReviewBatchRequest(
///   delete: [101, 102, 103],
/// );
/// ```
///
/// ## Review Status Management
///
/// When creating or updating reviews, you can control their status:
///
/// - `WooProductReviewStatus.approved` - Review is visible to customers
/// - `WooProductReviewStatus.hold` - Review is pending moderation
/// - `WooProductReviewStatus.spam` - Mark review as spam
/// - `WooProductReviewStatus.trash` - Move review to trash
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
/// final batchRequest = WooProductReviewBatchRequest.fromJson(jsonData);
/// ```
class WooProductReviewBatchRequest {

  /// Creates a new WooProductReviewBatchRequest instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional. You can provide any combination of
  /// create, update, and delete operations.
  ///
  /// ## Optional Parameters
  ///
  /// * [create] - List of `WooProductReview` objects to create
  /// * [update] - List of `WooProductReview` objects to update (must include `id`)
  /// * [delete] - List of review IDs (integers) to delete
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchRequest = WooProductReviewBatchRequest(
  ///   create: [
  ///     WooProductReview(
  ///       productId: 123,
  ///       reviewer: 'John Doe',
  ///       reviewerEmail: 'john@example.com',
  ///       review: 'Great product!',
  ///       rating: 5,
  ///       status: WooProductReviewStatus.approved,
  ///     ),
  ///   ],
  ///   update: [
  ///     WooProductReview(
  ///       id: 789,
  ///       status: WooProductReviewStatus.approved,
  ///     ),
  ///   ],
  ///   delete: [456],
  /// );
  /// ```
  WooProductReviewBatchRequest({
    this.create,
    this.update,
    this.delete,
  });

  /// Creates a WooProductReviewBatchRequest instance from JSON data
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
  /// A `WooProductReviewBatchRequest` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final batchRequest = WooProductReviewBatchRequest.fromJson(jsonData);
  /// ```
  factory WooProductReviewBatchRequest.fromJson(Map<String, dynamic> json) =>
      WooProductReviewBatchRequest(
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
            ? (json['delete'] as List).cast<int>()
            : null,
      );
  /// List of reviews to create
  ///
  /// Each review in this list will be created as a new review in the store.
  /// Reviews in this list should not have an ID assigned.
  final List<WooProductReview>? create;

  /// List of reviews to update
  ///
  /// Each review in this list must have a valid ID and will be updated
  /// with the provided values. Common use cases include:
  /// - Approving pending reviews (changing status from hold to approved)
  /// - Updating review content or ratings
  /// - Changing review status (spam, trash, etc.)
  final List<WooProductReview>? update;

  /// List of review IDs to delete
  ///
  /// Each ID in this list represents a review that will be permanently deleted from the store.
  final List<int>? delete;

  /// Converts the WooProductReviewBatchRequest instance to JSON format
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
          'create': create!.map((review) => review.toJson()).toList(),
        if (update != null)
          'update': update!.map((review) => review.toJson()).toList(),
        if (delete != null) 'delete': delete,
      };

  /// Returns a string representation of the WooProductReviewBatchRequest instance
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
  /// final batchRequest = WooProductReviewBatchRequest(
  ///   create: [review1, review2],
  ///   update: [review3],
  ///   delete: [101, 102],
  /// );
  /// print(batchRequest.toString());
  /// // Output: WooProductReviewBatchRequest(create: 2, update: 1, delete: 2)
  /// ```
  @override
  String toString() {
    return 'WooProductReviewBatchRequest(create: ${create?.length ?? 0}, update: ${update?.length ?? 0}, delete: ${delete?.length ?? 0})';
  }
}

