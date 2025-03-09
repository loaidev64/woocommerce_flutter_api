import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'product_review_endpoints.dart';

extension WooProductReviewApi on WooCommerce {
  /// [context] Scope under which the request is made; determines fields present in response. Options: view and edit. Default is view.
  ///
  /// [page] Current page of the collection. Default is 1.
  ///
  /// [perPage] Maximum number of items to be returned in result set. Default is 10.
  ///
  /// [search] Limit results to those matching a string.
  ///
  /// [after] Limit response to reviews published after a given ISO8601 compliant date.
  ///
  /// [before] Limit response to reviews published before a given ISO8601 compliant date.
  ///
  /// [exclude] Ensure result set excludes specific IDs.
  ///
  /// [include] Limit result set to specific IDs.
  ///
  /// [offset] Offset the result set by a specific number of items.
  ///
  /// [order] Order sort attribute ascending or descending. Options: asc and desc. Default is desc.
  ///
  /// [orderBy] Sort collection by resource attribute. Options: date, date_gmt, id, slug, include, and product. Default is date_gmt.
  ///
  /// [reviewer] Limit result set to reviews assigned to specific user IDs.
  ///
  /// [reviewerExclude] Ensure result set excludes reviews assigned to specific user IDs.
  ///
  /// [reviewerEmail] Limit result set to that from a specific author email.
  ///
  /// [product] Limit result set to reviews assigned to specific product IDs.
  ///
  /// [status] Limit result set to reviews assigned a specific status. Options: all, hold, approved, spam, and trash. Default is approved.
  ///
  /// [useFaker] If true, returns fake data instead of making an API request.
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
