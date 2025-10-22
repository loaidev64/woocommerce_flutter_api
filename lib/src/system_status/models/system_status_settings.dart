import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

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
        apiEnabled: json['api_enabled'],
        forceSsl: json['force_ssl'],
        currency: json['currency'],
        currencySymbol: json['currency_symbol'],
        currencyPosition: json['currency_position'],
        thousandSeparator: json['thousand_separator'],
        decimalSeparator: json['decimal_separator'],
        numberOfDecimals: json['number_of_decimals'],
        geolocationEnabled: json['geolocation_enabled'],
        taxonomies: json['taxonomies'] != null
            ? List<String>.from(json['taxonomies'])
            : null,
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

  Map<String, dynamic> toJson() => {
        'api_enabled': apiEnabled,
        'force_ssl': forceSsl,
        'currency': currency,
        'currency_symbol': currencySymbol,
        'currency_position': currencyPosition,
        'thousand_separator': thousandSeparator,
        'decimal_separator': decimalSeparator,
        'number_of_decimals': numberOfDecimals,
        'geolocation_enabled': geolocationEnabled,
        'taxonomies': taxonomies,
      };
}
