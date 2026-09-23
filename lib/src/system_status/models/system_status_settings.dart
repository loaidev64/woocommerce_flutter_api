import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooSystemStatusSettings {
  WooSystemStatusSettings({
    this.apiEnabled,
    this.forceSsl,
    this.currency,
    this.currencySymbol,
    this.currencyPosition,
    this.thousandSeparator,
    this.decimalSeparator,
    this.numberOfDecimals,
    this.geolocationEnabled,
    this.taxonomies,
  });
  factory WooSystemStatusSettings.fromJson(Map<String, dynamic> json) =>
      WooSystemStatusSettings(
        apiEnabled: WooJson.readBool(json, 'api_enabled'),
        forceSsl: WooJson.readBool(json, 'force_ssl'),
        currency: WooJson.readString(json, 'currency'),
        currencySymbol: WooJson.readString(json, 'currency_symbol'),
        currencyPosition: WooJson.readString(json, 'currency_position'),
        thousandSeparator: WooJson.readString(json, 'thousand_separator'),
        decimalSeparator: WooJson.readString(json, 'decimal_separator'),
        numberOfDecimals: WooJson.readInt(json, 'number_of_decimals'),
        geolocationEnabled: WooJson.readBool(json, 'geolocation_enabled'),
        taxonomies: _readStringList(json, 'taxonomies'),
      );
  factory WooSystemStatusSettings.fake() => WooSystemStatusSettings(
        apiEnabled: FakeHelper.boolean(),
        forceSsl: FakeHelper.boolean(),
        currency: 'USD',
        currencySymbol: '\$',
        currencyPosition: 'left',
        thousandSeparator: ',',
        decimalSeparator: '.',
        numberOfDecimals: 2,
        geolocationEnabled: FakeHelper.boolean(),
        taxonomies: FakeHelper.list(() => FakeHelper.word()),
      );
  final bool? apiEnabled;
  final bool? forceSsl;
  final String? currency;
  final String? currencySymbol;
  final String? currencyPosition;
  final String? thousandSeparator;
  final String? decimalSeparator;
  final int? numberOfDecimals;
  final bool? geolocationEnabled;
  final List<String>? taxonomies;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('api_enabled', apiEnabled)
    ..putIfPresent('force_ssl', forceSsl)
    ..putIfPresent('currency', currency)
    ..putIfPresent('currency_symbol', currencySymbol)
    ..putIfPresent('currency_position', currencyPosition)
    ..putIfPresent('thousand_separator', thousandSeparator)
    ..putIfPresent('decimal_separator', decimalSeparator)
    ..putIfPresent('number_of_decimals', numberOfDecimals)
    ..putIfPresent('geolocation_enabled', geolocationEnabled)
    ..putIfPresent('taxonomies', taxonomies);
  WooSystemStatusSettings copyWith({
    bool? apiEnabled,
    bool? forceSsl,
    String? currency,
    String? currencySymbol,
    String? currencyPosition,
    String? thousandSeparator,
    String? decimalSeparator,
    int? numberOfDecimals,
    bool? geolocationEnabled,
    List<String>? taxonomies,
  }) =>
      WooSystemStatusSettings(
        apiEnabled: apiEnabled ?? this.apiEnabled,
        forceSsl: forceSsl ?? this.forceSsl,
        currency: currency ?? this.currency,
        currencySymbol: currencySymbol ?? this.currencySymbol,
        currencyPosition: currencyPosition ?? this.currencyPosition,
        thousandSeparator: thousandSeparator ?? this.thousandSeparator,
        decimalSeparator: decimalSeparator ?? this.decimalSeparator,
        numberOfDecimals: numberOfDecimals ?? this.numberOfDecimals,
        geolocationEnabled: geolocationEnabled ?? this.geolocationEnabled,
        taxonomies: taxonomies ?? this.taxonomies,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooSystemStatusSettings &&
        other.apiEnabled == apiEnabled &&
        other.forceSsl == forceSsl &&
        other.currency == currency &&
        other.currencySymbol == currencySymbol &&
        other.currencyPosition == currencyPosition &&
        other.thousandSeparator == thousandSeparator &&
        other.decimalSeparator == decimalSeparator &&
        other.numberOfDecimals == numberOfDecimals &&
        other.geolocationEnabled == geolocationEnabled &&
        WooJson.listEquals(other.taxonomies, taxonomies);
  }

  @override
  int get hashCode => Object.hashAll([
        apiEnabled,
        forceSsl,
        currency,
        currencySymbol,
        currencyPosition,
        thousandSeparator,
        decimalSeparator,
        numberOfDecimals,
        geolocationEnabled,
        Object.hashAll(taxonomies ?? const []),
      ]);
  @override
  String toString() => 'WooSystemStatusSettings(currency: $currency)';
  static List<String>? _readStringList(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is! List) return null;
    return [for (final element in value) element.toString()];
  }
}
