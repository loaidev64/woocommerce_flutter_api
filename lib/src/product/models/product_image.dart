import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

/// Represents a product image with metadata and URLs.
///
/// Brief description of the model's purpose and usage for product images.
class WooProductImage {

  /// Creates a new WooProductImage instance.
  WooProductImage(this.id, this.src, this.name, this.alt, this.dateCreated,
      this.dateCreatedGMT, this.dateModified, this.dateModifiedGMT);

  /// Creates a WooProductImage instance from JSON data.
  WooProductImage.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        // Note: Consider adding type checks or defaults if API might return null for non-nullable DateTime fields
        dateCreated = DateTime.parse(json['date_created']),
        dateCreatedGMT = DateTime.parse(json['date_created_gmt']),
        dateModified = DateTime.parse(json['date_modified']),
        dateModifiedGMT = DateTime.parse(json['date_modified_gmt']),
        src = json['src'],
        name = json['name'],
        alt = json['alt'];

  /// Creates a fake WooProductImage instance for testing purposes.
  factory WooProductImage.fake() => WooProductImage(
        FakeHelper.integer(),
        FakeHelper.image(),
        FakeHelper.word(),
        FakeHelper.sentence(),
        FakeHelper.datetime(),
        FakeHelper.datetime(),
        FakeHelper.datetime(),
        FakeHelper.datetime(),
      );
  /// Image ID.
  final int? id;

  /// The date the image was created, in the site's timezone.
  final DateTime dateCreated;

  /// The date the image was created, as GMT.
  final DateTime dateCreatedGMT;

  /// The date the image was last modified, in the site's timezone.
  final DateTime dateModified;

  /// The date the image was last modified, as GMT.
  final DateTime dateModifiedGMT;

  /// Image URL.
  final String? src;

  /// Image name.
  final String? name;

  /// Image alternative text.
  final String? alt;

  /// Converts this WooProductImage instance into a JSON encodable Map.
  ///
  /// Note: When updating/creating products, typically only 'id' or 'src' is needed
  /// within the 'images' list. Sending all fields might be unnecessary or ignored
  /// by the specific WooCommerce API endpoint context. Check API docs for specifics.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    // Only include fields if they are not null, except for DateTime which are required
    if (id != null) {
      data['id'] = id;
    }
    data['date_created'] = dateCreated.toIso8601String();
    data['date_created_gmt'] = dateCreatedGMT.toIso8601String();
    data['date_modified'] = dateModified.toIso8601String();
    data['date_modified_gmt'] = dateModifiedGMT.toIso8601String();
    if (src != null) {
      data['src'] = src;
    }
    if (name != null) {
      data['name'] = name;
    }
    if (alt != null) {
      data['alt'] = alt;
    }
    return data;
  }

  @override
  String toString() {
    return 'WooProductImage(id: $id, src: $src, name: $name, alt: $alt, dateCreated: $dateCreated, dateCreatedGMT: $dateCreatedGMT, dateModified: $dateModified, dateModifiedGMT: $dateModifiedGMT)';
  }

  // Optional: Add copyWith method for easier updates
  WooProductImage copyWith({
    int? id,
    DateTime? dateCreated,
    DateTime? dateCreatedGMT,
    DateTime? dateModified,
    DateTime? dateModifiedGMT,
    String? src,
    String? name,
    String? alt,
  }) {
    return WooProductImage(
      id ?? this.id,
      src ?? this.src,
      name ?? this.name,
      alt ?? this.alt,
      dateCreated ?? this.dateCreated,
      dateCreatedGMT ?? this.dateCreatedGMT,
      dateModified ?? this.dateModified,
      dateModifiedGMT ?? this.dateModifiedGMT,
    );
  }
}
