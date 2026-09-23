import '../../base/enums/context.dart';
import '../../base/woo_query.dart';
import '../../json/woo_json.dart';
import '../enums/order_note_type.dart';

class WooOrderNoteQuery extends WooQuery {
  const WooOrderNoteQuery({
    super.page,
    super.perPage,
    super.order,
    super.orderBy,
    super.search,
    super.offset,
    this.context,
    this.type,
  });
  final WooContext? context;
  final WooOrderNoteType? type;
  @override
  Map<String, dynamic> toMap() => super.toMap()
    ..putIfPresent('context', context?.value)
    ..putIfPresent('type', type?.value);
}
