import '../json/woo_json.dart';
import 'enums/sort.dart';

abstract class WooQuery {
  const WooQuery({
    this.page,
    this.perPage,
    this.order,
    this.orderBy,
    this.search,
    this.offset,
  });
  final int? page;
  final int? perPage;
  final WooSort? order;
  final WooOrderBy? orderBy;
  final String? search;
  final int? offset;
  Map<String, dynamic> toMap() => <String, dynamic>{}
    ..putIfPresent('page', page)
    ..putIfPresent('per_page', perPage)
    ..putIfPresent('offset', offset)
    ..putIfPresent('search', search)
    ..putEnum('order', order)
    ..putEnum('orderby', orderBy);
}
