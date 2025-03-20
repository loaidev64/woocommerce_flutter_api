part of 'data_api.dart';

abstract class _DataEndpoints {
  static String get data => '/data';
  static String get continents => '/data/continents';
  static String continent(String location) => '/data/continents/$location';
  static String get countries => '/data/countries';
  static String country(String location) => '/data/countries/$location';
  static String get currencies => '/data/currencies';
  static String currency(String code) => '/data/currencies/$code';
  static String get currentCurrency => '/data/currencies/current';
}