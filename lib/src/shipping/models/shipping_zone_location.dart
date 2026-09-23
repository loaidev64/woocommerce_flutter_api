import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooShippingZoneLocation {
  WooShippingZoneLocation({this.code, this.type});
  factory WooShippingZoneLocation.fromJson(Map<String, dynamic> json) =>
      WooShippingZoneLocation(
        code: WooJson.readString(json, 'code'),
        type: WooJson.readString(json, 'type'),
      );
  factory WooShippingZoneLocation.fake() => WooShippingZoneLocation(
        code: FakeHelper.word(),
        type: FakeHelper.randomItem(
          const ['postcode', 'state', 'country', 'continent'],
        ),
      );
  final String? code;
  final String? type;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('code', code)
    ..putIfPresent('type', type);
  WooShippingZoneLocation copyWith({String? code, String? type}) =>
      WooShippingZoneLocation(
        code: code ?? this.code,
        type: type ?? this.type,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooShippingZoneLocation &&
        other.code == code &&
        other.type == type;
  }

  @override
  int get hashCode => Object.hashAll([code, type]);
  @override
  String toString() => 'WooShippingZoneLocation(code: $code, type: $type)';
}
