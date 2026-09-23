import 'package:meta/meta.dart';
import '../../base/base.dart';
import '../../exceptions/woocommerce_exception.dart';
import '../enums/order_status.dart';
import '../models/order.dart';
import '../models/order_batch_request.dart';
import '../models/order_batch_response.dart';
import '../../woocommerce_flutter_api_base.dart';
import 'order_query.dart';
export 'order_query.dart';
part 'order_endpoints.dart';

extension WooOrderApi on WooCommerce {
  Future<WooPage<WooOrder>> getOrders({
    WooContext context = WooContext.view,
    int? page,
    int? perPage,
    String? search,
    DateTime? after,
    DateTime? before,
    DateTime? modifiedAfter,
    DateTime? modifiedBefore,
    bool? datesAreGmt,
    List<int>? exclude,
    List<int>? include,
    int? offset,
    WooSort? order,
    WooOrderBy? orderBy,
    List<int>? parent,
    List<int>? parentExclude,
    List<WooOrderStatus> status = const [WooOrderStatus.any],
    int? customer,
    int? product,
    int? dp,
    String? currency,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooPage(
        items: List.generate(perPage ?? 10, (index) => WooOrder.fake()),
        page: page ?? 1,
      );
    }
    final query = WooOrderQuery(
      context: context,
      page: page,
      perPage: perPage,
      search: search,
      after: after,
      before: before,
      modifiedAfter: modifiedAfter,
      modifiedBefore: modifiedBefore,
      datesAreGmt: datesAreGmt,
      exclude: exclude,
      include: include,
      offset: offset,
      order: order,
      orderBy: orderBy,
      parent: parent,
      parentExclude: parentExclude,
      status: status,
      customer: customer,
      product: product,
      dp: dp,
      currency: currency,
    );
    final response = await requestGet<List<dynamic>>(
      _OrderEndpoints.orders,
      queryParameters: query.toMap(),
    );
    final items = response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooOrder.fromJson)
            .toList() ??
        const <WooOrder>[];
    return WooPage.parse(response: response, items: items, page: page ?? 1);
  }

  Future<WooOrder> getOrder(int id, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooOrder.fake();
    }
    final response =
        await requestGet<Map<String, dynamic>>(_OrderEndpoints.singleOrder(id));
    final data = response.data;
    if (data == null) {
      throw WooCommerceParseException(
        message: 'Failed to parse order response',
        statusCode: response.statusCode,
        path: _OrderEndpoints.singleOrder(id),
      );
    }
    return WooOrder.fromJson(data);
  }

  Future<WooOrder> createOrder(WooOrder order, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return order;
    }
    final response = await requestPost<Map<String, dynamic>>(
      _OrderEndpoints.orders,
      data: order.toJson(),
    );
    return WooOrder.fromJson(response.data!);
  }

  Future<WooOrder> updateOrder(int id, WooOrder order, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return order;
    }
    final response = await requestPut<Map<String, dynamic>>(
      _OrderEndpoints.singleOrder(id),
      data: order.toJson()..remove('id'),
    );
    return WooOrder.fromJson(response.data!);
  }

  Future<WooDeleteResult> deleteOrder(
    int id, {
    bool? useFaker,
    bool force = false,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooDeleteResult(id: id, deleted: true);
    }
    final response = await requestDelete<Map<String, dynamic>>(
      _OrderEndpoints.singleOrder(id),
      queryParameters: {'force': force},
    );
    return WooDeleteResult.fromJson(response.data!);
  }

  @experimental
  Future<String> sendOrderDetailsToCustomer(
    int orderId, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return 'Order details sent to woo@example.com, via REST API.';
    }
    final response = await requestPost<Map<String, dynamic>>(
      _OrderEndpoints.sendOrderDetails(orderId),
    );
    return response.data?['message'] as String? ?? '';
  }

  Future<WooOrderBatchResponse> batchUpdateOrders(
    WooOrderBatchRequest request, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooOrderBatchResponse(
        create: request.create?.map((order) => WooOrder.fake()).toList(),
        update: request.update,
        delete: request.delete?.map((id) => WooOrder.fake()).toList(),
      );
    }
    final response = await requestPost<Map<String, dynamic>>(
      _OrderEndpoints.batchOrders(),
      data: request.toJson(),
    );
    return WooOrderBatchResponse.fromJson(response.data!);
  }
}
