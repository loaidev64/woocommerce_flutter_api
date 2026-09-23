import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooProductTag {
  WooProductTag({this.id, this.name, this.slug, this.description, this.count});
  factory WooProductTag.fromJson(Map<String, dynamic> json) => WooProductTag(
        id: WooJson.readInt(json, 'id'),
        name: WooJson.readString(json, 'name'),
        slug: WooJson.readString(json, 'slug'),
        description: WooJson.readString(json, 'description'),
        count: WooJson.readInt(json, 'count'),
      );
  factory WooProductTag.fake({int? tagId}) => WooProductTag(
        id: tagId ?? FakeHelper.integer(),
        name: FakeHelper.word(),
        slug: FakeHelper.word(),
        description: FakeHelper.sentence(),
        count: FakeHelper.integer(),
      );
  final int? id;
  final String? name;
  final String? slug;
  final String? description;
  final int? count;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putIfPresent('name', name)
    ..putIfPresent('slug', slug)
    ..putIfPresent('description', description)
    ..putIfPresent('count', count);
  WooProductTag copyWith({
    int? id,
    String? name,
    String? slug,
    String? description,
    int? count,
  }) =>
      WooProductTag(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        description: description ?? this.description,
        count: count ?? this.count,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductTag &&
          other.id == id &&
          other.name == name &&
          other.slug == slug &&
          other.description == description &&
          other.count == count;
  @override
  int get hashCode => Object.hashAll([id, name, slug, description, count]);
  @override
  String toString() =>
      'WooProductTag(id: $id, name: $name, slug: $slug, count: $count)';
}
