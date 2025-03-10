import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'tax_class_endpoints.dart';

extension WooTaxClassApi on WooCommerce {
  Future<List<WooTaxClass>> getTaxClasses({
    bool? useFaker,
  }) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooTaxClass.fake);
    }

    final response = await dio.get(
      _TaxRateEndpoints.taxeClasses,
    );

    return (response.data as List)
        .map((item) => WooTaxClass.fromJson(item))
        .toList();
  }

  Future<WooTaxClass> createTaxClass(WooTaxClass taxClass,
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return taxClass;
    }

    final response = await dio.post(
      _TaxRateEndpoints.taxeClasses,
      data: taxClass.toJson(),
    );

    return WooTaxClass.fromJson(response.data);
  }

  Future<void> deleteTaxClass(WooTaxClass taxClass, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return;
    }

    await dio.delete(
      _TaxRateEndpoints.singleTaxClass(taxClass.slug!),
      queryParameters: {
        'force': true,
      },
    );
  }
}
