import 'package:faker/faker.dart';
import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';
import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

class WooCartItem {
  /// Cart Item Key.
  String? key;

  /// Product ID.
  int? id;

  /// Cart Item quantity.
  int? quantity;

  /// Cart Item name.
  String? name;

  /// Unique identifier.
  String? sku;

  /// Product URL.
  String? permalink;

  /// Cart Item images.
  List<WooProductImage>? images;

  /// Cart Item price.
  double? price;

  /// Cart Item line price.
  double? linePrice;

  /// Cart Item variations.
  List<int>? variations;

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

  WooCartItem.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    id = json['id'];
    quantity = json['quantity'];
    name = json['name'];
    sku = json['sku'];
    permalink = json['permalink'];
    if (json['images'] != null) {
      images = <WooProductImage>[];
      json['images'].forEach((v) {
        images!.add(WooProductImage.fromJson(v));
      });
    }
    price = double.tryParse(json['price']);
    linePrice = double.tryParse(json['line_price']);
    if (json['variation'] != null) {
      variations = <int>[];
      json['variation'].forEach((v) {
        variations!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['key'] = key;
    data['id'] = id;
    data['quantity'] = quantity;
    data['name'] = name;
    data['sku'] = sku;
    data['permalink'] = permalink;
    data['price'] = price;
    data['line_price'] = linePrice;
    data['variation'] = variations;

    return data;
  }

  factory WooCartItem.fake() => WooCartItem(
        id: FakeHelper.integer(),
        key: Faker().guid.guid(),
        name: FakeHelper.word(),
        permalink: FakeHelper.url(),
        price: FakeHelper.decimal(),
        quantity: FakeHelper.integer(),
        sku: Faker().guid.guid(),
        linePrice: FakeHelper.decimal(),
        images: FakeHelper.list(() => WooProductImage.fake()),
        variations: FakeHelper.listOfIntegers(),
      );
}
