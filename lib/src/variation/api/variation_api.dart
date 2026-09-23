import '../../base/enums/context.dart';
import '../../base/enums/sort.dart';
import '../../base/models/woo_delete_result.dart';
import '../../exceptions/woocommerce_exception.dart';
import '../../pagination/woo_page.dart';
import '../../woocommerce_flutter_api_base.dart';
import '../../product/enums/product_status.dart';
import '../../product/enums/product_stock_status.dart';
import '../models/variation.dart';
import '../models/variation_batch_request.dart';
import '../models/variation_batch_response.dart';
import 'variation_query.dart';
part 'endpoints.dart';

extension WooVariationApi on WooCommerce {
  Future<WooPage<WooProductVariation>> getProductVariations(
    int productId, {
    WooContext context = WooContext.view,
    int? page,
    int? perPage,
    String? search,
    DateTime? after,
    DateTime? before,
    List<int>? exclude,
    List<int>? include,
    WooSort order = WooSort.desc,
    WooOrderBy orderBy = WooOrderBy.date,
    int? parent,
    List<int>? parentExclude,
    String? slug,
    WooProductStatus? status,
    String? sku,
    String? taxClass,
    bool? onSale,
    double? minPrice,
    double? maxPrice,
    WooProductStockStatus? stockStatus,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooPage(
        items: List.generate(perPage ?? 10, (_) => WooProductVariation.fake()),
        page: page ?? 1,
      );
    }
    final query = WooVariationQuery(
      context: context,
      page: page,
      perPage: perPage,
      search: search,
      after: after,
      before: before,
      exclude: exclude,
      include: include,
      order: order,
      orderBy: orderBy,
      parent: parent,
      parentExclude: parentExclude,
      slug: slug,
      status: status,
      sku: sku,
      taxClass: taxClass,
      onSale: onSale,
      minPrice: minPrice,
      maxPrice: maxPrice,
      stockStatus: stockStatus,
    );
    final response = await requestGet<List<dynamic>>(
      _VariationEndpoints.variations(productId),
      queryParameters: query.toMap(),
    );
    final items = response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooProductVariation.fromJson)
            .toList() ??
        const [];
    return WooPage.parse(response: response, items: items, page: page ?? 1);
  }

  Future<WooProductVariation> getProductVariation(
    int productId,
    int variationId, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductVariation.fake();
    }
    final response = await requestGet<Map<String, dynamic>>(
      _VariationEndpoints.singleVariation(productId, variationId),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected a variation object for variation $variationId of '
            'product $productId',
        statusCode: response.statusCode,
        path: _VariationEndpoints.singleVariation(productId, variationId),
      );
    }
    return WooProductVariation.fromJson(data);
  }

  Future<WooProductVariation> createProductVariation(
    int productId,
    WooProductVariation variation, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductVariation.fake();
    }
    final response = await requestPost<Map<String, dynamic>>(
      _VariationEndpoints.variations(productId),
      data: variation.toJson(),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected a variation object in the create response',
        statusCode: response.statusCode,
        path: _VariationEndpoints.variations(productId),
      );
    }
    return WooProductVariation.fromJson(data);
  }

  Future<WooProductVariation> updateProductVariation(
    int productId,
    int variationId,
    WooProductVariation variation, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductVariation.fake();
    }
    final response = await requestPut<Map<String, dynamic>>(
      _VariationEndpoints.singleVariation(productId, variationId),
      data: variation.toJson(),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected a variation object in the update response',
        statusCode: response.statusCode,
        path: _VariationEndpoints.singleVariation(productId, variationId),
      );
    }
    return WooProductVariation.fromJson(data);
  }

  Future<WooDeleteResult> deleteProductVariation(
    int productId,
    int variationId, {
    bool force = false,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooDeleteResult(id: variationId, deleted: true);
    }
    final response = await requestDelete<Map<String, dynamic>>(
      _VariationEndpoints.singleVariation(productId, variationId),
      queryParameters: {'force': force},
    );
    return WooDeleteResult.fromJson(response.data!);
  }

  Future<WooProductVariationBatchResponse> batchUpdateProductVariations(
    int productId,
    WooProductVariationBatchRequest request, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductVariationBatchResponse(
        create: request.create
            ?.map((variation) => WooProductVariation.fake())
            .toList(),
        update: request.update,
        delete:
            request.delete?.map((id) => WooProductVariation.fake()).toList(),
      );
    }
    final response = await requestPost<Map<String, dynamic>>(
      _VariationEndpoints.batchVariations(productId),
      data: request.toJson(),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected a batch response object',
        statusCode: response.statusCode,
        path: _VariationEndpoints.batchVariations(productId),
      );
    }
    return WooProductVariationBatchResponse.fromJson(data);
  }
}
