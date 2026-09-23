import '../../base/enums/context.dart';
import '../../base/woo_query.dart';
import '../../json/woo_json.dart';
import '../enums/order_status.dart';

class WooOrderQuery extends WooQuery {
  const WooOrderQuery({
    super.page,
    super.perPage,
    super.order,
    super.orderBy,
    super.search,
    super.offset,
    this.context,
    this.after,
    this.before,
    this.modifiedAfter,
    this.modifiedBefore,
    this.datesAreGmt,
    this.exclude,
    this.include,
    this.parent,
    this.parentExclude,
    this.status,
    this.customer,
    this.product,
    this.dp,
    this.currency,
  });
  final WooContext? context;
  final DateTime? after;
  final DateTime? before;
  final DateTime? modifiedAfter;
  final DateTime? modifiedBefore;
  final bool? datesAreGmt;
  final List<int>? exclude;
  final List<int>? include;
  final List<int>? parent;
  final List<int>? parentExclude;
  final List<WooOrderStatus>? status;
  final int? customer;
  final int? product;
  final int? dp;
  final String? currency;
  @override
  Map<String, dynamic> toMap() => super.toMap()
    ..putIfPresent('context', context?.value)
    ..putDate('after', after)
    ..putDate('before', before)
    ..putDate('modified_after', modifiedAfter)
    ..putDate('modified_before', modifiedBefore)
    ..putIfPresent('dates_are_gmt', datesAreGmt)
    ..putIfPresent('exclude', exclude?.join(','))
    ..putIfPresent('include', include?.join(','))
    ..putIfPresent('parent', parent?.join(','))
    ..putIfPresent('parent_exclude', parentExclude?.join(','))
    ..putIfPresent('status', status?.map((s) => s.value).join(','))
    ..putIfPresent('customer', customer)
    ..putIfPresent('product', product)
    ..putIfPresent('dp', dp)
    ..putIfPresent('currency', currency);
}
