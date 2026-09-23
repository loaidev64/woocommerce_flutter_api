import '../../base/enums/context.dart';
import '../../base/enums/sort.dart';
import '../../base/models/woo_delete_result.dart';
import '../../exceptions/woocommerce_exception.dart';
import '../../pagination/woo_page.dart';
import '../../woocommerce_flutter_api_base.dart';
import '../enums/product_review_status.dart';
import '../models/product_review.dart';
import '../models/product_review_batch_request.dart';
import '../models/product_review_batch_response.dart';
import 'product_review_query.dart';
part 'product_review_endpoints.dart';

extension WooProductReviewApi on WooCommerce {
  Future<WooPage<WooProductReview>> getProductReviews({
    WooContext context = WooContext.view,
    int? page,
    int? perPage,
    String? search,
    DateTime? after,
    DateTime? before,
    List<int>? exclude,
    List<int>? include,
    int? offset,
    WooSort order = WooSort.desc,
    WooOrderBy orderBy = WooOrderBy.dateGmt,
    List<int>? reviewer,
    List<int>? reviewerExclude,
    List<String>? reviewerEmail,
    List<int>? product,
    WooProductReviewStatus status = WooProductReviewStatus.approved,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooPage(
        items: List.generate(perPage ?? 10, (_) => WooProductReview.fake()),
        page: page ?? 1,
      );
    }
    final query = WooProductReviewQuery(
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
    );
    final response = await requestGet<List<dynamic>>(
      _ProductReviewEndpoints.reviews,
      queryParameters: query.toMap(),
    );
    final items = response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooProductReview.fromJson)
            .toList() ??
        const [];
    return WooPage.parse(response: response, items: items, page: page ?? 1);
  }

  Future<WooProductReview> getProductReview(int id, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductReview.fake();
    }
    final response = await requestGet<Map<String, dynamic>>(
      _ProductReviewEndpoints.singleReview(id),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected a review object for review $id',
        statusCode: response.statusCode,
        path: _ProductReviewEndpoints.singleReview(id),
      );
    }
    return WooProductReview.fromJson(data);
  }

  Future<WooProductReview> createProductReview(
    WooProductReview review, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductReview.fake();
    }
    final response = await requestPost<Map<String, dynamic>>(
      _ProductReviewEndpoints.reviews,
      data: review.toJson(),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected a review object in the create response',
        statusCode: response.statusCode,
        path: _ProductReviewEndpoints.reviews,
      );
    }
    return WooProductReview.fromJson(data);
  }

  Future<WooProductReview> updateProductReview(
    int id,
    WooProductReview review, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductReview.fake(id: id);
    }
    final response = await requestPut<Map<String, dynamic>>(
      _ProductReviewEndpoints.singleReview(id),
      data: review.toJson(),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected a review object in the update response',
        statusCode: response.statusCode,
        path: _ProductReviewEndpoints.singleReview(id),
      );
    }
    return WooProductReview.fromJson(data);
  }

  Future<WooDeleteResult> deleteProductReview(int id, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooDeleteResult(id: id, deleted: true);
    }
    final response = await requestDelete<Map<String, dynamic>>(
      _ProductReviewEndpoints.singleReview(id),
      queryParameters: {'force': true},
    );
    return WooDeleteResult.fromJson(response.data!);
  }

  Future<WooProductReviewBatchResponse> batchUpdateProductReviews(
    WooProductReviewBatchRequest request, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductReviewBatchResponse(
        create:
            request.create?.map((review) => WooProductReview.fake()).toList(),
        update: request.update,
        delete:
            request.delete?.map((id) => WooProductReview.fake(id: id)).toList(),
      );
    }
    final response = await requestPost<Map<String, dynamic>>(
      _ProductReviewEndpoints.batchReviews(),
      data: request.toJson(),
    );
    return WooProductReviewBatchResponse.fromJson(response.data!);
  }
}
