import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

part 'data_endpoints.dart';

extension WooDataApi on WooCommerce {
  Future<List<WooDataEndpoint>> listData({bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooDataEndpoint.fake);
    }

    final response = await dio.get(_DataEndpoints.data);
    return (response.data as List).map((e) => WooDataEndpoint.fromJson(e)).toList();
  }

  Future<List<WooContinent>> getContinents({bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooContinent.fake);
    }

    final response = await dio.get(_DataEndpoints.continents);
    return (response.data as List).map((e) => WooContinent.fromJson(e)).toList();
  }

  Future<WooContinent> getContinent(String location, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooContinent.fake();
    }

    final response = await dio.get(_DataEndpoints.continent(location));
    return WooContinent.fromJson(response.data);
  }

  Future<List<WooCountry>> getCountries({bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooCountry.fake);
    }

    final response = await dio.get(_DataEndpoints.countries);
    return (response.data as List).map((e) => WooCountry.fromJson(e)).toList();
  }

  Future<WooCountry> getCountry(String location, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooCountry.fake();
    }

    final response = await dio.get(_DataEndpoints.country(location));
    return WooCountry.fromJson(response.data);
  }

  Future<List<WooCurrency>> getCurrencies({bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return FakeHelper.list(WooCurrency.fake);
    }

    final response = await dio.get(_DataEndpoints.currencies);
    return (response.data as List).map((e) => WooCurrency.fromJson(e)).toList();
  }

  Future<WooCurrency> getCurrency(String code, {bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooCurrency.fake();
    }

    final response = await dio.get(_DataEndpoints.currency(code));
    return WooCurrency.fromJson(response.data);
  }

  Future<WooCurrency> getCurrentCurrency({bool? useFaker}) async {
    final isUsingFaker = useFaker ?? this.useFaker;

    if (isUsingFaker) {
      return WooCurrency.fake();
    }

    final response = await dio.get(_DataEndpoints.currentCurrency);
    return WooCurrency.fromJson(response.data);
  }
}