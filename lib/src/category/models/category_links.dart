import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooProductCategoryLinks {
  WooProductCategoryLinks({this.self, this.collection});
  factory WooProductCategoryLinks.fromJson(Map<String, dynamic> json) =>
      WooProductCategoryLinks(
        self: WooJson.readList(json, 'self', WooProductCategorySelf.fromJson),
        collection: WooJson.readList(
            json, 'collection', WooProductCategoryCollection.fromJson),
      );
  factory WooProductCategoryLinks.fake() => WooProductCategoryLinks(
        self: FakeHelper.list(WooProductCategorySelf.fake),
        collection: FakeHelper.list(WooProductCategoryCollection.fake),
      );
  final List<WooProductCategorySelf>? self;
  final List<WooProductCategoryCollection>? collection;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('self', self?.map((link) => link.toJson()).toList())
    ..putIfPresent(
        'collection', collection?.map((link) => link.toJson()).toList());
  WooProductCategoryLinks copyWith({
    List<WooProductCategorySelf>? self,
    List<WooProductCategoryCollection>? collection,
  }) =>
      WooProductCategoryLinks(
        self: self ?? this.self,
        collection: collection ?? this.collection,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductCategoryLinks &&
          WooJson.listEquals(other.self, self) &&
          WooJson.listEquals(other.collection, collection);
  @override
  int get hashCode => Object.hashAll([
        ...(self ?? const []),
        ...(collection ?? const []),
      ]);
  @override
  String toString() => 'WooProductCategoryLinks(self: ${self?.length ?? 0}, '
      'collection: ${collection?.length ?? 0})';
}

class WooProductCategorySelf {
  WooProductCategorySelf({this.href});
  factory WooProductCategorySelf.fromJson(Map<String, dynamic> json) =>
      WooProductCategorySelf(href: WooJson.readString(json, 'href'));
  factory WooProductCategorySelf.fake() =>
      WooProductCategorySelf(href: FakeHelper.url());
  final String? href;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{}..putIfPresent('href', href);
  WooProductCategorySelf copyWith({String? href}) =>
      WooProductCategorySelf(href: href ?? this.href);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductCategorySelf && other.href == href;
  @override
  int get hashCode => Object.hashAll([href]);
  @override
  String toString() => 'WooProductCategorySelf(href: $href)';
}

class WooProductCategoryCollection {
  WooProductCategoryCollection({this.href});
  factory WooProductCategoryCollection.fromJson(Map<String, dynamic> json) =>
      WooProductCategoryCollection(href: WooJson.readString(json, 'href'));
  factory WooProductCategoryCollection.fake() =>
      WooProductCategoryCollection(href: FakeHelper.url());
  final String? href;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{}..putIfPresent('href', href);
  WooProductCategoryCollection copyWith({String? href}) =>
      WooProductCategoryCollection(href: href ?? this.href);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductCategoryCollection && other.href == href;
  @override
  int get hashCode => Object.hashAll([href]);
  @override
  String toString() => 'WooProductCategoryCollection(href: $href)';
}
