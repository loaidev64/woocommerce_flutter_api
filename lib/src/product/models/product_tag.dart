import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

/// Represents a product tag with metadata.
///
/// Brief description of the model's purpose and usage for product tags.
class WooProductTag {
  /// Unique identifier for the resource.
  final int? id;

  /// Tag name.
  final String? name;

  /// An alphanumeric identifier for the resource unique to its type.
  final String? slug;

  /// HTML description of the resource.
  final String? description;

  /// Number of published products for the resource.
  final int? count;

  /// Creates a new WooProductTag instance.
  WooProductTag(this.id, this.name, this.slug, [this.description, this.count]);

  /// Creates a WooProductTag instance from JSON data.
  WooProductTag.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        slug = json['slug'],
        description = json['description'],
        count = json['count'];

  /// Converts the WooProductTag instance to JSON format.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
        'description': description,
        'count': count,
      };

  /// Returns a string representation of the WooProductTag instance.
  ///
  /// Displays all main fields for debugging and logging purposes.
  @override
  String toString() {
    return 'WooProductTag(id: $id, name: $name, slug: $slug, description: $description, count: $count)';
  }

  /// Creates a fake WooProductTag instance for testing purposes.
  factory WooProductTag.fake([int? tagId]) => WooProductTag(
        tagId ?? FakeHelper.integer(),
        FakeHelper.word(),
        FakeHelper.url(),
        FakeHelper.sentence(),
        FakeHelper.integer(),
      );
}
