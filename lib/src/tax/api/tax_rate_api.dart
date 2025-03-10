import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'tax_rate_endpoints.dart';

extension WooTaxRateApi on WooCommerce {
  /// Fetches a list of tax rates.
  ///
  /// [context] Scope under which the request is made; determines fields present in response. Options: view and edit. Default is view.
  ///
  /// [page] Current page of the collection. Default is 1.
  ///
  /// [perPage] Maximum number of items to be returned in result set. Default is 10.
  ///
  /// [offset] Offset the result set by a specific number of items.
  ///
  /// [order] Order sort attribute ascending or descending. Options: asc and desc. Default is desc.
  ///
  /// [orderBy] Sort collection by object attribute. Options: date, id, include, title, slug, price, popularity and rating. Default is date.
  ///
  /// [taxClass] Retrieve only tax rates of this Tax class.
  ///
  /// [useFaker] If true, returns fake data for testing purposes.
  Future<List<WooTaxRate>> getTaxRates({
    WooContext context = WooContext.view,
    int page = 1,
    int perPage = 10,
    int? offset,
    WooSortOrder order = WooSortOrder.desc,
    WooTaxRateOrderBy orderBy = WooTaxRateOrderBy.date,
    String? taxClass,
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return List.generate(perPage, (index) => WooTaxRate.fake());
    }

    final response = await dio.get(
      _TaxRateEndpoints.taxes,
      queryParameters: _resolveQueryParametersForTaxRates(
        context: context,
        page: page,
        perPage: perPage,
        offset: offset,
        order: order,
        orderBy: orderBy,
        taxClass: taxClass,
      ),
    );

    return (response.data as List)
        .map((item) => WooTaxRate.fromJson(item))
        .toList();
  }

  /// Resolves query parameters for the tax rates API request.
  Map<String, dynamic> _resolveQueryParametersForTaxRates({
    required WooContext context,
    required int? page,
    required int? perPage,
    required int? offset,
    required WooSortOrder? order,
    required WooTaxRateOrderBy? orderBy,
    required String? taxClass,
  }) {
    final map = <String, dynamic>{
      'context': context.name,
    };

    if (page != null) {
      map['page'] = page;
    }

    if (perPage != null) {
      map['per_page'] = perPage;
    }

    if (offset != null) {
      map['offset'] = offset;
    }

    if (order != null) {
      map['order'] = order.name;
    }

    if (orderBy != null) {
      map['orderby'] = orderBy.name;
    }

    if (taxClass != null) {
      map['class'] = taxClass;
    }

    return map;
  }

  Future<WooTaxRate> getTaxRate(int id, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooTaxRate.fake();
    }

    final response = await dio.get(
      _TaxRateEndpoints.singleTax(id),
    );

    return WooTaxRate.fromJson(response.data);
  }

  Future<WooTaxRate> createTaxRate(WooTaxRate taxRate, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return taxRate;
    }

    final response = await dio.post(
      _TaxRateEndpoints.taxes,
      data: taxRate.toJson(),
    );

    return WooTaxRate.fromJson(response.data);
  }

  Future<WooTaxRate> updateTaxRate(WooTaxRate taxRate, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return taxRate;
    }

    final response = await dio.put(
      _TaxRateEndpoints.singleTax(taxRate.id!),
      data: taxRate.toJson(),
    );

    return WooTaxRate.fromJson(response.data);
  }

  Future<void> deleteTaxRate(int taxRateId, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return;
    }

    await dio.delete(
      _TaxRateEndpoints.singleTax(taxRateId),
      queryParameters: {
        'force': true,
      },
    );
  }
}
