import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

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

  WooProductTag(this.id, this.name, this.slug, [this.description, this.count]);

  WooProductTag.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        slug = json['slug'],
        description = json['description'],
        count = json['count'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
        'description': description,
        'count': count,
      };

  @override
  toString() => 'Tag: $name';

  factory WooProductTag.fake() => WooProductTag(
        FakeHelper.integer(),
        FakeHelper.word(),
        FakeHelper.url(),
        FakeHelper.sentence(),
        FakeHelper.integer(),
      );
}
