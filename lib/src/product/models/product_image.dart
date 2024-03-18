import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

class WooProductImage {
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

  WooProductImage(this.id, this.src, this.name, this.alt, this.dateCreated,
      this.dateCreatedGMT, this.dateModified, this.dateModifiedGMT);

  WooProductImage.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        src = json['src'],
        name = json['name'],
        alt = json['alt'],
        dateCreated = DateTime.parse(json['date_created']),
        dateModifiedGMT = DateTime.parse(json['date_modified_gmt']),
        dateModified = DateTime.parse(json['date_modified']),
        dateCreatedGMT = DateTime.parse(json['date_created_gmt']);

  factory WooProductImage.fake() => WooProductImage(
        FakeHelper.integer(),
        FakeHelper.image(),
        FakeHelper.word(),
        FakeHelper.word(),
        FakeHelper.datetime(),
        FakeHelper.datetime(),
        FakeHelper.datetime(),
        FakeHelper.datetime(),
      );

  @override
  String toString() {
    return 'WooProductImage(id: $id, dateCreated: $dateCreated, dateCreatedGMT: $dateCreatedGMT, dateModified: $dateModified, dateModifiedGMT: $dateModifiedGMT, src: $src, name: $name, alt: $alt)';
  }
}
