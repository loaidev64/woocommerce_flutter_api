import '../../base/enums/context.dart';
import '../../base/woo_query.dart';
import '../../json/woo_json.dart';
import '../enums/product_review_status.dart';

class WooProductReviewQuery extends WooQuery {
  const WooProductReviewQuery({
    super.page,
    super.perPage,
    super.order,
    super.orderBy,
    super.search,
    super.offset,
    this.context = WooContext.view,
    this.after,
    this.before,
    this.exclude,
    this.include,
    this.reviewer,
    this.reviewerExclude,
    this.reviewerEmail,
    this.product,
    this.status = WooProductReviewStatus.approved,
  });
  final WooContext context;
  final DateTime? after;
  final DateTime? before;
  final List<int>? exclude;
  final List<int>? include;
  final List<int>? reviewer;
  final List<int>? reviewerExclude;
  final List<String>? reviewerEmail;
  final List<int>? product;
  final WooProductReviewStatus status;
  @override
  Map<String, dynamic> toMap() => super.toMap()
    ..putEnum('context', context)
    ..putDate('after', after)
    ..putDate('before', before)
    ..putIfPresent('exclude', exclude?.join(','))
    ..putIfPresent('include', include?.join(','))
    ..putIfPresent('reviewer', reviewer?.join(','))
    ..putIfPresent('reviewer_exclude', reviewerExclude?.join(','))
    ..putIfPresent('reviewer_email', reviewerEmail?.join(','))
    ..putIfPresent('product', product?.join(','))
    ..putEnum('status', status);
}
