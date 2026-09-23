import '../../base/enums/context.dart';
import '../../base/enums/sort.dart';
import '../../base/models/woo_delete_result.dart';
import '../../exceptions/woocommerce_exception.dart';
import '../../pagination/woo_page.dart';
import '../../woocommerce_flutter_api_base.dart';
import '../models/product_shipping_class.dart';
import '../models/product_shipping_class_batch_request.dart';
import '../models/product_shipping_class_batch_response.dart';
import 'product_shipping_class_query.dart';
part 'product_shipping_class_endpoints.dart';

extension WooProductShippingClassApi on WooCommerce {
  Future<WooPage<WooProductShippingClass>> getProductShippingClasses({
    WooContext context = WooContext.view,
    int? page,
    int? perPage,
    String? search,
    List<int>? exclude,
    List<int>? include,
    int? offset,
    WooSort order = WooSort.asc,
    WooOrderBy orderBy = WooOrderBy.name,
    bool? hideEmpty,
    int? product,
    String? slug,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooPage(
        items:
            List.generate(perPage ?? 10, (_) => WooProductShippingClass.fake()),
        page: page ?? 1,
      );
    }
    final query = WooProductShippingClassQuery(
      context: context,
      page: page,
      perPage: perPage,
      search: search,
      exclude: exclude,
      include: include,
      offset: offset,
      order: order,
      orderBy: orderBy,
      hideEmpty: hideEmpty,
      product: product,
      slug: slug,
    );
    final response = await requestGet<List<dynamic>>(
      _ProductShippingClassEndpoints.shippingClasses,
      queryParameters: query.toMap(),
    );
    final items = response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooProductShippingClass.fromJson)
            .toList() ??
        const [];
    return WooPage.parse(response: response, items: items, page: page ?? 1);
  }

  Future<WooProductShippingClass> getProductShippingClass(
    int id, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductShippingClass.fake();
    }
    final response = await requestGet<Map<String, dynamic>>(
      _ProductShippingClassEndpoints.singleShippingClass(id),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected a shipping class object for shipping class $id',
        statusCode: response.statusCode,
        path: _ProductShippingClassEndpoints.singleShippingClass(id),
      );
    }
    return WooProductShippingClass.fromJson(data);
  }

  Future<WooProductShippingClass> createProductShippingClass(
    WooProductShippingClass shippingClass, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductShippingClass.fake();
    }
    final response = await requestPost<Map<String, dynamic>>(
      _ProductShippingClassEndpoints.shippingClasses,
      data: shippingClass.toJson(),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected a shipping class object in the create response',
        statusCode: response.statusCode,
        path: _ProductShippingClassEndpoints.shippingClasses,
      );
    }
    return WooProductShippingClass.fromJson(data);
  }

  Future<WooProductShippingClass> updateProductShippingClass(
    int id,
    WooProductShippingClass shippingClass, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductShippingClass.fake(id: id);
    }
    final response = await requestPut<Map<String, dynamic>>(
      _ProductShippingClassEndpoints.singleShippingClass(id),
      data: shippingClass.toJson(),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected a shipping class object in the update response',
        statusCode: response.statusCode,
        path: _ProductShippingClassEndpoints.singleShippingClass(id),
      );
    }
    return WooProductShippingClass.fromJson(data);
  }

  Future<WooDeleteResult> deleteProductShippingClass(
    int id, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooDeleteResult(id: id, deleted: true);
    }
    final response = await requestDelete<Map<String, dynamic>>(
      _ProductShippingClassEndpoints.singleShippingClass(id),
      queryParameters: {'force': true},
    );
    return WooDeleteResult.fromJson(response.data!);
  }

  Future<WooProductShippingClassBatchResponse>
      batchUpdateProductShippingClasses(
    WooProductShippingClassBatchRequest request, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductShippingClassBatchResponse(
        create: request.create
            ?.map((shippingClass) => WooProductShippingClass.fake())
            .toList(),
        update: request.update,
        delete: request.delete
            ?.map((id) => WooProductShippingClass.fake(id: id))
            .toList(),
      );
    }
    final response = await requestPost<Map<String, dynamic>>(
      _ProductShippingClassEndpoints.batchShippingClasses(),
      data: request.toJson(),
    );
    return WooProductShippingClassBatchResponse.fromJson(response.data!);
  }
}
