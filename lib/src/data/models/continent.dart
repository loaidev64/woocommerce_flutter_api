import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

class WooContinent {
  final String? code;
  final String? name;
  final List<CountryInContinent>? countries;

  WooContinent({this.code, this.name, this.countries});

  factory WooContinent.fromJson(Map<String, dynamic> json) => WooContinent(
    code: json['code'],
    name: json['name'],
    countries: json['countries'] != null 
        ? (json['countries'] as List).map((e) => CountryInContinent.fromJson(e)).toList()
        : null,
  );

  factory WooContinent.fake() => WooContinent(
    code: FakeHelper.countryCode(),
    name: FakeHelper.country(),
    countries: FakeHelper.list(() => CountryInContinent.fake()),
  );
}

class CountryInContinent {
  final String? code;
  final String? currencyCode;
  final String? currencyPos;
  final String? decimalSep;
  final String? dimensionUnit;
  final String? name;
  final int? numDecimals;
  final List<StateInCountry>? states;
  final String? thousandSep;
  final String? weightUnit;

  CountryInContinent({
    this.code,
    this.currencyCode,
    this.currencyPos,
    this.decimalSep,
    this.dimensionUnit,
    this.name,
    this.numDecimals,
    this.states,
    this.thousandSep,
    this.weightUnit,
  });

  factory CountryInContinent.fromJson(Map<String, dynamic> json) => CountryInContinent(
    code: json['code'],
    currencyCode: json['currency_code'],
    currencyPos: json['currency_pos'],
    decimalSep: json['decimal_sep'],
    dimensionUnit: json['dimension_unit'],
    name: json['name'],
    numDecimals: json['num_decimals'],
    states: json['states'] != null
        ? (json['states'] as List).map((e) => StateInCountry.fromJson(e)).toList()
        : null,
    thousandSep: json['thousand_sep'],
    weightUnit: json['weight_unit'],
  );

  factory CountryInContinent.fake() => CountryInContinent(
    code: FakeHelper.countryCode(),
    currencyCode: FakeHelper.currencyCode(),
    currencyPos: FakeHelper.word(),
    decimalSep: FakeHelper.word(),
    dimensionUnit: FakeHelper.word(),
    name: FakeHelper.country(),
    numDecimals: FakeHelper.integer(max: 3),
    states: FakeHelper.list(() => StateInCountry.fake()),
    thousandSep: FakeHelper.word(),
    weightUnit: FakeHelper.word(),
  );
}

class StateInCountry {
  final String? code;
  final String? name;

  StateInCountry({this.code, this.name});

  factory StateInCountry.fromJson(Map<String, dynamic> json) => StateInCountry(
    code: json['code'],
    name: json['name'],
  );

  factory StateInCountry.fake() => StateInCountry(
    code: FakeHelper.word(),
    name: FakeHelper.state(),
  );
}