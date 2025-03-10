import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

class WooTaxClass {
  /// Unique identifier for the resource.
  String? slug;

  /// Tax class name.
  String? name;

  WooTaxClass({
    this.slug,
    this.name,
  });

  WooTaxClass.fromJson(Map<String, dynamic> json)
      : slug = json['slug'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'slug': slug,
        'name': name,
      };

  @override
  String toString() => toJson().toString();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WooTaxClass && other.slug == slug && other.name == name;
  }

  @override
  int get hashCode => slug.hashCode ^ name.hashCode;

  factory WooTaxClass.fake([int? id]) => WooTaxClass(
        slug: FakeHelper.word(),
        name: FakeHelper.word(),
      );
}
