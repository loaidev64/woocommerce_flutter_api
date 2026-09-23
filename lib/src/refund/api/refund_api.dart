import '../../base/base.dart';
import '../models/refund.dart';
import '../../woocommerce_flutter_api_base.dart';
import 'refund_query.dart';
export 'refund_query.dart';
part 'endpoints.dart';

extension WooRefundApi on WooCommerce {
  Future<WooPage<WooRefund>> getRefunds({
    WooContext context = WooContext.view,
    int? page,
    int? perPage,
    String? search,
    DateTime? after,
    DateTime? before,
    List<int>? exclude,
    List<int>? include,
    int? offset,
    WooSort? order,
    WooOrderBy? orderBy,
    List<int>? parent,
    List<int>? parentExclude,
    int? dp,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooPage(
        items: List.generate(perPage ?? 10, (index) => WooRefund.fake()),
        page: page ?? 1,
      );
    }
    final query = WooRefundQuery(
      context: context,
      page: page,
      perPage: perPage,
      search: search,
      after: after,
      before: before,
      exclude: exclude,
      include: include,
      offset: offset,
      order: order,
      orderBy: orderBy,
      parent: parent,
      parentExclude: parentExclude,
      dp: dp,
    );
    final response = await requestGet<List<dynamic>>(
      _RefundEndpoints.refunds,
      queryParameters: query.toMap(),
    );
    final items = response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooRefund.fromJson)
            .toList() ??
        const <WooRefund>[];
    return WooPage.parse(response: response, items: items, page: page ?? 1);
  }
}
