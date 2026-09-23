import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';
import 'country.dart';

class WooContinent {
  WooContinent({this.code, this.name, this.countries});
  factory WooContinent.fromJson(Map<String, dynamic> json) => WooContinent(
        code: WooJson.readString(json, 'code'),
        name: WooJson.readString(json, 'name'),
        countries:
            WooJson.readList(json, 'countries', CountryInContinent.fromJson),
      );
  factory WooContinent.fake() => WooContinent(
        code: FakeHelper.countryCode(),
        name: FakeHelper.country(),
        countries: FakeHelper.list(CountryInContinent.fake),
      );
  final String? code;
  final String? name;
  final List<CountryInContinent>? countries;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('code', code)
    ..putIfPresent('name', name)
    ..putIfPresent('countries', countries?.map((e) => e.toJson()).toList());
  WooContinent copyWith({
    String? code,
    String? name,
    List<CountryInContinent>? countries,
  }) =>
      WooContinent(
        code: code ?? this.code,
        name: name ?? this.name,
        countries: countries ?? this.countries,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooContinent &&
        other.code == code &&
        other.name == name &&
        WooJson.listEquals(other.countries, countries);
  }

  @override
  int get hashCode =>
      Object.hash(code, name, Object.hashAll(countries ?? const []));
  @override
  String toString() => 'WooContinent(code: $code, name: $name)';
}

class CountryInContinent {
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
  factory CountryInContinent.fromJson(Map<String, dynamic> json) =>
      CountryInContinent(
        code: WooJson.readString(json, 'code'),
        currencyCode: WooJson.readString(json, 'currency_code'),
        currencyPos: WooJson.readString(json, 'currency_pos'),
        decimalSep: WooJson.readString(json, 'decimal_sep'),
        dimensionUnit: WooJson.readString(json, 'dimension_unit'),
        name: WooJson.readString(json, 'name'),
        numDecimals: WooJson.readInt(json, 'num_decimals'),
        states: WooJson.readList(json, 'states', StateInCountry.fromJson),
        thousandSep: WooJson.readString(json, 'thousand_sep'),
        weightUnit: WooJson.readString(json, 'weight_unit'),
      );
  factory CountryInContinent.fake() => CountryInContinent(
        code: FakeHelper.countryCode(),
        currencyCode: FakeHelper.currencyCode(),
        currencyPos: FakeHelper.word(),
        decimalSep: FakeHelper.word(),
        dimensionUnit: FakeHelper.word(),
        name: FakeHelper.country(),
        numDecimals: FakeHelper.integer(max: 3),
        states: FakeHelper.list(StateInCountry.fake),
        thousandSep: FakeHelper.word(),
        weightUnit: FakeHelper.word(),
      );
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
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('code', code)
    ..putIfPresent('currency_code', currencyCode)
    ..putIfPresent('currency_pos', currencyPos)
    ..putIfPresent('decimal_sep', decimalSep)
    ..putIfPresent('dimension_unit', dimensionUnit)
    ..putIfPresent('name', name)
    ..putIfPresent('num_decimals', numDecimals)
    ..putIfPresent('states', states?.map((e) => e.toJson()).toList())
    ..putIfPresent('thousand_sep', thousandSep)
    ..putIfPresent('weight_unit', weightUnit);
  CountryInContinent copyWith({
    String? code,
    String? currencyCode,
    String? currencyPos,
    String? decimalSep,
    String? dimensionUnit,
    String? name,
    int? numDecimals,
    List<StateInCountry>? states,
    String? thousandSep,
    String? weightUnit,
  }) =>
      CountryInContinent(
        code: code ?? this.code,
        currencyCode: currencyCode ?? this.currencyCode,
        currencyPos: currencyPos ?? this.currencyPos,
        decimalSep: decimalSep ?? this.decimalSep,
        dimensionUnit: dimensionUnit ?? this.dimensionUnit,
        name: name ?? this.name,
        numDecimals: numDecimals ?? this.numDecimals,
        states: states ?? this.states,
        thousandSep: thousandSep ?? this.thousandSep,
        weightUnit: weightUnit ?? this.weightUnit,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CountryInContinent &&
        other.code == code &&
        other.currencyCode == currencyCode &&
        other.currencyPos == currencyPos &&
        other.decimalSep == decimalSep &&
        other.dimensionUnit == dimensionUnit &&
        other.name == name &&
        other.numDecimals == numDecimals &&
        WooJson.listEquals(other.states, states) &&
        other.thousandSep == thousandSep &&
        other.weightUnit == weightUnit;
  }

  @override
  int get hashCode => Object.hashAll([
        code,
        currencyCode,
        currencyPos,
        decimalSep,
        dimensionUnit,
        name,
        numDecimals,
        Object.hashAll(states ?? const []),
        thousandSep,
        weightUnit,
      ]);
  @override
  String toString() => 'CountryInContinent(code: $code, name: $name)';
}
