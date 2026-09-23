# cart

## cart_api

### extension WooCartApi on WooCommerce

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<WooCart> getCart({ bool? useFaker, }) async

[useFaker], fakes the api request

### Future<WooCart> updateCart

[items] the items of the cart
if the item has a quantity equal to 0 then it will be deleted from the cart

[useFaker], fakes the api request

## cart

### class WooCart

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooCart({ this.itemsCount, this.items, this.needsShipping, this.needsPayment, this.totalPrice, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooCart.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooCart.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final int? itemsCount

Count of items in cart.

### final List<WooCartItem>? items

Cart Items.

### final bool? needsShipping

If the cart needs shipping.

### final bool? needsPayment

If the cart needs payment.

### final double? totalPrice

If the cart needs payment.

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooCart copyWith({ int? itemsCount, List<WooCartItem>? items, bool? needsShipping, bool? needsPayment, double? totalPrice, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## cart_item

### class WooCartItem

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooCartItem({ this.key, this.id, this.quantity, this.name, this.sku, this.permalink, this.images, this.price, this.linePrice, this.variations, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooCartItem.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooCartItem.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? key

Cart Item Key.

### final int? id

Product ID.

### final int? quantity

Cart Item quantity.

### final String? name

Cart Item name.

### final String? sku

Unique identifier.

### final String? permalink

Product URL.

### final List<WooProductImage>? images

Cart Item images.

### final double? price

Cart Item price.

### final double? linePrice

Cart Item line price.

### final List<int>? variations

Cart Item variations.

### Map<String, dynamic> toJson()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooCartItem copyWith({ String? key, int? id, int? quantity, String? name, String? sku, String? permalink, List<WooProductImage>? images, double? price, double? linePrice, List<int>? variations, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### identical(this, other) ||

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

