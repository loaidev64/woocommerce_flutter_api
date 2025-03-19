import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

class WooShippingZoneLocation {
  /// Shipping zone location code
  final String? code;

  /// Shipping zone location type
  final String? type;

  WooShippingZoneLocation({
    this.code,
    this.type,
  });

  factory WooShippingZoneLocation.fromJson(Map<String, dynamic> json) => WooShippingZoneLocation(
    code: json['code'],
    type: json['type'],
  );

  Map<String, dynamic> toJson() => {
    'code': code,
    'type': type,
  };

  factory WooShippingZoneLocation.fake() => WooShippingZoneLocation(
    code: FakeHelper.word(),
    type: FakeHelper.randomItem(const ['postcode', 'state', 'country', 'continent']),
  );
}