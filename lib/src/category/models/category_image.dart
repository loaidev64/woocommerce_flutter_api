import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

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

  WooProductCategoryImage(
      {this.id,
      this.dateCreated,
      this.dateCreatedGmt,
      this.dateModified,
      this.dateModifiedGmt,
      this.src,
      this.name,
      this.alt});

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
