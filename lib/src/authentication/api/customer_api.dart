import '../../base/enums/context.dart';
import '../../base/enums/sort.dart';
import '../../base/models/woo_delete_result.dart';
import '../../exceptions/woocommerce_exception.dart';
import '../../helpers/fake_helper.dart';
import '../../pagination/woo_page.dart';
import '../../woocommerce_flutter_api_base.dart';
import '../models/customer.dart';
import '../models/customer_batch_request.dart';
import '../models/customer_batch_response.dart';
import '../models/customer_download.dart';
import '../enums/customer_role.dart';
import 'customer_query.dart';
export 'customer_query.dart';
part 'customer_endpoints.dart';

extension WooCustomerApi on WooCommerce {
  Future<WooPage<WooCustomer>> getCustomers({
    WooContext? context,
    int? page,
    int? perPage,
    String? search,
    List<int>? exclude,
    List<int>? include,
    int? offset,
    WooSort? order,
    WooOrderBy? orderBy,
    String? email,
    WooCustomerRole? role,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooPage(
        items: List.generate(perPage ?? 10, (_) => WooCustomer.fake()),
        page: page ?? 1,
      );
    }
    final query = WooCustomerQuery(
      context: context,
      page: page,
      perPage: perPage,
      order: order,
      orderBy: orderBy,
      search: search,
      offset: offset,
      email: email,
      role: role,
    );
    final response = await requestGet<List<dynamic>>(
      _CustomerEndpoints.customers,
      queryParameters: query.toMap(),
    );
    final items = response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooCustomer.fromJson)
            .toList() ??
        const [];
    return WooPage.parse(response: response, items: items, page: page ?? 1);
  }

  Future<WooCustomer> getCustomer(int id, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooCustomer.fake(id: id);
    }
    final response =
        await requestGet<Map<String, dynamic>>(_CustomerEndpoints.customer(id));
    final data = response.data;
    if (data == null) {
      throw WooCommerceParseException(
        message: 'Expected a customer object but the response body was empty',
        statusCode: response.statusCode,
        path: _CustomerEndpoints.customer(id),
      );
    }
    return WooCustomer.fromJson(data);
  }

  Future<WooCustomer> createCustomer(
    WooCustomer customer, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return customer;
    }
    final response = await requestPost<Map<String, dynamic>>(
      _CustomerEndpoints.customers,
      data: customer.toJson(),
    );
    final data = response.data;
    if (data == null) {
      throw WooCommerceParseException(
        message: 'Expected a customer object but the response body was empty',
        statusCode: response.statusCode,
        path: _CustomerEndpoints.customers,
      );
    }
    return WooCustomer.fromJson(data);
  }

  Future<WooCustomer> updateCustomer(
    int id,
    WooCustomer customer, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return customer;
    }
    final response = await requestPut<Map<String, dynamic>>(
      _CustomerEndpoints.customer(id),
      data: customer.toJson(),
    );
    final data = response.data;
    if (data == null) {
      throw WooCommerceParseException(
        message: 'Expected a customer object but the response body was empty',
        statusCode: response.statusCode,
        path: _CustomerEndpoints.customer(id),
      );
    }
    return WooCustomer.fromJson(data);
  }

  Future<WooDeleteResult> deleteCustomer(
    int id, {
    int? reassign,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooDeleteResult(id: id, deleted: true);
    }
    final response = await requestDelete<Map<String, dynamic>>(
      _CustomerEndpoints.customer(id),
      queryParameters: {
        'force': true,
        if (reassign != null) 'reassign': reassign,
      },
    );
    final data = response.data;
    if (data == null) {
      throw WooCommerceParseException(
        message: 'Expected a delete result but the response body was empty',
        statusCode: response.statusCode,
        path: _CustomerEndpoints.customer(id),
      );
    }
    return WooDeleteResult.fromJson(data);
  }

  Future<WooPage<WooCustomerDownload>> getCustomerDownloads(
    int customerId, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooPage(
        items: FakeHelper.list(() => WooCustomerDownload.fake()),
        page: 1,
      );
    }
    final response = await requestGet<List<dynamic>>(
      _CustomerEndpoints.downloads(customerId),
    );
    final items = response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooCustomerDownload.fromJson)
            .toList() ??
        const [];
    return WooPage.parse(response: response, items: items, page: 1);
  }

  Future<WooCustomerBatchResponse> batchUpdateCustomers(
    WooCustomerBatchRequest request, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooCustomerBatchResponse(
        create: request.create?.map((_) => WooCustomer.fake()).toList(),
        update: request.update,
        delete: request.delete?.map((id) => WooCustomer.fake(id: id)).toList(),
      );
    }
    final response = await requestPost<Map<String, dynamic>>(
      _CustomerEndpoints.batch,
      data: request.toJson(),
    );
    final data = response.data;
    if (data == null) {
      throw WooCommerceParseException(
        message: 'Expected a batch response but the response body was empty',
        statusCode: response.statusCode,
        path: _CustomerEndpoints.batch,
      );
    }
    return WooCustomerBatchResponse.fromJson(data);
  }
}
