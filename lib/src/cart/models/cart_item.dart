import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';
import '../../product/models/product_image.dart';

class WooCartItem {
  WooCartItem({
    this.key,
    this.id,
    this.quantity,
    this.name,
    this.sku,
    this.permalink,
    this.images,
    this.price,
    this.linePrice,
    this.variations,
  });
  factory WooCartItem.fromJson(Map<String, dynamic> json) => WooCartItem(
        key: WooJson.readString(json, 'key'),
        id: WooJson.readInt(json, 'id'),
        quantity: WooJson.readInt(json, 'quantity'),
        name: WooJson.readString(json, 'name'),
        sku: WooJson.readString(json, 'sku'),
        permalink: WooJson.readString(json, 'permalink'),
        images: WooJson.readList(json, 'images', WooProductImage.fromJson),
        price: WooJson.readDouble(json, 'price'),
        linePrice: WooJson.readDouble(json, 'line_price'),
        variations: WooJson.readIntList(json, 'variation'),
      );
  factory WooCartItem.fake() => WooCartItem(
        id: FakeHelper.integer(),
        key: FakeHelper.word(),
        name: FakeHelper.word(),
        permalink: FakeHelper.url(),
        price: FakeHelper.decimal(),
        quantity: FakeHelper.integer(),
        sku: FakeHelper.word(),
        linePrice: FakeHelper.decimal(),
        images: FakeHelper.list(() => WooProductImage.fake()),
        variations: FakeHelper.listOfIntegers(),
      );
  final String? key;
  final int? id;
  final int? quantity;
  final String? name;
  final String? sku;
  final String? permalink;
  final List<WooProductImage>? images;
  final double? price;
  final double? linePrice;
  final List<int>? variations;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('key', key)
    ..putIfPresent('id', id)
    ..putIfPresent('quantity', quantity)
    ..putIfPresent('name', name)
    ..putIfPresent('sku', sku)
    ..putIfPresent('permalink', permalink)
    ..putIfPresent('images', images?.map((image) => image.toJson()).toList())
    ..putIfPresent('price', price)
    ..putIfPresent('line_price', linePrice)
    ..putIfPresent('variation', variations);
  WooCartItem copyWith({
    String? key,
    int? id,
    int? quantity,
    String? name,
    String? sku,
    String? permalink,
    List<WooProductImage>? images,
    double? price,
    double? linePrice,
    List<int>? variations,
  }) =>
      WooCartItem(
        key: key ?? this.key,
        id: id ?? this.id,
        quantity: quantity ?? this.quantity,
        name: name ?? this.name,
        sku: sku ?? this.sku,
        permalink: permalink ?? this.permalink,
        images: images ?? this.images,
        price: price ?? this.price,
        linePrice: linePrice ?? this.linePrice,
        variations: variations ?? this.variations,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooCartItem &&
          other.key == key &&
          other.id == id &&
          other.quantity == quantity &&
          other.name == name &&
          other.sku == sku &&
          other.permalink == permalink &&
          WooJson.listEquals(other.images, images) &&
          other.price == price &&
          other.linePrice == linePrice &&
          WooJson.listEquals(other.variations, variations);
  @override
  int get hashCode => Object.hashAll([
        key,
        id,
        quantity,
        name,
        sku,
        permalink,
        ...(images ?? const []),
        price,
        linePrice,
        ...(variations ?? const []),
      ]);
  @override
  String toString() =>
      'WooCartItem(id: $id, quantity: $quantity, price: $price)';
}
