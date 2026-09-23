import '../../base/enums/context.dart';
import '../../base/woo_query.dart';
import '../../json/woo_json.dart';

class WooRefundQuery extends WooQuery {
  const WooRefundQuery({
    super.page,
    super.perPage,
    super.order,
    super.orderBy,
    super.search,
    super.offset,
    this.context,
    this.after,
    this.before,
    this.exclude,
    this.include,
    this.parent,
    this.parentExclude,
    this.dp,
  });
  final WooContext? context;
  final DateTime? after;
  final DateTime? before;
  final List<int>? exclude;
  final List<int>? include;
  final List<int>? parent;
  final List<int>? parentExclude;
  final int? dp;
  @override
  Map<String, dynamic> toMap() => super.toMap()
    ..putIfPresent('context', context?.value)
    ..putDate('after', after)
    ..putDate('before', before)
    ..putIfPresent('exclude', exclude?.join(','))
    ..putIfPresent('include', include?.join(','))
    ..putIfPresent('parent', parent?.join(','))
    ..putIfPresent('parent_exclude', parentExclude?.join(','))
    ..putIfPresent('dp', dp);
}
