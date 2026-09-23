import '../../base/enums/context.dart';
import '../../base/enums/sort.dart';
import '../../base/models/woo_delete_result.dart';
import '../../exceptions/woocommerce_exception.dart';
import '../../pagination/woo_page.dart';
import '../../woocommerce_flutter_api_base.dart';
import '../models/category.dart';
import '../models/category_batch_request.dart';
import '../models/category_batch_response.dart';
import 'category_query.dart';
part 'endpoints.dart';

extension WooCategoryApi on WooCommerce {
  Future<WooPage<WooProductCategory>> getCategories({
    WooContext context = WooContext.view,
    int? page,
    int? perPage,
    String? search,
    List<int>? exclude,
    List<int>? include,
    WooSort order = WooSort.desc,
    WooOrderBy orderBy = WooOrderBy.name,
    bool? hideEmpty,
    int? parent,
    int? product,
    String? slug,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooPage(
        items: List.generate(perPage ?? 10, (_) => WooProductCategory.fake()),
        page: page ?? 1,
      );
    }
    final query = WooCategoryQuery(
      context: context,
      page: page,
      perPage: perPage,
      search: search,
      exclude: exclude,
      include: include,
      order: order,
      orderBy: orderBy,
      hideEmpty: hideEmpty,
      parent: parent,
      product: product,
      slug: slug,
    );
    final response = await requestGet<List<dynamic>>(
      _CategoryEndpoints.categories,
      queryParameters: query.toMap(),
    );
    final items = response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooProductCategory.fromJson)
            .toList() ??
        const [];
    return WooPage.parse(response: response, items: items, page: page ?? 1);
  }

  Future<WooProductCategory> getCategory(int id, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductCategory.fake();
    }
    final response = await requestGet<Map<String, dynamic>>(
      _CategoryEndpoints.singleCategory(id),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected a category object for category $id',
        statusCode: response.statusCode,
        path: _CategoryEndpoints.singleCategory(id),
      );
    }
    return WooProductCategory.fromJson(data);
  }

  Future<WooProductCategory> createCategory(
    WooProductCategory category, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductCategory.fake();
    }
    final response = await requestPost<Map<String, dynamic>>(
      _CategoryEndpoints.categories,
      data: category.toJson(),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected a category object in the create response',
        statusCode: response.statusCode,
        path: _CategoryEndpoints.categories,
      );
    }
    return WooProductCategory.fromJson(data);
  }

  Future<WooProductCategory> updateCategory(
    int id,
    WooProductCategory category, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductCategory.fake();
    }
    final response = await requestPut<Map<String, dynamic>>(
      _CategoryEndpoints.singleCategory(id),
      data: category.toJson(),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected a category object in the update response',
        statusCode: response.statusCode,
        path: _CategoryEndpoints.singleCategory(id),
      );
    }
    return WooProductCategory.fromJson(data);
  }

  Future<WooDeleteResult> deleteCategory(
    int id, {
    bool force = false,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooDeleteResult(id: id, deleted: true);
    }
    final response = await requestDelete<Map<String, dynamic>>(
      _CategoryEndpoints.singleCategory(id),
      queryParameters: {'force': force},
    );
    return WooDeleteResult.fromJson(response.data!);
  }

  Future<WooProductCategoryBatchResponse> batchUpdateCategories(
    WooProductCategoryBatchRequest request, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductCategoryBatchResponse(
        create: request.create
            ?.map((category) => WooProductCategory.fake())
            .toList(),
        update: request.update,
        delete: request.delete?.map((id) => WooProductCategory.fake()).toList(),
      );
    }
    final response = await requestPost<Map<String, dynamic>>(
      _CategoryEndpoints.batchCategories(),
      data: request.toJson(),
    );
    return WooProductCategoryBatchResponse.fromJson(response.data!);
  }
}
