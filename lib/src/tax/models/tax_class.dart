import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

/// Represents a tax class with basic information.
///
/// Brief description of the model's purpose and usage.
class WooTaxClass {
  /// Unique identifier for the resource.
  String? slug;

  /// Tax class name.
  String? name;

  /// Creates a new WooTaxClass instance.
  WooTaxClass({
    this.slug,
    this.name,
  });

  /// Creates a WooTaxClass instance from JSON data.
  WooTaxClass.fromJson(Map<String, dynamic> json)
      : slug = json['slug'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'slug': slug,
        'name': name,
      };

  /// Returns a string representation of the WooTaxClass instance.
  ///
  /// Displays all main fields for debugging and logging purposes.
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
