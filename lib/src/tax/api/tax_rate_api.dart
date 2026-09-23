import '../../base/models/woo_delete_result.dart';
import '../../pagination/woo_page.dart';
import '../../woocommerce_flutter_api_base.dart';
import '../../base/enums/context.dart';
import '../../base/enums/sort.dart';
import '../models/models.dart';
import 'tax_rate_query.dart';
export 'tax_rate_query.dart';
part 'tax_rate_endpoints.dart';

extension WooTaxRateApi on WooCommerce {
  Future<WooPage<WooTaxRate>> getTaxRates({
    WooContext context = WooContext.view,
    int? page,
    int? perPage,
    int? offset,
    WooSort? order,
    WooOrderBy? orderBy,
    String? taxClass,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooPage(
        items: List.generate(perPage ?? 10, (_) => WooTaxRate.fake()),
        page: page ?? 1,
      );
    }
    final query = WooTaxRateQuery(
      page: page,
      perPage: perPage,
      offset: offset,
      order: order,
      orderBy: orderBy,
      context: context,
      taxClass: taxClass,
    );
    final response = await requestGet<List<dynamic>>(
      _TaxRateEndpoints.taxes,
      queryParameters: query.toMap(),
    );
    final items = response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooTaxRate.fromJson)
            .toList() ??
        const [];
    return WooPage.parse(response: response, items: items, page: page ?? 1);
  }

  Future<WooTaxRate> getTaxRate(int id, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooTaxRate.fake(id: id);
    }
    final response = await requestGet<Map<String, dynamic>>(
      _TaxRateEndpoints.singleTax(id),
    );
    return WooTaxRate.fromJson(response.data!);
  }

  Future<WooTaxRate> createTaxRate(WooTaxRate taxRate, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return taxRate;
    }
    final response = await requestPost<Map<String, dynamic>>(
      _TaxRateEndpoints.taxes,
      data: taxRate.toJson(),
    );
    return WooTaxRate.fromJson(response.data!);
  }

  Future<WooTaxRate> updateTaxRate(
    int id,
    WooTaxRate taxRate, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return taxRate;
    }
    final response = await requestPut<Map<String, dynamic>>(
      _TaxRateEndpoints.singleTax(id),
      data: taxRate.toJson(),
    );
    return WooTaxRate.fromJson(response.data!);
  }

  Future<WooDeleteResult> deleteTaxRate(int id, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooDeleteResult(id: id, deleted: true);
    }
    final response = await requestDelete<Map<String, dynamic>>(
      _TaxRateEndpoints.singleTax(id),
      queryParameters: const {'force': true},
    );
    return WooDeleteResult.fromJson(response.data!);
  }

  Future<WooTaxRateBatchResponse> batchUpdateTaxRates(
    WooTaxRateBatchRequest request, {
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooTaxRateBatchResponse(
        create: request.create?.map((_) => WooTaxRate.fake()).toList(),
        update: request.update,
        delete: request.delete?.map((id) => WooTaxRate.fake(id: id)).toList(),
      );
    }
    final response = await requestPost<Map<String, dynamic>>(
      _TaxRateEndpoints.batch,
      data: request.toJson(),
    );
    return WooTaxRateBatchResponse.fromJson(response.data!);
  }
}
