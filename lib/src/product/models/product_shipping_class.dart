import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooProductShippingClass {
  WooProductShippingClass({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.count,
  });
  factory WooProductShippingClass.fromJson(Map<String, dynamic> json) =>
      WooProductShippingClass(
        id: WooJson.readInt(json, 'id'),
        name: WooJson.readString(json, 'name'),
        slug: WooJson.readString(json, 'slug'),
        description: WooJson.readString(json, 'description'),
        count: WooJson.readInt(json, 'count'),
      );
  factory WooProductShippingClass.fake({int? id}) => WooProductShippingClass(
        id: id ?? FakeHelper.integer(),
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
  WooProductShippingClass copyWith({
    int? id,
    String? name,
    String? slug,
    String? description,
    int? count,
  }) =>
      WooProductShippingClass(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        description: description ?? this.description,
        count: count ?? this.count,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductShippingClass &&
          other.id == id &&
          other.name == name &&
          other.slug == slug &&
          other.description == description &&
          other.count == count;
  @override
  int get hashCode => Object.hashAll([id, name, slug, description, count]);
  @override
  String toString() =>
      'WooProductShippingClass(id: $id, name: $name, slug: $slug, count: $count)';
}
