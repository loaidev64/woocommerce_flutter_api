import 'package:faker/faker.dart';

import 'category_image.dart';
import 'category_links.dart';

class WooProductCategory {
  /// Category ID.
  int? id;

  /// Category name.
  String? name;

  /// Category slug.
  String? slug;
  int? parent;
  String? description;
  String? display;
  WooProductCategoryImage? image;
  int? menuOrder;
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
        name: Faker().person.name(),
        description: Faker().lorem.sentence(),
      );
}
