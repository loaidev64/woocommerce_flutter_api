import '../../base/enums/context.dart';
import '../../base/woo_query.dart';
import '../../json/woo_json.dart';
import '../enums/product_status.dart';
import '../enums/product_stock_status.dart';
import '../enums/product_type.dart';

class WooProductQuery extends WooQuery {
  const WooProductQuery({
    super.page,
    super.perPage,
    super.order,
    super.orderBy,
    super.search,
    super.offset,
    this.context = WooContext.view,
    this.after,
    this.before,
    this.modifiedAfter,
    this.modifiedBefore,
    this.datesAreGmt,
    this.exclude,
    this.include,
    this.parent,
    this.parentExclude,
    this.slug,
    this.status,
    this.type,
    this.sku,
    this.featured,
    this.category,
    this.tag,
    this.shippingClass,
    this.attribute,
    this.attributeTerm,
    this.taxClass,
    this.onSale,
    this.minPrice,
    this.maxPrice,
    this.stockStatus,
    this.currency,
  });
  final WooContext context;
  final DateTime? after;
  final DateTime? before;
  final DateTime? modifiedAfter;
  final DateTime? modifiedBefore;
  final bool? datesAreGmt;
  final List<int>? exclude;
  final List<int>? include;
  final List<int>? parent;
  final List<int>? parentExclude;
  final String? slug;
  final WooProductStatus? status;
  final WooProductType? type;
  final String? sku;
  final bool? featured;
  final int? category;
  final int? tag;
  final int? shippingClass;
  final String? attribute;
  final String? attributeTerm;
  final String? taxClass;
  final bool? onSale;
  final double? minPrice;
  final double? maxPrice;
  final WooProductStockStatus? stockStatus;
  final String? currency;
  @override
  Map<String, dynamic> toMap() => super.toMap()
    ..putEnum('context', context)
    ..putDate('after', after)
    ..putDate('before', before)
    ..putDate('modified_after', modifiedAfter)
    ..putDate('modified_before', modifiedBefore)
    ..putIfPresent('dates_are_gmt', datesAreGmt)
    ..putIfPresent('exclude', exclude?.join(','))
    ..putIfPresent('include', include?.join(','))
    ..putIfPresent('parent', parent?.join(','))
    ..putIfPresent('parent_exclude', parentExclude?.join(','))
    ..putIfPresent('slug', slug)
    ..putEnum('status', status)
    ..putEnum('type', type)
    ..putIfPresent('sku', sku)
    ..putIfPresent('featured', featured)
    ..putIfPresent('category', category)
    ..putIfPresent('tag', tag)
    ..putIfPresent('shipping_class', shippingClass)
    ..putIfPresent('attribute', attribute)
    ..putIfPresent('attribute_term', attributeTerm)
    ..putIfPresent('tax_class', taxClass)
    ..putIfPresent('on_sale', onSale)
    ..putIfPresent('min_price', minPrice)
    ..putIfPresent('max_price', maxPrice)
    ..putEnum('stock_status', stockStatus)
    ..putIfPresent('currency', currency);
}
