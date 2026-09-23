import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooProductAttributeTerm {
  WooProductAttributeTerm({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.menuOrder,
    this.count,
  });
  factory WooProductAttributeTerm.fromJson(Map<String, dynamic> json) =>
      WooProductAttributeTerm(
        id: WooJson.readInt(json, 'id'),
        name: WooJson.readString(json, 'name'),
        slug: WooJson.readString(json, 'slug'),
        description: WooJson.readString(json, 'description'),
        menuOrder: WooJson.readInt(json, 'menu_order'),
        count: WooJson.readInt(json, 'count'),
      );
  factory WooProductAttributeTerm.fake({int? id}) => WooProductAttributeTerm(
        id: id ?? FakeHelper.integer(),
        name: FakeHelper.word(),
        slug: FakeHelper.word(),
        description: FakeHelper.sentence(),
        menuOrder: FakeHelper.integer(),
        count: FakeHelper.integer(),
      );
  final int? id;
  final String? name;
  final String? slug;
  final String? description;
  final int? menuOrder;
  final int? count;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putIfPresent('name', name)
    ..putIfPresent('slug', slug)
    ..putIfPresent('description', description)
    ..putIfPresent('menu_order', menuOrder)
    ..putIfPresent('count', count);
  WooProductAttributeTerm copyWith({
    int? id,
    String? name,
    String? slug,
    String? description,
    int? menuOrder,
    int? count,
  }) =>
      WooProductAttributeTerm(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        description: description ?? this.description,
        menuOrder: menuOrder ?? this.menuOrder,
        count: count ?? this.count,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductAttributeTerm &&
          other.id == id &&
          other.name == name &&
          other.slug == slug &&
          other.description == description &&
          other.menuOrder == menuOrder &&
          other.count == count;
  @override
  int get hashCode =>
      Object.hash(id, name, slug, description, menuOrder, count);
  @override
  String toString() =>
      'WooProductAttributeTerm(id: $id, name: $name, slug: $slug, count: $count)';
}
