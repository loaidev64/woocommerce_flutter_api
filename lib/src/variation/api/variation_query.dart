import '../../base/enums/context.dart';
import '../../base/woo_query.dart';
import '../../json/woo_json.dart';
import '../../product/enums/product_status.dart';
import '../../product/enums/product_stock_status.dart';

class WooVariationQuery extends WooQuery {
  const WooVariationQuery({
    super.page,
    super.perPage,
    super.order,
    super.orderBy,
    super.search,
    super.offset,
    this.context = WooContext.view,
    this.after,
    this.before,
    this.datesAreGmt,
    this.modifiedAfter,
    this.modifiedBefore,
    this.exclude,
    this.include,
    this.parent,
    this.parentExclude,
    this.slug,
    this.status,
    this.sku,
    this.taxClass,
    this.onSale,
    this.minPrice,
    this.maxPrice,
    this.stockStatus,
    this.menuOrder,
  });
  final WooContext context;
  final DateTime? after;
  final DateTime? before;
  final bool? datesAreGmt;
  final DateTime? modifiedAfter;
  final DateTime? modifiedBefore;
  final List<int>? exclude;
  final List<int>? include;
  final int? parent;
  final List<int>? parentExclude;
  final String? slug;
  final WooProductStatus? status;
  final String? sku;
  final String? taxClass;
  final bool? onSale;
  final double? minPrice;
  final double? maxPrice;
  final WooProductStockStatus? stockStatus;
  final int? menuOrder;
  @override
  Map<String, dynamic> toMap() => super.toMap()
    ..putEnum('context', context)
    ..putDate('after', after)
    ..putDate('before', before)
    ..putIfPresent('dates_are_gmt', datesAreGmt)
    ..putDate('modified_after', modifiedAfter)
    ..putDate('modified_before', modifiedBefore)
    ..putIfPresent('exclude', exclude?.join(','))
    ..putIfPresent('include', include?.join(','))
    ..putIfPresent('parent', parent)
    ..putIfPresent('parent_exclude', parentExclude?.join(','))
    ..putIfPresent('slug', slug)
    ..putEnum('status', status)
    ..putIfPresent('sku', sku)
    ..putIfPresent('tax_class', taxClass)
    ..putIfPresent('on_sale', onSale)
    ..putIfPresent('min_price', minPrice)
    ..putIfPresent('max_price', maxPrice)
    ..putEnum('stock_status', stockStatus)
    ..putIfPresent('menu_order', menuOrder);
}
