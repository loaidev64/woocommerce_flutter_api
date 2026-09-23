import '../../base/enums/context.dart';
import '../../base/enums/sort.dart';
import '../../base/models/woo_delete_result.dart';
import '../../exceptions/woocommerce_exception.dart';
import '../../pagination/woo_page.dart';
import '../models/product_batch_request.dart';
import '../models/product_batch_response.dart';
import '../models/product_with_childrens.dart';
import '../../woocommerce_flutter_api_base.dart';
import '../enums/product_filter_with_option.dart';
import '../enums/product_status.dart';
import '../enums/product_stock_status.dart';
import '../enums/product_type.dart';
import '../models/product.dart';
import 'product_query.dart';
part 'product_endpoints.dart';

extension WooProductApi on WooCommerce {
  Future<WooPage<WooProduct>> getProducts({
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
    WooSort order = WooSort.desc,
    WooOrderBy orderBy = WooOrderBy.date,
    List<int>? parent,
    List<int>? parentExclude,
    String? slug,
    WooProductStatus? status,
    WooProductType? type,
    String? sku,
    bool? featured,
    int? category,
    int? tag,
    int? shippingClass,
    String? attribute,
    String? attributeTerm,
    String? taxClass,
    bool? onSale,
    double? minPrice,
    double? maxPrice,
    WooProductStockStatus? stockStatus,
    String? currency,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooPage(
        items: List.generate(perPage ?? 10, (_) => WooProduct.fake()),
        page: page ?? 1,
      );
    }
    final query = WooProductQuery(
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
      slug: slug,
      status: status,
      type: type,
      sku: sku,
      featured: featured,
      category: category,
      tag: tag,
      shippingClass: shippingClass,
      attribute: attribute,
      attributeTerm: attributeTerm,
      taxClass: taxClass,
      onSale: onSale,
      minPrice: minPrice,
      maxPrice: maxPrice,
      stockStatus: stockStatus,
      currency: currency,
    );
    final response = await requestGet<List<dynamic>>(
      _ProductEndpoints.products,
      queryParameters: query.toMap(),
    );
    final items = response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooProduct.fromJson)
            .toList() ??
        const [];
    return WooPage.parse(response: response, items: items, page: page ?? 1);
  }

  Future<WooProduct> getProduct(int id, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProduct.fake();
    }
    final response = await requestGet<Map<String, dynamic>>(
      _ProductEndpoints.singleProduct(id),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected a product object for product $id',
        statusCode: response.statusCode,
        path: _ProductEndpoints.singleProduct(id),
      );
    }
    return WooProduct.fromJson(data);
  }

  Future<WooProductWithChildren> getProductWithOptions(
    WooProduct product,
    List<WooProductFilterWithType> types, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductWithChildren.fake().copyWith(mainProduct: product);
    }
    final response = await requestGet<List<dynamic>>(
      _ProductEndpoints.products,
      queryParameters:
          _resolveQueryParametersForGettingProductWithOption(types, product),
    );
    final data = response.data?.whereType<Map<String, dynamic>>().toList();
    if (data == null) {
      throw WooCommerceParseException(
        message: 'Expected a list of products for product ${product.id}',
        statusCode: response.statusCode,
        path: _ProductEndpoints.products,
      );
    }
    return WooProductWithChildren.fromData(data, product);
  }

  Map<String, dynamic> _resolveQueryParametersForGettingProductWithOption(
      List<WooProductFilterWithType> options, WooProduct product) {
    final map = <String, dynamic>{};
    final includes = <int>[product.id!];
    for (final option in options) {
      if (option == WooProductFilterWithType.crossSellIds) {
        includes.addAll(product.crossSellIds ?? []);
      }
      if (option == WooProductFilterWithType.groupedProducts) {
        includes.addAll(product.groupedProducts ?? []);
      }
      if (option == WooProductFilterWithType.relatedIds) {
        includes.addAll(product.relatedIds ?? []);
      }
      if (option == WooProductFilterWithType.upsellIds) {
        includes.addAll(product.upsellIds ?? []);
      }
      if (option == WooProductFilterWithType.variations) {
        includes.addAll(product.variations ?? []);
      }
      if (option == WooProductFilterWithType.parentId) {
        if (product.parentId case final id?) {
          includes.add(id);
        }
      }
    }
    map['include'] = includes.join(',');
    return map;
  }

  Future<WooProduct> createProduct(
    WooProduct product, {
    String? currency,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProduct.fake();
    }
    final response = await requestPost<Map<String, dynamic>>(
      _ProductEndpoints.products,
      data: product.toJson(),
      queryParameters: currency == null ? null : {'currency': currency},
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected a product object in the create response',
        statusCode: response.statusCode,
        path: _ProductEndpoints.products,
      );
    }
    return WooProduct.fromJson(data);
  }

  Future<WooProduct> duplicateProduct(int productId, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProduct.fake();
    }
    final response = await requestPost<Map<String, dynamic>>(
      _ProductEndpoints.duplicateProduct(productId),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected a product object in the duplicate response',
        statusCode: response.statusCode,
        path: _ProductEndpoints.duplicateProduct(productId),
      );
    }
    return WooProduct.fromJson(data);
  }

  Future<WooProduct> updateProduct(
    int id,
    WooProduct product, {
    String? currency,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProduct.fake();
    }
    final response = await requestPut<Map<String, dynamic>>(
      _ProductEndpoints.singleProduct(id),
      data: product.toJson(),
      queryParameters: currency == null ? null : {'currency': currency},
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected a product object in the update response',
        statusCode: response.statusCode,
        path: _ProductEndpoints.singleProduct(id),
      );
    }
    return WooProduct.fromJson(data);
  }

  Future<WooDeleteResult> deleteProduct(
    int id, {
    bool force = false,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooDeleteResult(id: id, deleted: true);
    }
    final response = await requestDelete<Map<String, dynamic>>(
      _ProductEndpoints.singleProduct(id),
      queryParameters: {'force': force},
    );
    return WooDeleteResult.fromJson(response.data!);
  }

  Future<WooProductBatchResponse> batchUpdateProducts(
    WooProductBatchRequest request, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductBatchResponse(
        create: request.create?.map((product) => WooProduct.fake()).toList(),
        update: request.update,
        delete: request.delete?.map((id) => WooProduct.fake()).toList(),
      );
    }
    final response = await requestPost<Map<String, dynamic>>(
      _ProductEndpoints.batchProducts(),
      data: request.toJson(),
    );
    return WooProductBatchResponse.fromJson(response.data!);
  }
}
