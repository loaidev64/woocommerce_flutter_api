import '../../base/models/woo_delete_result.dart';
import '../../helpers/fake_helper.dart';
import '../../woocommerce_flutter_api_base.dart';
import '../models/tax_class.dart';
part 'tax_class_endpoints.dart';

extension WooTaxClassApi on WooCommerce {
  Future<List<WooTaxClass>> getTaxClasses({bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return FakeHelper.list(WooTaxClass.fake);
    }
    final response =
        await requestGet<List<dynamic>>(_TaxClassEndpoints.classes);
    return response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooTaxClass.fromJson)
            .toList() ??
        [];
  }

  Future<WooTaxClass> createTaxClass(WooTaxClass taxClass,
      {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return taxClass;
    }
    final response = await requestPost<Map<String, dynamic>>(
      _TaxClassEndpoints.classes,
      data: taxClass.toJson(),
    );
    return WooTaxClass.fromJson(response.data!);
  }

  Future<WooDeleteResult> deleteTaxClass(String slug, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return const WooDeleteResult(id: null, deleted: true);
    }
    final response = await requestDelete<Map<String, dynamic>>(
      _TaxClassEndpoints.singleClass(slug),
      queryParameters: const {'force': true},
    );
    return WooDeleteResult.fromJson(response.data!);
  }
}
