import '../../base/base.dart';
import '../../exceptions/woocommerce_exception.dart';
import '../../helpers/fake_helper.dart';
import '../models/order_refund.dart';
import '../../woocommerce_flutter_api_base.dart';
import 'order_refund_query.dart';
export 'order_refund_query.dart';
part 'order_refund_endpoints.dart';

extension WooOrderRefundApi on WooCommerce {
  Future<WooPage<WooOrderRefund>> getOrderRefunds(
    int orderId, {
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
        items: FakeHelper.list(WooOrderRefund.fake),
        page: page ?? 1,
      );
    }
    final query = WooOrderRefundQuery(
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
      _OrderRefundEndpoints.refunds(orderId),
      queryParameters: query.toMap(),
    );
    final items = response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooOrderRefund.fromJson)
            .toList() ??
        const <WooOrderRefund>[];
    return WooPage.parse(response: response, items: items, page: page ?? 1);
  }

  Future<WooOrderRefund> getOrderRefund(
    int orderId,
    int refundId, {
    int? dp,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooOrderRefund.fake();
    }
    final response = await requestGet<Map<String, dynamic>>(
      _OrderRefundEndpoints.singleRefund(orderId, refundId),
      queryParameters: {
        if (dp != null) 'dp': dp,
      },
    );
    final data = response.data;
    if (data == null) {
      throw WooCommerceParseException(
        message: 'Failed to parse order refund response',
        statusCode: response.statusCode,
        path: _OrderRefundEndpoints.singleRefund(orderId, refundId),
      );
    }
    return WooOrderRefund.fromJson(data);
  }

  Future<WooOrderRefund> createOrderRefund(
    int orderId,
    WooOrderRefund refund, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooOrderRefund.fake();
    }
    final response = await requestPost<Map<String, dynamic>>(
      _OrderRefundEndpoints.refunds(orderId),
      data: refund.toJson()..remove('id'),
    );
    return WooOrderRefund.fromJson(response.data!);
  }

  Future<WooOrderRefund> updateOrderRefund(
    int orderId,
    int refundId,
    WooOrderRefund refund, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return refund;
    }
    final response = await requestPut<Map<String, dynamic>>(
      _OrderRefundEndpoints.singleRefund(orderId, refundId),
      data: refund.toJson()..remove('id'),
    );
    return WooOrderRefund.fromJson(response.data!);
  }

  Future<WooDeleteResult> deleteOrderRefund(
    int orderId,
    int refundId, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooDeleteResult(id: refundId, deleted: true);
    }
    final response = await requestDelete<Map<String, dynamic>>(
      _OrderRefundEndpoints.singleRefund(orderId, refundId),
      queryParameters: {'force': true},
    );
    return WooDeleteResult.fromJson(response.data!);
  }
}
