import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

class WooShippingZone {
  /// Unique identifier for the resource
  final int? id;

  /// Shipping zone name
  final String? name;

  /// Shipping zone order
  final int? order;

  WooShippingZone({
    this.id,
    required this.name,
    this.order,
  });

  factory WooShippingZone.fromJson(Map<String, dynamic> json) => WooShippingZone(
    id: json['id'],
    name: json['name'],
    order: json['order'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'order': order,
  };

  factory WooShippingZone.fake() => WooShippingZone(
    id: FakeHelper.integer(),
    name: FakeHelper.sentence(),
    order: FakeHelper.integer(),
  );
}