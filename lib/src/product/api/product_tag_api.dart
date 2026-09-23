import '../../base/enums/context.dart';
import '../../base/enums/sort.dart';
import '../../base/models/woo_delete_result.dart';
import '../../exceptions/woocommerce_exception.dart';
import '../../pagination/woo_page.dart';
import '../../woocommerce_flutter_api_base.dart';
import '../models/product_tag.dart';
import '../models/product_tag_batch_request.dart';
import '../models/product_tag_batch_response.dart';
import 'product_tag_query.dart';
part 'product_tag_endpoints.dart';

extension WooProductTagApi on WooCommerce {
  Future<WooPage<WooProductTag>> getProductTags({
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
        items: List.generate(perPage ?? 10, (_) => WooProductTag.fake()),
        page: page ?? 1,
      );
    }
    final query = WooProductTagQuery(
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
      _ProductTagEndpoints.tags,
      queryParameters: query.toMap(),
    );
    final items = response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooProductTag.fromJson)
            .toList() ??
        const [];
    return WooPage.parse(response: response, items: items, page: page ?? 1);
  }

  Future<WooProductTag> getProductTag(int id, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductTag.fake();
    }
    final response = await requestGet<Map<String, dynamic>>(
      _ProductTagEndpoints.singleTag(id),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected a tag object for tag $id',
        statusCode: response.statusCode,
        path: _ProductTagEndpoints.singleTag(id),
      );
    }
    return WooProductTag.fromJson(data);
  }

  Future<WooProductTag> createProductTag(
    WooProductTag tag, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductTag.fake();
    }
    final response = await requestPost<Map<String, dynamic>>(
      _ProductTagEndpoints.tags,
      data: tag.toJson(),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected a tag object in the create response',
        statusCode: response.statusCode,
        path: _ProductTagEndpoints.tags,
      );
    }
    return WooProductTag.fromJson(data);
  }

  Future<WooProductTag> updateProductTag(
    int id,
    WooProductTag tag, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductTag.fake(tagId: id);
    }
    final response = await requestPut<Map<String, dynamic>>(
      _ProductTagEndpoints.singleTag(id),
      data: tag.toJson(),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected a tag object in the update response',
        statusCode: response.statusCode,
        path: _ProductTagEndpoints.singleTag(id),
      );
    }
    return WooProductTag.fromJson(data);
  }

  Future<WooDeleteResult> deleteProductTag(int id, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooDeleteResult(id: id, deleted: true);
    }
    final response = await requestDelete<Map<String, dynamic>>(
      _ProductTagEndpoints.singleTag(id),
      queryParameters: {'force': true},
    );
    return WooDeleteResult.fromJson(response.data!);
  }

  Future<WooProductTagBatchResponse> batchUpdateProductTags(
    WooProductTagBatchRequest request, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductTagBatchResponse(
        create: request.create?.map((tag) => WooProductTag.fake()).toList(),
        update: request.update,
        delete:
            request.delete?.map((id) => WooProductTag.fake(tagId: id)).toList(),
      );
    }
    final response = await requestPost<Map<String, dynamic>>(
      _ProductTagEndpoints.batchTags(),
      data: request.toJson(),
    );
    return WooProductTagBatchResponse.fromJson(response.data!);
  }
}
