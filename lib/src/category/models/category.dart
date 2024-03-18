import 'package:faker/faker.dart';

import '../enums/category_display.dart';
import 'category_image.dart';
import 'category_links.dart';

class WooProductCategory {
  /// Unique identifier for the resource.
  int? id;

  /// Category name.
  String? name;

  /// An alphanumeric identifier for the resource unique to its type.
  String? slug;

  /// The ID for the parent of the resource.
  int? parent;

  /// HTML description of the resource.
  String? description;

  /// Category archive display type. Options: default, products, subcategories and both. Default is default.
  WooCategoryDisplay? display;

  /// Image data.
  WooProductCategoryImage? image;

  /// Menu order, used to custom sort the resource.
  int? menuOrder;

  /// Number of published products for the resource.
  int? count;

  WooProductCategoryLinks? links;

  WooProductCategory(
      {this.id,
      this.name,
      this.slug,
      this.parent,
      this.description,
      this.display,
      this.image,
      this.menuOrder,
      this.count,
      this.links});

  WooProductCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    parent = json['parent'];
    description = json['description'];
    display = json['display'];
    image = json['image'] != null
        ? WooProductCategoryImage.fromJson(json['image'])
        : null;
    menuOrder = json['menu_order'];
    count = json['count'];
    links = json['_links'] != null
        ? WooProductCategoryLinks.fromJson(json['_links'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['parent'] = parent;
    data['description'] = description;
    data['display'] = display;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    data['menu_order'] = menuOrder;
    data['count'] = count;
    if (links != null) {
      data['_links'] = links!.toJson();
    }
    return data;
  }

  @override
  toString() => toJson().toString();

  factory WooProductCategory.fake() => WooProductCategory(
        id: Faker().randomGenerator.integer(100),
        name: Faker().lorem.word(),
        slug: Faker().lorem.word(),
        parent: Faker().randomGenerator.integer(100),
        description: Faker().lorem.sentence(),
        display: WooCategoryDisplay.fake(),
        image: WooProductCategoryImage.fake(),
        menuOrder: Faker().randomGenerator.integer(100),
        count: Faker().randomGenerator.integer(100),
      );
}
