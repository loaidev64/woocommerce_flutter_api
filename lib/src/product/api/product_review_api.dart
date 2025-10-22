import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'product_review_endpoints.dart';

/// WooCommerce Product Review API Extension
///
/// This extension provides comprehensive product review management capabilities for WooCommerce stores.
/// Product reviews allow customers to share their experiences with products, helping other customers
/// make informed purchasing decisions and providing valuable feedback to store owners.
///
/// ## Product Review Overview
///
/// Product reviews are customer-generated content that includes ratings, comments, and feedback
/// about products. They help build trust, improve SEO, and provide social proof for your products.
///
/// ## Key Features
///
/// - **Review Retrieval**: Get product reviews with extensive filtering and pagination
/// - **Review Management**: Create, update, and delete product reviews
/// - **Status Control**: Manage review approval and moderation
/// - **Advanced Filtering**: Filter by product, reviewer, status, and date
/// - **Rating System**: Support for star ratings and review scoring
///
/// ## Review Lifecycle
///
/// 1. **Submission**: Customer submits review with rating and comment
/// 2. **Moderation**: Review is held for approval (if moderation is enabled)
/// 3. **Approval**: Review is approved and becomes visible to customers
/// 4. **Display**: Review appears on product pages and in listings
///
/// ## Example Usage
///
/// ```dart
/// // Get all approved reviews
/// final reviews = await wooCommerce.getProductReviews();
///
/// // Get reviews for a specific product
/// final productReviews = await wooCommerce.getProductReviews(
///   product: [123],
///   status: WooProductReviewStatus.approved,
/// );
///
/// // Get pending reviews for moderation
/// final pendingReviews = await wooCommerce.getProductReviews(
///   status: WooProductReviewStatus.hold,
/// );
/// ```
extension WooProductReviewApi on WooCommerce {
  /// Retrieves a list of product reviews from the WooCommerce store.
  ///
  /// This method supports extensive filtering and pagination options to help you
  /// find exactly the reviews you need for moderation, display, or analysis.
  /// https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-product-reviews
  ///
  /// ## Parameters
  ///
  /// * [context] - Scope under which the request is made; determines fields present in response.
  ///   - `WooContext.view`: Returns basic review information (default)
  ///   - `WooContext.edit`: Returns full review details including sensitive data
  ///
  /// * [page] - Current page of the collection (default: 1)
  /// * [perPage] - Maximum number of items to return (default: 10, max: 100)
  /// * [search] - Limit results to reviews matching a search string
  /// * [after] - Limit response to reviews published after this date
  /// * [before] - Limit response to reviews published before this date
  /// * [exclude] - Exclude reviews with specific IDs from results
  /// * [include] - Only include reviews with specific IDs
  /// * [offset] - Offset the result set by a specific number of items
  /// * [order] - Sort order: `WooSortOrder.asc` or `WooSortOrder.desc` (default: desc)
  /// * [orderBy] - Sort by: `WooSortProductReview.date`, `WooSortProductReview.id`, etc. (default: dateGmt)
  /// * [reviewer] - Filter by reviewer user IDs
  /// * [reviewerExclude] - Exclude reviews from specific reviewer IDs
  /// * [reviewerEmail] - Filter by reviewer email addresses
  /// * [product] - Filter by product IDs
  /// * [status] - Filter by review status (default: approved)
  /// * [useFaker] - When true, returns fake data for testing purposes
  ///
  /// ## Returns
  ///
  /// A `Future<List<WooProductReview>>` containing the review objects.
  ///
  /// ## Throws
  ///
  /// * `WooCommerceException` if the request fails or access is denied
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Get all approved reviews
  /// final reviews = await wooCommerce.getProductReviews();
  ///
  /// // Get reviews for a specific product
  /// final productReviews = await wooCommerce.getProductReviews(
  ///   product: [123],
  ///   status: WooProductReviewStatus.approved,
  /// );
  ///
  /// // Get pending reviews for moderation
  /// final pendingReviews = await wooCommerce.getProductReviews(
  ///   status: WooProductReviewStatus.hold,
  /// );
  ///
  /// // Search reviews by content
  /// final searchResults = await wooCommerce.getProductReviews(
  ///   search: 'excellent',
  ///   perPage: 20,
  /// );
  /// ```
  Future<List<WooProductReview>> getProductReviews({
    WooContext context = WooContext.view,
    int page = 1,
    int perPage = 10,
    String? search,
    DateTime? after,
    DateTime? before,
    List<int>? exclude,
    List<int>? include,
    int? offset,
    WooSortOrder order = WooSortOrder.desc,
    WooSortProductReview orderBy = WooSortProductReview.dateGmt,
    List<int>? reviewer,
    List<int>? reviewerExclude,
    List<String>? reviewerEmail,
    List<int>? product,
    WooProductReviewStatus status = WooProductReviewStatus.approved,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return List.generate(perPage, (index) => WooProductReview.fake());
    }

    final response = await dio.get(
      _ProductReviewEndpoints.reviews,
      queryParameters: _resolveQueryParametersForGettingProductReviews(
        context: context,
        page: page,
        perPage: perPage,
        search: search,
        after: after,
        before: before,
        exclude: exclude,
        include: include,
        offset: offset,
        order: order,
        orderBy: orderBy,
        reviewer: reviewer,
        reviewerExclude: reviewerExclude,
        reviewerEmail: reviewerEmail,
        product: product,
        status: status,
      ),
    );

    return (response.data as List)
        .map((item) => WooProductReview.fromJson(item))
        .toList();
  }

  Map<String, dynamic> _resolveQueryParametersForGettingProductReviews({
    required WooContext context,
    required int page,
    required int perPage,
    required String? search,
    required DateTime? after,
    required DateTime? before,
    required List<int>? exclude,
    required List<int>? include,
    required int? offset,
    required WooSortOrder order,
    required WooSortProductReview orderBy,
    required List<int>? reviewer,
    required List<int>? reviewerExclude,
    required List<String>? reviewerEmail,
    required List<int>? product,
    required WooProductReviewStatus status,
  }) {
    final map = <String, dynamic>{
      'context': context.name,
      'page': page,
      'per_page': perPage,
      'order': order.name,
      'orderby': orderBy.name,
      'status': status.name,
    };

    if (search != null) {
      map['search'] = search;
    }

    if (after != null) {
      map['after'] = after.toIso8601String();
    }

    if (before != null) {
      map['before'] = before.toIso8601String();
    }

    if (exclude != null) {
      map['exclude'] = exclude.join(',');
    }

    if (include != null) {
      map['include'] = include.join(',');
    }

    if (offset != null) {
      map['offset'] = offset;
    }

    if (reviewer != null) {
      map['reviewer'] = reviewer.join(',');
    }

    if (reviewerExclude != null) {
      map['reviewer_exclude'] = reviewerExclude.join(',');
    }

    if (reviewerEmail != null) {
      map['reviewer_email'] = reviewerEmail.join(',');
    }

    if (product != null) {
      map['product'] = product.join(',');
    }

    return map;
  }

  Future<WooProductReview> getProductReview(int id, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooProductReview.fake();
    }

    final response = await dio.get(
      _ProductReviewEndpoints.singleReview(id),
    );

    return WooProductReview.fromJson(response.data as Map<String, dynamic>);
  }

  Future<WooProductReview> createProductReview(WooProductReview review,
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return review;
    }

    final response = await dio.post(
      _ProductReviewEndpoints.reviews,
      data: review.toJson(),
    );

    return WooProductReview.fromJson(response.data as Map<String, dynamic>);
  }

  Future<WooProductReview> updateProductReview(WooProductReview review,
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return review;
    }

    final response = await dio.put(
      _ProductReviewEndpoints.singleReview(review.id!),
      data: review.toJson(),
    );

    return WooProductReview.fromJson(response.data as Map<String, dynamic>);
  }

  Future<WooProductReview> deleteProductReview(int reviewId,
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooProductReview.fake(reviewId);
    }

    final response = await dio.delete(
      _ProductReviewEndpoints.singleReview(reviewId),
      queryParameters: {
        'force': true,
      },
    );

    return WooProductReview.fromJson(response.data as Map<String, dynamic>);
  }
}
