import '../../base/enums/context.dart';
import '../../base/woo_query.dart';
import '../../json/woo_json.dart';
import '../enums/webhook_status.dart';

class WooWebhookQuery extends WooQuery {
  const WooWebhookQuery({
    super.page,
    super.perPage,
    super.order,
    super.orderBy,
    super.search,
    super.offset,
    this.context = WooContext.view,
    this.after,
    this.before,
    this.exclude,
    this.include,
    this.status,
  });
  final WooContext context;
  final DateTime? after;
  final DateTime? before;
  final List<int>? exclude;
  final List<int>? include;
  final WooWebhookStatus? status;
  @override
  Map<String, dynamic> toMap() => super.toMap()
    ..putEnum('context', context)
    ..putDate('after', after)
    ..putDate('before', before)
    ..putIfPresent('exclude', exclude?.join(','))
    ..putIfPresent('include', include?.join(','))
    ..putIfPresent('status', status?.value ?? 'all');
}
