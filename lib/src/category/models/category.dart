import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

import '../enums/category_display.dart';
import 'category_image.dart';
import 'category_links.dart';

/// WooCommerce Product Category Model
///
/// This class represents a product category in WooCommerce with comprehensive
/// information about the category, its hierarchy, display settings, and metadata.
/// Categories help organize products and can be arranged in hierarchical structures.
///
/// ## Key Features
///
/// - **Hierarchical Structure**: Support for parent-child category relationships
/// - **Display Control**: Configure how categories display products and subcategories
/// - **Rich Metadata**: Support for descriptions, images, and custom ordering
/// - **Product Association**: Track product counts and relationships
/// - **SEO Support**: Slug-based URLs and structured data
/// - **Menu Integration**: Custom ordering for navigation menus
///
/// ## Usage Examples
///
/// ### Creating a Category
///
/// ```dart
/// final category = WooProductCategory(
///   name: 'Electronics',
///   description: 'Electronic products and gadgets',
///   slug: 'electronics',
///   display: WooCategoryDisplay.products,
/// );
/// ```
///
/// ### Working with Category Data
///
/// ```dart
/// // Check if category has products
/// if (category.count! > 0) {
///   print('Category ${category.name} has ${category.count} products');
/// }
///
/// // Check if category is a subcategory
/// if (category.parent != null) {
///   print('This is a subcategory of parent ID: ${category.parent}');
/// }
/// ```
///
/// ## JSON Serialization
///
/// The class supports full JSON serialization for API communication:
///
/// ```dart
/// // Convert to JSON for API requests
/// final json = category.toJson();
///
/// // Create from JSON response
/// final category = WooProductCategory.fromJson(jsonData);
/// ```
class WooProductCategory {
  /// Unique identifier for the category
  ///
  /// This ID is automatically assigned by WooCommerce when the category is created.
  int? id;

  /// Category name
  ///
  /// The display name of the category as it appears to customers.
  String? name;

  /// Category slug
  ///
  /// A URL-friendly version of the category name, used in category URLs.
  String? slug;

  /// Parent category ID
  ///
  /// For subcategories, this references the parent category.
  /// For top-level categories, this is null.
  int? parent;

  /// Category description
  ///
  /// HTML description of the category, displayed on category pages.
  String? description;

  /// Category display type
  ///
  /// Controls how products and subcategories are displayed on the category page.
  WooCategoryDisplay? display;

  /// Category image
  ///
  /// The featured image for the category, displayed in category listings.
  WooProductCategoryImage? image;

  /// Menu order
  ///
  /// Used to custom sort categories in navigation menus.
  int? menuOrder;

  /// Product count
  ///
  /// Number of published products in this category.
  int? count;

  /// Category links
  ///
  /// API links for related resources and operations.
  WooProductCategoryLinks? links;

  /// Creates a new WooProductCategory instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional for maximum flexibility.
  ///
  /// ## Optional Parameters
  ///
  /// * [id] - Unique identifier for the category
  /// * [name] - Display name of the category
  /// * [slug] - URL-friendly version of the category name
  /// * [parent] - Parent category ID for subcategories
  /// * [description] - HTML description of the category
  /// * [display] - How the category displays its content
  /// * [image] - Featured image for the category
  /// * [menuOrder] - Custom sort order for navigation menus
  /// * [count] - Number of products in this category
  /// * [links] - API links for related resources
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final category = WooProductCategory(
  ///   name: 'Electronics',
  ///   description: 'Electronic products and gadgets',
  ///   slug: 'electronics',
  ///   display: WooCategoryDisplay.products,
  /// );
  /// ```
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

  /// Creates a WooProductCategory instance from JSON data
  ///
  /// This factory constructor is used to deserialize category data received
  /// from the WooCommerce REST API.
  ///
  /// ## Parameters
  ///
  /// * [json] - A Map containing the category data in JSON format
  ///
  /// ## Returns
  ///
  /// A `WooProductCategory` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final category = WooProductCategory.fromJson(jsonData);
  /// ```
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

  /// Converts the WooProductCategory instance to JSON format
  ///
  /// This method serializes the category data into a Map that can be sent
  /// to the WooCommerce REST API.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the category data in JSON format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final jsonData = category.toJson();
  /// ```
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

  /// Returns a string representation of the WooProductCategory instance
  ///
  /// This method provides a human-readable representation of the category,
  /// displaying all main fields for debugging and logging purposes.
  ///
  /// ## Returns
  ///
  /// A `String` containing the category's main field values in a readable format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final category = WooProductCategory(
  ///   id: 123,
  ///   name: 'Electronics',
  ///   slug: 'electronics',
  ///   count: 25,
  /// );
  /// print(category.toString());
  /// // Output: WooProductCategory(id: 123, name: Electronics, slug: electronics, count: 25)
  /// ```
  @override
  String toString() {
    return 'WooProductCategory(id: $id, name: $name, slug: $slug, parent: $parent, count: $count)';
  }

  /// Creates a fake WooProductCategory instance for testing purposes
  ///
  /// This factory constructor generates a category with random but realistic
  /// data, making it useful for testing and development.
  ///
  /// ## Returns
  ///
  /// A `WooProductCategory` instance with randomly generated fake data.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final fakeCategory = WooProductCategory.fake();
  /// ```
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
}
