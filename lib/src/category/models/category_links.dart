class WooProductCategoryLinks {
  List<WooProductCategorySelf>? self;
  List<WooProductCategoryCollection>? collection;

  WooProductCategoryLinks({this.self, this.collection});

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

class WooProductCategorySelf {
  String? href;

  WooProductCategorySelf({this.href});

  WooProductCategorySelf.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    return data;
  }
}

class WooProductCategoryCollection {
  String? href;

  WooProductCategoryCollection({this.href});

  WooProductCategoryCollection.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    return data;
  }
}
