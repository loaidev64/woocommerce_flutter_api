import '../../base/enums/context.dart';
import '../../base/woo_query.dart';
import '../../json/woo_json.dart';

class WooProductShippingClassQuery extends WooQuery {
  const WooProductShippingClassQuery({
    super.page,
    super.perPage,
    super.order,
    super.orderBy,
    super.search,
    super.offset,
    this.context = WooContext.view,
    this.exclude,
    this.include,
    this.hideEmpty,
    this.product,
    this.slug,
  });
  final WooContext context;
  final List<int>? exclude;
  final List<int>? include;
  final bool? hideEmpty;
  final int? product;
  final String? slug;
  @override
  Map<String, dynamic> toMap() => super.toMap()
    ..putEnum('context', context)
    ..putIfPresent('exclude', exclude?.join(','))
    ..putIfPresent('include', include?.join(','))
    ..putIfPresent('hide_empty', hideEmpty)
    ..putIfPresent('product', product)
    ..putIfPresent('slug', slug);
}
