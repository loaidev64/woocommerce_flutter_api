import '../../base/enums/context.dart';
import '../../base/woo_query.dart';
import '../../json/woo_json.dart';

class WooTaxRateQuery extends WooQuery {
  const WooTaxRateQuery({
    super.page,
    super.perPage,
    super.order,
    super.orderBy,
    super.offset,
    super.search,
    this.context,
    this.taxClass,
  });
  final WooContext? context;
  final String? taxClass;
  @override
  Map<String, dynamic> toMap() => super.toMap()
    ..putEnum('context', context)
    ..putIfPresent('class', taxClass);
}
