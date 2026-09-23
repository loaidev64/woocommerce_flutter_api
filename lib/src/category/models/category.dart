import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';
import '../enums/category_display.dart';
import 'category_image.dart';
import 'category_links.dart';

class WooProductCategory {
  WooProductCategory({
    this.id,
    this.name,
    this.slug,
    this.parent,
    this.description,
    this.display,
    this.image,
    this.menuOrder,
    this.count,
    this.links,
  });
  factory WooProductCategory.fromJson(Map<String, dynamic> json) {
    final imageJson = WooJson.readMap(json, 'image');
    return WooProductCategory(
      id: WooJson.readInt(json, 'id'),
      name: WooJson.readString(json, 'name'),
      slug: WooJson.readString(json, 'slug'),
      parent: WooJson.readInt(json, 'parent'),
      description: WooJson.readString(json, 'description'),
      display: WooJson.readEnum(json, 'display', WooCategoryDisplay.values),
      image: imageJson == null
          ? null
          : WooProductCategoryImage.fromJson(imageJson),
      menuOrder: WooJson.readInt(json, 'menu_order'),
      count: WooJson.readInt(json, 'count'),
      links: _parseLinks(json),
    );
  }
  factory WooProductCategory.fake() => WooProductCategory(
        id: FakeHelper.integer(),
        name: FakeHelper.word(),
        slug: FakeHelper.word(),
        parent: FakeHelper.integer(),
        description: FakeHelper.sentence(),
        display: WooCategoryDisplay.fake(),
        image: WooProductCategoryImage.fake(),
        menuOrder: FakeHelper.integer(),
        count: FakeHelper.integer(),
      );
  static WooProductCategoryLinks? _parseLinks(Map<String, dynamic> json) {
    final linksJson = WooJson.readMap(json, '_links');
    return linksJson == null
        ? null
        : WooProductCategoryLinks.fromJson(linksJson);
  }

  final int? id;
  final String? name;
  final String? slug;
  final int? parent;
  final String? description;
  final WooCategoryDisplay? display;
  final WooProductCategoryImage? image;
  final int? menuOrder;
  final int? count;
  final WooProductCategoryLinks? links;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putIfPresent('name', name)
    ..putIfPresent('slug', slug)
    ..putIfPresent('parent', parent)
    ..putIfPresent('description', description)
    ..putEnum('display', display)
    ..putIfPresent('image', image?.toJson())
    ..putIfPresent('menu_order', menuOrder)
    ..putIfPresent('count', count)
    ..putIfPresent('_links', links?.toJson());
  WooProductCategory copyWith({
    int? id,
    String? name,
    String? slug,
    int? parent,
    String? description,
    WooCategoryDisplay? display,
    WooProductCategoryImage? image,
    int? menuOrder,
    int? count,
    WooProductCategoryLinks? links,
  }) =>
      WooProductCategory(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        parent: parent ?? this.parent,
        description: description ?? this.description,
        display: display ?? this.display,
        image: image ?? this.image,
        menuOrder: menuOrder ?? this.menuOrder,
        count: count ?? this.count,
        links: links ?? this.links,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductCategory &&
          other.id == id &&
          other.name == name &&
          other.slug == slug &&
          other.parent == parent &&
          other.description == description &&
          other.display == display &&
          other.image == image &&
          other.menuOrder == menuOrder &&
          other.count == count &&
          other.links == links;
  @override
  int get hashCode => Object.hashAll([
        id,
        name,
        slug,
        parent,
        description,
        display,
        image,
        menuOrder,
        count,
        links,
      ]);
  @override
  String toString() =>
      'WooProductCategory(id: $id, name: $name, slug: $slug, count: $count)';
}
