import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

class WooCurrency {
  final String? code;
  final String? name;
  final String? symbol;

  WooCurrency({this.code, this.name, this.symbol});

  factory WooCurrency.fromJson(Map<String, dynamic> json) => WooCurrency(
        code: json['code'],
        name: json['name'],
        symbol: json['symbol'],
      );

  factory WooCurrency.fake() => WooCurrency(
        code: FakeHelper.currencyCode(),
        name: FakeHelper.word(),
        symbol: '\$',
      );
}
