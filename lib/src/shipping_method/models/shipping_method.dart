import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

class WooShippingMethod {
  /// Unique identifier for the resource
  final String? id;

  /// Shipping method title
  final String? title;

  /// Shipping method description
  final String? description;

  WooShippingMethod({
    this.id,
    this.title,
    this.description,
  });

  factory WooShippingMethod.fromJson(Map<String, dynamic> json) => WooShippingMethod(
    id: json['id'],
    title: json['title'],
    description: json['description'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
  };

  factory WooShippingMethod.fake() => WooShippingMethod(
    id: FakeHelper.word(),
    title: FakeHelper.sentence(),
    description: FakeHelper.sentence(),
  );
}