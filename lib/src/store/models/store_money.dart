import 'dart:math' as math;

import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooStoreCurrency {
  const WooStoreCurrency({
    this.code = '',
    this.symbol = '',
    this.minorUnit = 2,
    this.decimalSeparator = '.',
    this.thousandSeparator = ',',
    this.prefix = '',
    this.suffix = '',
  });

  factory WooStoreCurrency.fromJson(Map<String, dynamic> json) =>
      WooStoreCurrency(
        code: WooJson.readString(json, 'currency_code') ?? '',
        symbol: WooJson.readString(json, 'currency_symbol') ?? '',
        minorUnit: WooJson.readInt(json, 'currency_minor_unit') ?? 2,
        decimalSeparator:
            WooJson.readString(json, 'currency_decimal_separator') ?? '.',
        thousandSeparator: json.containsKey('currency_thousand_separator')
            ? WooJson.readString(json, 'currency_thousand_separator') ?? ''
            : ',',
        prefix: WooJson.readString(json, 'currency_prefix') ?? '',
        suffix: WooJson.readString(json, 'currency_suffix') ?? '',
      );

  factory WooStoreCurrency.fake() => WooStoreCurrency(
        code: FakeHelper.currencyCode(),
        symbol: r'$',
        prefix: r'$',
      );

  final String code;

  final String symbol;

  final int minorUnit;

  final String decimalSeparator;

  final String thousandSeparator;

  final String prefix;

  final String suffix;

  String format(int minorUnits) {
    final negative = minorUnits < 0;
    final digits = minorUnits.abs().toString().padLeft(minorUnit + 1, '0');
    final split = digits.length - minorUnit;
    final whole = _group(digits.substring(0, split));
    final fraction = digits.substring(split);
    final number = minorUnit == 0 ? whole : '$whole$decimalSeparator$fraction';
    return '${negative ? '-' : ''}$prefix$number$suffix';
  }

  String _group(String whole) {
    if (thousandSeparator.isEmpty || whole.length <= 3) return whole;
    final buffer = StringBuffer();
    final lead = whole.length % 3 == 0 ? 3 : whole.length % 3;
    buffer.write(whole.substring(0, lead));
    for (var i = lead; i < whole.length; i += 3) {
      buffer
        ..write(thousandSeparator)
        ..write(whole.substring(i, i + 3));
    }
    return buffer.toString();
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'currency_code': code,
        'currency_symbol': symbol,
        'currency_minor_unit': minorUnit,
        'currency_decimal_separator': decimalSeparator,
        'currency_thousand_separator': thousandSeparator,
        'currency_prefix': prefix,
        'currency_suffix': suffix,
      };

  WooStoreCurrency copyWith({
    String? code,
    String? symbol,
    int? minorUnit,
    String? decimalSeparator,
    String? thousandSeparator,
    String? prefix,
    String? suffix,
  }) =>
      WooStoreCurrency(
        code: code ?? this.code,
        symbol: symbol ?? this.symbol,
        minorUnit: minorUnit ?? this.minorUnit,
        decimalSeparator: decimalSeparator ?? this.decimalSeparator,
        thousandSeparator: thousandSeparator ?? this.thousandSeparator,
        prefix: prefix ?? this.prefix,
        suffix: suffix ?? this.suffix,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooStoreCurrency &&
          other.code == code &&
          other.symbol == symbol &&
          other.minorUnit == minorUnit &&
          other.decimalSeparator == decimalSeparator &&
          other.thousandSeparator == thousandSeparator &&
          other.prefix == prefix &&
          other.suffix == suffix;

  @override
  int get hashCode => Object.hash(
        code,
        symbol,
        minorUnit,
        decimalSeparator,
        thousandSeparator,
        prefix,
        suffix,
      );

  @override
  String toString() => code.isEmpty ? 'WooStoreCurrency()' : code;
}

class WooStoreMoney implements Comparable<WooStoreMoney> {
  const WooStoreMoney(this.minorUnits, this.currency);

  factory WooStoreMoney.read(
    Map<String, dynamic> json,
    String field, [
    WooStoreCurrency? currency,
  ]) =>
      WooStoreMoney(
        int.tryParse('${json[field] ?? ''}') ?? 0,
        currency ?? WooStoreCurrency.fromJson(json),
      );

  factory WooStoreMoney.fake() => WooStoreMoney(
      FakeHelper.integer(min: 0, max: 100000), WooStoreCurrency.fake());

  final int minorUnits;

  final WooStoreCurrency currency;

  double get amount => minorUnits / math.pow(10, currency.minorUnit);

  bool get isZero => minorUnits == 0;

  WooStoreMoney operator +(WooStoreMoney other) =>
      WooStoreMoney(minorUnits + other.minorUnits, currency);

  WooStoreMoney operator -(WooStoreMoney other) =>
      WooStoreMoney(minorUnits - other.minorUnits, currency);

  WooStoreMoney operator *(int times) =>
      WooStoreMoney(minorUnits * times, currency);

  bool operator <(WooStoreMoney other) => minorUnits < other.minorUnits;

  bool operator <=(WooStoreMoney other) => minorUnits <= other.minorUnits;

  bool operator >(WooStoreMoney other) => minorUnits > other.minorUnits;

  bool operator >=(WooStoreMoney other) => minorUnits >= other.minorUnits;

  @override
  int compareTo(WooStoreMoney other) => minorUnits.compareTo(other.minorUnits);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooStoreMoney &&
          other.minorUnits == minorUnits &&
          other.currency.code == currency.code;

  @override
  int get hashCode => Object.hash(minorUnits, currency.code);

  @override
  String toString() => currency.format(minorUnits);
}
