import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

/// Represents a product image with metadata and URLs.
///
/// Brief description of the model's purpose and usage for product images.
///
/// ## Product creation note
///
/// When creating a product, the WooCommerce REST API only accepts
/// `id`, `src`, `name` and `alt` inside the `images` array. The four
/// date fields below are populated by the server on read and should
/// be left `null` (the default) when constructing an image for a
/// create request — otherwise the API returns `400 Bad Request`.
class WooProductImage {
  /// Creates a new WooProductImage instance.
  ///
  /// The four date parameters are optional. Omit them when building
  /// a payload for product creation; the server will generate them.
  /// Set them when deserializing a response.
  WooProductImage(
    this.id,
    this.src,
    this.name,
    this.alt, [
    this.dateCreated,
    this.dateCreatedGMT,
    this.dateModified,
    this.dateModifiedGMT,
  ]);

  /// Creates a WooProductImage instance from JSON data.
  ///
  /// Date fields that are missing or empty in [json] are kept as `null`.
  WooProductImage.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dateCreated = _parseDate(json['date_created']),
        dateCreatedGMT = _parseDate(json['date_created_gmt']),
        dateModified = _parseDate(json['date_modified']),
        dateModifiedGMT = _parseDate(json['date_modified_gmt']),
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
  final DateTime? dateCreated;

  /// The date the image was created, as GMT.
  final DateTime? dateCreatedGMT;

  /// The date the image was last modified, in the site's timezone.
  final DateTime? dateModified;

  /// The date the image was last modified, as GMT.
  final DateTime? dateModifiedGMT;

  /// Image URL.
  final String? src;

  /// Image name.
  final String? name;

  /// Image alternative text.
  final String? alt;

  /// Converts this WooProductImage instance into a JSON encodable Map.
  ///
  /// Only emits date keys when they are non-null, so payloads for
  /// product creation omit them entirely (the server assigns them).
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (id != null) {
      data['id'] = id;
    }
    if (dateCreated != null) {
      data['date_created'] = dateCreated!.toIso8601String();
    }
    if (dateCreatedGMT != null) {
      data['date_created_gmt'] = dateCreatedGMT!.toIso8601String();
    }
    if (dateModified != null) {
      data['date_modified'] = dateModified!.toIso8601String();
    }
    if (dateModifiedGMT != null) {
      data['date_modified_gmt'] = dateModifiedGMT!.toIso8601String();
    }
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

  /// Returns a copy of this WooProductImage with the given fields replaced.
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

  static DateTime? _parseDate(dynamic value) {
    if (value is String && value.isNotEmpty) return DateTime.parse(value);
    return null;
  }
}
