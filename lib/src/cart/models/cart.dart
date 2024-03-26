import 'package:woocommerce_flutter_api/src/cart/models/cart_item.dart';
import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

//TODO:: is not compatable with plugin yet
class WooCart {
  /// Count of items in cart.
  int? itemsCount;

  /// Cart Items.
  List<WooCartItem>? items;

  /// If the cart needs shipping.
  bool? needsShipping;

  /// If the cart needs payment.
  bool? needsPayment;

  /// If the cart needs payment.
  double? totalPrice;

  WooCart({
    this.itemsCount,
    this.items,
    this.needsShipping,
    this.needsPayment,
    this.totalPrice,
  });

  WooCart.fromJson(Map<String, dynamic> json) {
    itemsCount = json['item_count'];
    if (json['items'] != null) {
      items = <WooCartItem>[];
      json['items'].forEach((v) {
        items!.add(WooCartItem.fromJson(v));
      });
    }
    needsShipping = json['needs_shipping'];
    needsPayment = json['needs_payment'];
    totalPrice = double.tryParse(json['total_price']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_count'] = itemsCount;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['needs_shipping'] = needsShipping;
    data['needs_payment'] = needsPayment;
    data['total_price'] = totalPrice;
    return data;
  }

  @override
  toString() => toJson().toString();

  factory WooCart.fake() => WooCart(
        itemsCount: FakeHelper.integer(),
        needsPayment: FakeHelper.boolean(),
        needsShipping: FakeHelper.boolean(),
        totalPrice: FakeHelper.decimal(),
        items: FakeHelper.list(() => WooCartItem.fake()),
      );
}
