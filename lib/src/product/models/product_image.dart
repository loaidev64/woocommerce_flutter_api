import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooProductImage {
  WooProductImage({
    this.id,
    this.dateCreated,
    this.dateCreatedGMT,
    this.dateModified,
    this.dateModifiedGMT,
    this.src,
    this.name,
    this.alt,
  });
  factory WooProductImage.fromJson(Map<String, dynamic> json) =>
      WooProductImage(
        id: WooJson.readInt(json, 'id'),
        dateCreated: WooJson.readDate(json, 'date_created'),
        dateCreatedGMT: WooJson.readDate(json, 'date_created_gmt'),
        dateModified: WooJson.readDate(json, 'date_modified'),
        dateModifiedGMT: WooJson.readDate(json, 'date_modified_gmt'),
        src: WooJson.readString(json, 'src'),
        name: WooJson.readString(json, 'name'),
        alt: WooJson.readString(json, 'alt'),
      );
  factory WooProductImage.fake() => WooProductImage(
        id: FakeHelper.integer(),
        dateCreated: FakeHelper.datetime(),
        dateCreatedGMT: FakeHelper.datetime(),
        dateModified: FakeHelper.datetime(),
        dateModifiedGMT: FakeHelper.datetime(),
        src: FakeHelper.image(),
        name: FakeHelper.word(),
        alt: FakeHelper.sentence(),
      );
  final int? id;
  final DateTime? dateCreated;
  final DateTime? dateCreatedGMT;
  final DateTime? dateModified;
  final DateTime? dateModifiedGMT;
  final String? src;
  final String? name;
  final String? alt;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putDate('date_created', dateCreated)
    ..putDate('date_created_gmt', dateCreatedGMT)
    ..putDate('date_modified', dateModified)
    ..putDate('date_modified_gmt', dateModifiedGMT)
    ..putIfPresent('src', src)
    ..putIfPresent('name', name)
    ..putIfPresent('alt', alt);
  WooProductImage copyWith({
    int? id,
    DateTime? dateCreated,
    DateTime? dateCreatedGMT,
    DateTime? dateModified,
    DateTime? dateModifiedGMT,
    String? src,
    String? name,
    String? alt,
  }) =>
      WooProductImage(
        id: id ?? this.id,
        dateCreated: dateCreated ?? this.dateCreated,
        dateCreatedGMT: dateCreatedGMT ?? this.dateCreatedGMT,
        dateModified: dateModified ?? this.dateModified,
        dateModifiedGMT: dateModifiedGMT ?? this.dateModifiedGMT,
        src: src ?? this.src,
        name: name ?? this.name,
        alt: alt ?? this.alt,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductImage &&
          other.id == id &&
          other.dateCreated == dateCreated &&
          other.dateCreatedGMT == dateCreatedGMT &&
          other.dateModified == dateModified &&
          other.dateModifiedGMT == dateModifiedGMT &&
          other.src == src &&
          other.name == name &&
          other.alt == alt;
  @override
  int get hashCode => Object.hashAll([
        id,
        dateCreated,
        dateCreatedGMT,
        dateModified,
        dateModifiedGMT,
        src,
        name,
        alt,
      ]);
  @override
  String toString() =>
      'WooProductImage(id: $id, src: $src, name: $name, alt: $alt)';
}
