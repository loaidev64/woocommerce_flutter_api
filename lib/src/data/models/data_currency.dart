import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooDataCurrency {
  WooDataCurrency({this.code, this.name, this.symbol});
  factory WooDataCurrency.fromJson(Map<String, dynamic> json) =>
      WooDataCurrency(
        code: WooJson.readString(json, 'code'),
        name: WooJson.readString(json, 'name'),
        symbol: WooJson.readString(json, 'symbol'),
      );
  factory WooDataCurrency.fake() => WooDataCurrency(
        code: FakeHelper.currencyCode(),
        name: FakeHelper.word(),
        symbol: '\$',
      );
  final String? code;
  final String? name;
  final String? symbol;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('code', code)
    ..putIfPresent('name', name)
    ..putIfPresent('symbol', symbol);
  WooDataCurrency copyWith({String? code, String? name, String? symbol}) =>
      WooDataCurrency(
        code: code ?? this.code,
        name: name ?? this.name,
        symbol: symbol ?? this.symbol,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooDataCurrency &&
        other.code == code &&
        other.name == name &&
        other.symbol == symbol;
  }

  @override
  int get hashCode => Object.hashAll([code, name, symbol]);
  @override
  String toString() => 'WooDataCurrency(code: $code, name: $name)';
}
