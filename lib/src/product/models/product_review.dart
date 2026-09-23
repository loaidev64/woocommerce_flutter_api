import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';
import '../enums/product_review_status.dart';

class WooProductReview {
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
  factory WooProductReview.fromJson(Map<String, dynamic> json) =>
      WooProductReview(
        id: WooJson.readInt(json, 'id'),
        dateCreated: WooJson.readDate(json, 'date_created'),
        dateCreatedGmt: WooJson.readDate(json, 'date_created_gmt'),
        productId: WooJson.readInt(json, 'product_id'),
        status: WooJson.readEnum(
              json,
              'status',
              WooProductReviewStatus.values,
            ) ??
            WooProductReviewStatus.approved,
        reviewer: WooJson.readString(json, 'reviewer'),
        reviewerEmail: WooJson.readString(json, 'reviewer_email'),
        review: WooJson.readString(json, 'review'),
        rating: WooJson.readInt(json, 'rating'),
        verified: WooJson.readBool(json, 'verified'),
      );
  factory WooProductReview.fake({int? id}) => WooProductReview(
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
  final int? id;
  final DateTime? dateCreated;
  final DateTime? dateCreatedGmt;
  final int? productId;
  final WooProductReviewStatus? status;
  final String? reviewer;
  final String? reviewerEmail;
  final String? review;
  final int? rating;
  final bool? verified;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putDate('date_created', dateCreated)
    ..putDate('date_created_gmt', dateCreatedGmt)
    ..putIfPresent('product_id', productId)
    ..putEnum('status', status)
    ..putIfPresent('reviewer', reviewer)
    ..putIfPresent('reviewer_email', reviewerEmail)
    ..putIfPresent('review', review)
    ..putIfPresent('rating', rating)
    ..putIfPresent('verified', verified);
  WooProductReview copyWith({
    int? id,
    DateTime? dateCreated,
    DateTime? dateCreatedGmt,
    int? productId,
    WooProductReviewStatus? status,
    String? reviewer,
    String? reviewerEmail,
    String? review,
    int? rating,
    bool? verified,
  }) =>
      WooProductReview(
        id: id ?? this.id,
        dateCreated: dateCreated ?? this.dateCreated,
        dateCreatedGmt: dateCreatedGmt ?? this.dateCreatedGmt,
        productId: productId ?? this.productId,
        status: status ?? this.status,
        reviewer: reviewer ?? this.reviewer,
        reviewerEmail: reviewerEmail ?? this.reviewerEmail,
        review: review ?? this.review,
        rating: rating ?? this.rating,
        verified: verified ?? this.verified,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductReview &&
          other.id == id &&
          other.dateCreated == dateCreated &&
          other.dateCreatedGmt == dateCreatedGmt &&
          other.productId == productId &&
          other.status == status &&
          other.reviewer == reviewer &&
          other.reviewerEmail == reviewerEmail &&
          other.review == review &&
          other.rating == rating &&
          other.verified == verified;
  @override
  int get hashCode => Object.hashAll([
        id,
        dateCreated,
        dateCreatedGmt,
        productId,
        status,
        reviewer,
        reviewerEmail,
        review,
        rating,
        verified,
      ]);
  @override
  String toString() =>
      'WooProductReview(id: $id, productId: $productId, status: $status, '
      'rating: $rating, reviewer: $reviewer)';
}
