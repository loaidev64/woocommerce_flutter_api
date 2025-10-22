import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

/// Represents a product shipping class with metadata.
///
/// Brief description of the model's purpose and usage for product shipping classes.
class WooProductShippingClass {
  /// Unique identifier for the resource.
  final int? id;

  ///	Shipping class name.
  final String? name;

  ///	An alphanumeric identifier for the resource unique to its type.
  final String? slug;

  ///	HTML description of the resource.
  final String? description;

  ///	Number of published products for the resource.
  final int? count;

  /// Creates a new WooProductShippingClass instance.
  WooProductShippingClass(
      this.id, this.name, this.slug, this.description, this.count);

  /// Creates a WooProductShippingClass instance from JSON data.
  WooProductShippingClass.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        slug = json['slug'],
        description = json['description'],
        count = json['count'];

  /// Converts the WooProductShippingClass instance to JSON format.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
        'description': description,
        'count': count,
      };

  /// Creates a fake WooProductShippingClass instance for testing purposes.
  factory WooProductShippingClass.fake([int? id]) => WooProductShippingClass(
        id ?? FakeHelper.integer(),
        FakeHelper.word(),
        FakeHelper.word(),
        FakeHelper.sentence(),
        FakeHelper.integer(),
      );

  /// Returns a string representation of the WooProductShippingClass instance.
  ///
  /// Displays all main fields for debugging and logging purposes.
  @override
  String toString() {
    return 'WooProductShippingClass(id: $id, name: $name, slug: $slug, description: $description, count: $count)';
  }
}
