import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

/// Represents a product review with rating and metadata.
///
/// Brief description of the model's purpose and usage for product reviews.
class WooProductReview {
  /// Unique identifier for the resource. Read-only.
  int? id;

  /// The date the review was created, in the site's timezone. Read-only.
  DateTime? dateCreated;

  /// The date the review was created, as GMT. Read-only.
  DateTime? dateCreatedGmt;

  /// Unique identifier for the product that the review belongs to.
  int? productId;

  /// Status of the review. Options: approved, hold, spam, unspam, trash, and untrash. Defaults to approved.
  WooProductReviewStatus? status;

  /// Reviewer name.
  String? reviewer;

  /// Reviewer email.
  String? reviewerEmail;

  /// The content of the review.
  String? review;

  /// Review rating (0 to 5).
  int? rating;

  /// Shows if the reviewer bought the product or not.
  bool? verified;

  /// Creates a new WooProductReview instance.
  WooProductReview({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.productId,
    this.status = WooProductReviewStatus.approved,
    this.reviewer,
    this.reviewerEmail,
    this.review,
    this.rating,
    this.verified,
  });

  /// Creates a WooProductReview instance from JSON data.
  WooProductReview.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dateCreated = DateTime.tryParse(json['date_created']),
        dateCreatedGmt = DateTime.tryParse(json['date_created_gmt']),
        productId = json['product_id'],
        status = WooProductReviewStatus.fromApi(json['status']),
        reviewer = json['reviewer'],
        reviewerEmail = json['reviewer_email'],
        review = json['review'],
        rating = json['rating'],
        verified = json['verified'];

  /// Converts the WooProductReview instance to JSON format.
  Map<String, dynamic> toJson() => {
        'id': id,
        'date_created': dateCreated?.toIso8601String(),
        'date_created_gmt': dateCreatedGmt?.toIso8601String(),
        'product_id': productId,
        'status': status?.name,
        'reviewer': reviewer,
        'reviewer_email': reviewerEmail,
        'review': review,
        'rating': rating,
        'verified': verified,
      };

  @override
  String toString() => toJson().toString();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WooProductReview && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  /// Creates a fake WooProductReview instance for testing purposes.
  factory WooProductReview.fake([int? id]) => WooProductReview(
        id: id ?? FakeHelper.integer(),
        dateCreated: FakeHelper.datetime(),
        dateCreatedGmt: FakeHelper.datetime(),
        productId: FakeHelper.integer(),
        status: WooProductReviewStatus.fake(),
        reviewer: FakeHelper.firstName(),
        reviewerEmail: FakeHelper.email(),
        review: FakeHelper.sentence(),
        rating: FakeHelper.integer(min: 0, max: 5),
        verified: FakeHelper.boolean(),
      );
}
