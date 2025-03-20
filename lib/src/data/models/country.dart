import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

class WooCountry {
  final String? code;
  final String? name;
  final List<StateInCountry>? states;

  WooCountry({this.code, this.name, this.states});

  factory WooCountry.fromJson(Map<String, dynamic> json) => WooCountry(
        code: json['code'],
        name: json['name'],
        states: json['states'] != null
            ? (json['states'] as List)
                .map((e) => StateInCountry.fromJson(e))
                .toList()
            : null,
      );

  factory WooCountry.fake() => WooCountry(
        code: FakeHelper.countryCode(),
        name: FakeHelper.country(),
        states: FakeHelper.list(() => StateInCountry.fake()),
      );
}
