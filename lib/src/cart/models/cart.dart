import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';
import 'cart_item.dart';

class WooCart {
  WooCart({
    this.itemsCount,
    this.items,
    this.needsShipping,
    this.needsPayment,
    this.totalPrice,
  });
  factory WooCart.fromJson(Map<String, dynamic> json) => WooCart(
        itemsCount: WooJson.readInt(json, 'item_count'),
        items: WooJson.readList(json, 'items', WooCartItem.fromJson),
        needsShipping: WooJson.readBool(json, 'needs_shipping'),
        needsPayment: WooJson.readBool(json, 'needs_payment'),
        totalPrice: WooJson.readDouble(json, 'total_price'),
      );
  factory WooCart.fake() => WooCart(
        itemsCount: FakeHelper.integer(),
        needsPayment: FakeHelper.boolean(),
        needsShipping: FakeHelper.boolean(),
        totalPrice: FakeHelper.decimal(),
        items: FakeHelper.list(() => WooCartItem.fake()),
      );
  final int? itemsCount;
  final List<WooCartItem>? items;
  final bool? needsShipping;
  final bool? needsPayment;
  final double? totalPrice;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('item_count', itemsCount)
    ..putIfPresent('items', items?.map((item) => item.toJson()).toList())
    ..putIfPresent('needs_shipping', needsShipping)
    ..putIfPresent('needs_payment', needsPayment)
    ..putIfPresent('total_price', totalPrice);
  WooCart copyWith({
    int? itemsCount,
    List<WooCartItem>? items,
    bool? needsShipping,
    bool? needsPayment,
    double? totalPrice,
  }) =>
      WooCart(
        itemsCount: itemsCount ?? this.itemsCount,
        items: items ?? this.items,
        needsShipping: needsShipping ?? this.needsShipping,
        needsPayment: needsPayment ?? this.needsPayment,
        totalPrice: totalPrice ?? this.totalPrice,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooCart &&
          other.itemsCount == itemsCount &&
          WooJson.listEquals(other.items, items) &&
          other.needsShipping == needsShipping &&
          other.needsPayment == needsPayment &&
          other.totalPrice == totalPrice;
  @override
  int get hashCode => Object.hashAll([
        itemsCount,
        ...(items ?? const []),
        needsShipping,
        needsPayment,
        totalPrice,
      ]);
  @override
  String toString() =>
      'WooCart(itemsCount: $itemsCount, totalPrice: $totalPrice)';
}
