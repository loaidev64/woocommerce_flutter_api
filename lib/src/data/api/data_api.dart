import '../../helpers/fake_helper.dart';
import '../../woocommerce_flutter_api_base.dart';
import '../models/continent.dart';
import '../models/country.dart';
import '../models/data_currency.dart';
import '../models/data_endpoint.dart';
part 'data_endpoints.dart';

extension WooDataApi on WooCommerce {
  Future<List<WooDataEndpoint>> listData({bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return FakeHelper.list(WooDataEndpoint.fake);
    }
    final response = await requestGet<List<dynamic>>(_DataEndpoints.data);
    return response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooDataEndpoint.fromJson)
            .toList() ??
        [];
  }

  Future<List<WooContinent>> getContinents({bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return FakeHelper.list(WooContinent.fake);
    }
    final response = await requestGet<List<dynamic>>(_DataEndpoints.continents);
    return response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooContinent.fromJson)
            .toList() ??
        [];
  }

  Future<WooContinent> getContinent(String location, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooContinent.fake();
    }
    final response = await requestGet<Map<String, dynamic>>(
      _DataEndpoints.continent(location),
    );
    return WooContinent.fromJson(response.data!);
  }

  Future<List<WooCountry>> getCountries({bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return FakeHelper.list(WooCountry.fake);
    }
    final response = await requestGet<List<dynamic>>(_DataEndpoints.countries);
    return response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooCountry.fromJson)
            .toList() ??
        [];
  }

  Future<WooCountry> getCountry(String location, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooCountry.fake();
    }
    final response = await requestGet<Map<String, dynamic>>(
      _DataEndpoints.country(location),
    );
    return WooCountry.fromJson(response.data!);
  }

  Future<List<WooDataCurrency>> getCurrencies({bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return FakeHelper.list(WooDataCurrency.fake);
    }
    final response = await requestGet<List<dynamic>>(_DataEndpoints.currencies);
    return response.data
            ?.whereType<Map<String, dynamic>>()
            .map(WooDataCurrency.fromJson)
            .toList() ??
        [];
  }

  Future<WooDataCurrency> getCurrency(String code, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooDataCurrency.fake();
    }
    final response = await requestGet<Map<String, dynamic>>(
      _DataEndpoints.currency(code),
    );
    return WooDataCurrency.fromJson(response.data!);
  }

  Future<WooDataCurrency> getCurrentCurrency({bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;
    if (isUsingFaker) {
      return WooDataCurrency.fake();
    }
    final response = await requestGet<Map<String, dynamic>>(
      _DataEndpoints.currentCurrency,
    );
    return WooDataCurrency.fromJson(response.data!);
  }
}
