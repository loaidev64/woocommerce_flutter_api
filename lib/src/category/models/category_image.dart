import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

/// Represents a WooCommerce product category image.
///
/// This class models the featured image for a product category with its metadata,
/// URLs, and timestamps for creation and modification.
class WooProductCategoryImage {
  /// Image ID.
  int? id;

  /// The date the image was created, in the site's timezone.
  DateTime? dateCreated;

  /// The date the image was created, as GMT
  DateTime? dateCreatedGmt;

  /// The date the image was last modified, in the site's timezone.
  DateTime? dateModified;

  /// The date the image was last modified, as GMT.
  DateTime? dateModifiedGmt;

  /// Image URL.
  String? src;

  /// Image name.
  String? name;

  /// Image alternative text.
  String? alt;

  /// Creates a new WooProductCategoryImage instance.
  ///
  /// ## Optional Parameters
  ///
  /// * [id] - Unique identifier for the image
  /// * [dateCreated] - Date the image was created (local timezone)
  /// * [dateCreatedGmt] - Date the image was created (GMT)
  /// * [dateModified] - Date the image was last modified (local timezone)
  /// * [dateModifiedGmt] - Date the image was last modified (GMT)
  /// * [src] - URL of the image
  /// * [name] - Name of the image file
  /// * [alt] - Alternative text for the image
  WooProductCategoryImage(
      {this.id,
      this.dateCreated,
      this.dateCreatedGmt,
      this.dateModified,
      this.dateModifiedGmt,
      this.src,
      this.name,
      this.alt});

  /// Creates a WooProductCategoryImage instance from JSON data.
  ///
  /// This factory constructor is used to deserialize image data received
  /// from the WooCommerce REST API.
  ///
  /// ## Parameters
  ///
  /// * [json] - A Map containing the image data in JSON format
  ///
  /// ## Returns
  ///
  /// A `WooProductCategoryImage` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final image = WooProductCategoryImage.fromJson(jsonData);
  /// ```
  WooProductCategoryImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    src = (json['src'] != null && json['src'] is String) ? json['src'] : "";
    name = json['name'];
    alt = json['alt'];
  }

  /// Converts the WooProductCategoryImage instance to JSON format
  ///
  /// This method serializes the image data into a Map that can be sent
  /// to the WooCommerce REST API.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the image data in JSON format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final jsonData = image.toJson();
  /// ```
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date_created'] = dateCreated;
    data['date_created_gmt'] = dateCreatedGmt;
    data['date_modified'] = dateModified;
    data['date_modified_gmt'] = dateModifiedGmt;
    data['src'] = src;
    data['name'] = name;
    data['alt'] = alt;
    return data;
  }

  /// Returns a string representation of the WooProductCategoryImage instance
  ///
  /// This method provides a human-readable representation of the image,
  /// displaying all main fields for debugging and logging purposes.
  ///
  /// ## Returns
  ///
  /// A `String` containing the image's main field values in a readable format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final image = WooProductCategoryImage(
  ///   id: 123,
  ///   name: 'electronics.jpg',
  ///   src: 'https://example.com/image.jpg',
  /// );
  /// print(image.toString());
  /// // Output: WooProductCategoryImage(id: 123, name: electronics.jpg, src: https://example.com/image.jpg)
  /// ```
  @override
  String toString() {
    return 'WooProductCategoryImage(id: $id, name: $name, src: $src)';
  }

  /// Creates a fake WooProductCategoryImage instance for testing purposes
  ///
  /// This factory constructor generates an image with random but realistic
  /// data, making it useful for testing and development.
  ///
  /// ## Returns
  ///
  /// A `WooProductCategoryImage` instance with randomly generated fake data.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final fakeImage = WooProductCategoryImage.fake();
  /// ```
  factory WooProductCategoryImage.fake() => WooProductCategoryImage(
        id: FakeHelper.integer(),
        dateCreated: FakeHelper.datetime(),
        dateCreatedGmt: FakeHelper.datetime(),
        dateModified: FakeHelper.datetime(),
        dateModifiedGmt: FakeHelper.datetime(),
        src: FakeHelper.image(),
        name: FakeHelper.word(),
        alt: FakeHelper.word(),
      );
}
