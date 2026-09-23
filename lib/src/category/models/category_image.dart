import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooProductCategoryImage {
  WooProductCategoryImage({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.src,
    this.name,
    this.alt,
  });
  factory WooProductCategoryImage.fromJson(Map<String, dynamic> json) =>
      WooProductCategoryImage(
        id: WooJson.readInt(json, 'id'),
        dateCreated: WooJson.readDate(json, 'date_created'),
        dateCreatedGmt: WooJson.readDate(json, 'date_created_gmt'),
        dateModified: WooJson.readDate(json, 'date_modified'),
        dateModifiedGmt: WooJson.readDate(json, 'date_modified_gmt'),
        src: WooJson.readString(json, 'src') ?? '',
        name: WooJson.readString(json, 'name'),
        alt: WooJson.readString(json, 'alt'),
      );
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
  final int? id;
  final DateTime? dateCreated;
  final DateTime? dateCreatedGmt;
  final DateTime? dateModified;
  final DateTime? dateModifiedGmt;
  final String? src;
  final String? name;
  final String? alt;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putDate('date_created', dateCreated)
    ..putDate('date_created_gmt', dateCreatedGmt)
    ..putDate('date_modified', dateModified)
    ..putDate('date_modified_gmt', dateModifiedGmt)
    ..putIfPresent('src', src)
    ..putIfPresent('name', name)
    ..putIfPresent('alt', alt);
  WooProductCategoryImage copyWith({
    int? id,
    DateTime? dateCreated,
    DateTime? dateCreatedGmt,
    DateTime? dateModified,
    DateTime? dateModifiedGmt,
    String? src,
    String? name,
    String? alt,
  }) =>
      WooProductCategoryImage(
        id: id ?? this.id,
        dateCreated: dateCreated ?? this.dateCreated,
        dateCreatedGmt: dateCreatedGmt ?? this.dateCreatedGmt,
        dateModified: dateModified ?? this.dateModified,
        dateModifiedGmt: dateModifiedGmt ?? this.dateModifiedGmt,
        src: src ?? this.src,
        name: name ?? this.name,
        alt: alt ?? this.alt,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductCategoryImage &&
          other.id == id &&
          other.dateCreated == dateCreated &&
          other.dateCreatedGmt == dateCreatedGmt &&
          other.dateModified == dateModified &&
          other.dateModifiedGmt == dateModifiedGmt &&
          other.src == src &&
          other.name == name &&
          other.alt == alt;
  @override
  int get hashCode => Object.hashAll([
        id,
        dateCreated,
        dateCreatedGmt,
        dateModified,
        dateModifiedGmt,
        src,
        name,
        alt,
      ]);
  @override
  String toString() =>
      'WooProductCategoryImage(id: $id, name: $name, src: $src)';
}
