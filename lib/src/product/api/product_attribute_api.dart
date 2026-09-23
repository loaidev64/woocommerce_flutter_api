import '../../base/enums/context.dart';
import '../../base/enums/sort.dart';
import '../../base/models/woo_delete_result.dart';
import '../../exceptions/woocommerce_exception.dart';
import '../../pagination/woo_page.dart';
import '../../woocommerce_flutter_api_base.dart';
import '../models/product_attribute.dart';
import '../models/product_attribute_batch_request.dart';
import '../models/product_attribute_batch_response.dart';
import '../models/product_attribute_term.dart';
import '../models/product_attribute_term_batch_request.dart';
import '../models/product_attribute_term_batch_response.dart';
import 'product_attribute_query.dart';
import 'product_attribute_term_query.dart';
part 'product_attribute_endpoints.dart';

extension WooProductAttributeApi on WooCommerce {
  Future<WooPage<WooProductAttribute>> getProductAttributes({
    WooContext context = WooContext.view,
    int? page,
    int? perPage,
    String? search,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooPage(
        items: List.generate(perPage ?? 10, (_) => WooProductAttribute.fake()),
        page: page ?? 1,
      );
    }
    final query = WooProductAttributeQuery(
      context: context,
      page: page,
      perPage: perPage,
      search: search,
    );
    final response = await requestGet<List<dynamic>>(
      _ProductAttributeEndpoints.attributes,
      queryParameters: query.toMap(),
    );
    final items = response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooProductAttribute.fromJson)
            .toList() ??
        const [];
    return WooPage.parse(response: response, items: items, page: page ?? 1);
  }

  Future<WooProductAttribute> getProductAttribute(
    int id, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductAttribute.fake();
    }
    final response = await requestGet<Map<String, dynamic>>(
      _ProductAttributeEndpoints.singleAttribute(id),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected an attribute object for attribute $id',
        statusCode: response.statusCode,
        path: _ProductAttributeEndpoints.singleAttribute(id),
      );
    }
    return WooProductAttribute.fromJson(data);
  }

  Future<WooProductAttribute> createProductAttribute(
    WooProductAttribute attribute, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductAttribute.fake();
    }
    final response = await requestPost<Map<String, dynamic>>(
      _ProductAttributeEndpoints.attributes,
      data: attribute.toJson(),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected an attribute object in the create response',
        statusCode: response.statusCode,
        path: _ProductAttributeEndpoints.attributes,
      );
    }
    return WooProductAttribute.fromJson(data);
  }

  Future<WooProductAttribute> updateProductAttribute(
    int id,
    WooProductAttribute attribute, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductAttribute.fake(id: id);
    }
    final response = await requestPut<Map<String, dynamic>>(
      _ProductAttributeEndpoints.singleAttribute(id),
      data: attribute.toJson(),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected an attribute object in the update response',
        statusCode: response.statusCode,
        path: _ProductAttributeEndpoints.singleAttribute(id),
      );
    }
    return WooProductAttribute.fromJson(data);
  }

  Future<WooDeleteResult> deleteProductAttribute(
    int id, {
    bool force = true,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooDeleteResult(id: id, deleted: true);
    }
    final response = await requestDelete<Map<String, dynamic>>(
      _ProductAttributeEndpoints.singleAttribute(id),
      queryParameters: {'force': force},
    );
    return WooDeleteResult.fromJson(response.data!);
  }

  Future<WooProductAttributeBatchResponse> batchUpdateProductAttributes(
    WooProductAttributeBatchRequest request, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductAttributeBatchResponse(
        create: request.create
            ?.map((attribute) => WooProductAttribute.fake())
            .toList(),
        update: request.update,
        delete: request.delete
            ?.map((id) => WooProductAttribute.fake(id: id))
            .toList(),
      );
    }
    final response = await requestPost<Map<String, dynamic>>(
      _ProductAttributeEndpoints.batchAttributes(),
      data: request.toJson(),
    );
    return WooProductAttributeBatchResponse.fromJson(response.data!);
  }

  Future<WooPage<WooProductAttributeTerm>> getProductAttributeTerms(
    int attributeId, {
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
            List.generate(perPage ?? 10, (_) => WooProductAttributeTerm.fake()),
        page: page ?? 1,
      );
    }
    final query = WooProductAttributeTermQuery(
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
      _ProductAttributeEndpoints.attributeTerms(attributeId),
      queryParameters: query.toMap(),
    );
    final items = response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooProductAttributeTerm.fromJson)
            .toList() ??
        const [];
    return WooPage.parse(response: response, items: items, page: page ?? 1);
  }

  Future<WooProductAttributeTerm> getProductAttributeTerm(
    int attributeId,
    int termId, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductAttributeTerm.fake();
    }
    final response = await requestGet<Map<String, dynamic>>(
      _ProductAttributeEndpoints.singleAttributeTerm(attributeId, termId),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected a term object for term $termId',
        statusCode: response.statusCode,
        path:
            _ProductAttributeEndpoints.singleAttributeTerm(attributeId, termId),
      );
    }
    return WooProductAttributeTerm.fromJson(data);
  }

  Future<WooProductAttributeTerm> createProductAttributeTerm(
    int attributeId,
    WooProductAttributeTerm term, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductAttributeTerm.fake();
    }
    final response = await requestPost<Map<String, dynamic>>(
      _ProductAttributeEndpoints.attributeTerms(attributeId),
      data: term.toJson(),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected a term object in the create response',
        statusCode: response.statusCode,
        path: _ProductAttributeEndpoints.attributeTerms(attributeId),
      );
    }
    return WooProductAttributeTerm.fromJson(data);
  }

  Future<WooProductAttributeTerm> updateProductAttributeTerm(
    int attributeId,
    int termId,
    WooProductAttributeTerm term, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductAttributeTerm.fake(id: termId);
    }
    final response = await requestPut<Map<String, dynamic>>(
      _ProductAttributeEndpoints.singleAttributeTerm(attributeId, termId),
      data: term.toJson(),
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw WooCommerceParseException(
        message: 'Expected a term object in the update response',
        statusCode: response.statusCode,
        path:
            _ProductAttributeEndpoints.singleAttributeTerm(attributeId, termId),
      );
    }
    return WooProductAttributeTerm.fromJson(data);
  }

  Future<WooDeleteResult> deleteProductAttributeTerm(
    int attributeId,
    int termId, {
    bool force = true,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooDeleteResult(id: termId, deleted: true);
    }
    final response = await requestDelete<Map<String, dynamic>>(
      _ProductAttributeEndpoints.singleAttributeTerm(attributeId, termId),
      queryParameters: {'force': force},
    );
    return WooDeleteResult.fromJson(response.data!);
  }

  Future<WooProductAttributeTermBatchResponse> batchUpdateProductAttributeTerms(
    int attributeId,
    WooProductAttributeTermBatchRequest request, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooProductAttributeTermBatchResponse(
        create: request.create
            ?.map((term) => WooProductAttributeTerm.fake())
            .toList(),
        update: request.update,
        delete: request.delete
            ?.map((id) => WooProductAttributeTerm.fake(id: id))
            .toList(),
      );
    }
    final response = await requestPost<Map<String, dynamic>>(
      _ProductAttributeEndpoints.batchAttributeTerms(attributeId),
      data: request.toJson(),
    );
    return WooProductAttributeTermBatchResponse.fromJson(response.data!);
  }
}
