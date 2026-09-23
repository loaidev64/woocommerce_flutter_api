import '../../base/enums/context.dart';
import '../../base/woo_query.dart';
import '../../json/woo_json.dart';
import '../enums/customer_role.dart';

class WooCustomerQuery extends WooQuery {
  const WooCustomerQuery({
    super.page,
    super.perPage,
    super.order,
    super.orderBy,
    super.search,
    super.offset,
    this.context,
    this.exclude,
    this.include,
    this.email,
    this.role,
  });
  final WooContext? context;
  final List<int>? exclude;
  final List<int>? include;
  final String? email;
  final WooCustomerRole? role;
  @override
  Map<String, dynamic> toMap() => super.toMap()
    ..putIfPresent('context', context?.value)
    ..putIfPresent('email', email)
    ..putIfPresent('role', role?.value)
    ..putIfPresent('exclude', exclude?.join(','))
    ..putIfPresent('include', include?.join(','));
}
