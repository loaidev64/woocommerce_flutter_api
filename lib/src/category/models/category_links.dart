/// Represents WooCommerce product category API links.
///
/// This class models the API links associated with a product category,
/// including self-referencing links and collection links.
class WooProductCategoryLinks {

  /// Creates a new WooProductCategoryLinks instance.
  ///
  /// ## Optional Parameters
  ///
  /// * [self] - Self-referencing API links
  /// * [collection] - Collection API links
  WooProductCategoryLinks({this.self, this.collection});

  /// Creates a WooProductCategoryLinks instance from JSON data.
  ///
  /// This factory constructor is used to deserialize links data received
  /// from the WooCommerce REST API.
  ///
  /// ## Parameters
  ///
  /// * [json] - A Map containing the links data in JSON format
  ///
  /// ## Returns
  ///
  /// A `WooProductCategoryLinks` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final links = WooProductCategoryLinks.fromJson(jsonData);
  /// ```
  WooProductCategoryLinks.fromJson(Map<String, dynamic> json) {
    if (json['self'] != null) {
      self = <WooProductCategorySelf>[];
      json['self'].forEach((v) {
        self!.add(WooProductCategorySelf.fromJson(v));
      });
    }
    if (json['collection'] != null) {
      collection = <WooProductCategoryCollection>[];
      json['collection'].forEach((v) {
        collection!.add(WooProductCategoryCollection.fromJson(v));
      });
    }
  }
  /// Self-referencing API links for the category
  List<WooProductCategorySelf>? self;

  /// Collection API links for the category
  List<WooProductCategoryCollection>? collection;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (self != null) {
      data['self'] = self!.map((v) => v.toJson()).toList();
    }
    if (collection != null) {
      data['collection'] = collection!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

/// Represents a self-referencing API link for a WooCommerce product category.
///
/// This class models a single self-referencing link that points to the category itself.
class WooProductCategorySelf {

  /// Creates a new WooProductCategorySelf instance.
  ///
  /// ## Optional Parameters
  ///
  /// * [href] - The URL of the self-referencing link
  WooProductCategorySelf({this.href});

  /// Creates a WooProductCategorySelf instance from JSON data.
  ///
  /// This factory constructor is used to deserialize self link data received
  /// from the WooCommerce REST API.
  ///
  /// ## Parameters
  ///
  /// * [json] - A Map containing the self link data in JSON format
  ///
  /// ## Returns
  ///
  /// A `WooProductCategorySelf` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final selfLink = WooProductCategorySelf.fromJson(jsonData);
  /// ```
  WooProductCategorySelf.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }
  /// The URL of the self-referencing link
  String? href;

  /// Converts the WooProductCategorySelf instance to JSON format
  ///
  /// This method serializes the self link data into a Map that can be sent
  /// to the WooCommerce REST API.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the self link data in JSON format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final jsonData = selfLink.toJson();
  /// ```
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    return data;
  }
}

/// Represents a collection API link for a WooCommerce product category.
///
/// This class models a single collection link that points to related category resources.
class WooProductCategoryCollection {

  /// Creates a new WooProductCategoryCollection instance.
  ///
  /// ## Optional Parameters
  ///
  /// * [href] - The URL of the collection link
  WooProductCategoryCollection({this.href});

  /// Creates a WooProductCategoryCollection instance from JSON data.
  ///
  /// This factory constructor is used to deserialize collection link data received
  /// from the WooCommerce REST API.
  ///
  /// ## Parameters
  ///
  /// * [json] - A Map containing the collection link data in JSON format
  ///
  /// ## Returns
  ///
  /// A `WooProductCategoryCollection` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final collectionLink = WooProductCategoryCollection.fromJson(jsonData);
  /// ```
  WooProductCategoryCollection.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }
  /// The URL of the collection link
  String? href;

  /// Converts the WooProductCategoryCollection instance to JSON format
  ///
  /// This method serializes the collection link data into a Map that can be sent
  /// to the WooCommerce REST API.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the collection link data in JSON format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final jsonData = collectionLink.toJson();
  /// ```
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    return data;
  }
}
