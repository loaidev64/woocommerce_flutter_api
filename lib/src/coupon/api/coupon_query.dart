import '../../base/enums/context.dart';
import '../../base/woo_query.dart';
import '../../json/woo_json.dart';

class WooCouponQuery extends WooQuery {
  const WooCouponQuery({
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
    this.code,
  });
  final WooContext context;
  final DateTime? after;
  final DateTime? before;
  final DateTime? modifiedAfter;
  final DateTime? modifiedBefore;
  final bool? datesAreGmt;
  final List<int>? exclude;
  final List<int>? include;
  final String? code;
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
    ..putIfPresent('code', code);
}
