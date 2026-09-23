import '../../base/enums/context.dart';
import '../../base/woo_query.dart';
import '../../json/woo_json.dart';

class WooProductAttributeQuery extends WooQuery {
  const WooProductAttributeQuery({
    super.page,
    super.perPage,
    super.search,
    super.offset,
    this.context = WooContext.view,
  });
  final WooContext context;
  @override
  Map<String, dynamic> toMap() => super.toMap()..putEnum('context', context);
}
