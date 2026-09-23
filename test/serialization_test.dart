import 'package:test/test.dart';
import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';
void main() {
  group('model round-trips (real WooCommerce v3 payloads)', () {
    test('WooProduct', () {
      const json = {
        'id': 93,
        'name': 'Album',
        'slug': 'album',
        'permalink': 'https://store.test/product/album/',
        'date_created': '2023-03-23T10:45:00',
        'date_created_gmt': '2023-03-23T07:45:00',
        'type': 'simple',
        'status': 'publish',
        'catalog_visibility': 'visible',
        'description': '<p>An album</p>',
        'short_description': 'Album',
        'sku': 'ALBUM-1',
        'price': '15.00',
        'regular_price': '20.00',
        'sale_price': '15.00',
        'total_sales': 12,
        'virtual': false,
        'downloadable': true,
        'downloads': [
          {
            'id': '1',
            'name': 'Track',
            'file': 'https://store.test/track.mp3',
          },
        ],
        'tax_status': 'taxable',
        'tax_class': '',
        'manage_stock': false,
        'stock_quantity': null,
        'stock_status': 'instock',
        'weight': '0.5',
        'dimensions': {
          'length': '10',
          'width': '10',
          'height': '1',
        },
        'categories': [
          {'id': 9, 'name': 'Music', 'slug': 'music'},
        ],
        'tags': [
          {'id': 3, 'name': 'vinyl', 'slug': 'vinyl'},
        ],
        'images': [
          {
            'id': 42,
            'date_created': '2023-03-23T10:45:00',
            'src': 'https://store.test/img.jpg',
            'name': 'Cover',
            'alt': '',
          },
        ],
        'attributes': [
          {
            'id': 1,
            'name': 'Format',
            'position': 0,
            'visible': true,
            'variation': false,
            'options': ['Vinyl', 'CD'],
          },
        ],
        'related_ids': [94, 95],
        'upsell_ids': [],
        'cross_sell_ids': [],
        'purchasable': true,
        'on_sale': true,
        'average_rating': '4.25',
        'rating_count': 8,
        'meta_data': [
          {'id': 7, 'key': '_custom', 'value': 'x'},
        ],
      };
      final product = WooProduct.fromJson(json);
      expect(product.price, 15.0);
      expect(product.salePrice, 15.0);
      expect(product.averageRating, 4.25);
      expect(product.stockStatus, WooProductStockStatus.instock);
      expect(product.relatedIds, [94, 95]);
      expect(product.categories?.single.slug, 'music');
      expect(product.attributes?.single.options, ['Vinyl', 'CD']);
      expect(product.metaData?.single.key, '_custom');
      final out = product.toJson();
      expect(out.containsKey('stock_quantity'), isFalse);
      expect(out['status'], 'publish');
      expect(out['sale_price'], isNotNull);
      final reparsed = WooProduct.fromJson({...json, ...out});
      expect(reparsed, product);
    });
    test('WooProduct survives missing optional arrays', () {
      final product = WooProduct.fromJson({
        'id': 1,
        'name': 'Minimal',
        'status': 'draft',
        'type': 'simple',
      });
      expect(product.price, isNull);
      expect(product.relatedIds, isNull);
      expect(product.images, isNull);
      expect(product.status, WooProductStatus.draft);
    });
    test('WooCustomer', () {
      const json = {
        'id': 1,
        'email': 'john@example.com',
        'first_name': 'John',
        'last_name': 'Doe',
        'role': 'customer',
        'username': 'johndoe',
        'is_paying_customer': true,
        'avatar_url': 'https://secure.gravatar.com/avatar/x',
        'billing': {
          'first_name': 'John',
          'email': 'john@example.com',
          'country': 'US',
        },
        'meta_data': [],
      };
      final customer = WooCustomer.fromJson(json);
      expect(customer.role, WooCustomerRole.customer);
      expect(customer.billing?.email, 'john@example.com');
      final reparsed = WooCustomer.fromJson({...json, ...customer.toJson()});
      expect(reparsed, customer);
    });
    test('WooCoupon amount parsing', () {
      final coupon = WooCoupon.fromJson({
        'id': 5,
        'code': 'tenoff',
        'amount': '10.00',
        'discount_type': 'percent',
        'individual_use': true,
      });
      expect(coupon.amount, 10.0);
      expect(coupon.discountType, WooCouponDiscountType.percent);
      final reparsed = WooCoupon.fromJson({
        'id': 5,
        'code': 'tenoff',
        ...coupon.toJson(),
      });
      expect(reparsed, coupon);
    });
    test('WooProductCategory display wire value', () {
      final category = WooProductCategory.fromJson({
        'id': 9,
        'name': 'Music',
        'slug': 'music',
        'display': 'default',
      });
      expect(category.display, WooCategoryDisplay.standard);
      expect(category.toJson()['display'], 'default');
    });
    test('WooProductVariation', () {
      final variation = WooProductVariation.fromJson({
        'id': 100,
        'date_created': '2023-03-23T10:45:00',
        'status': 'publish',
        'price': '12.50',
        'regular_price': '12.50',
        'manage_stock': true,
        'stock_quantity': 4,
        'attributes': [
          {'id': 1, 'name': 'Size', 'option': 'M'},
        ],
      });
      expect(variation.price, 12.5);
      expect(variation.stockQuantity, 4);
      expect(variation.status, WooProductStatus.publish);
      final reparsed = WooProductVariation.fromJson({
        'id': 100,
        'date_created': '2023-03-23T10:45:00',
        ...variation.toJson(),
      });
      expect(reparsed, variation);
    });
    test('WooWebhook', () {
      final webhook = WooWebhook.fromJson({
        'id': 3,
        'name': 'Order created',
        'status': 'active',
        'topic': 'order.created',
        'delivery_url': 'https://hooks.test/order',
      });
      expect(webhook.status, WooWebhookStatus.active);
      final reparsed = WooWebhook.fromJson({'id': 3, ...webhook.toJson()});
      expect(reparsed, webhook);
    });
    test('WooWebhookDelivery', () {
      final delivery = WooWebhookDelivery.fromJson({
        'id': 9,
        'created_at': '2023-03-23T10:45:00',
        'duration': '0.24',
        'request_url': 'https://hooks.test/order',
        'response_code': '200',
      });
      expect(delivery.responseCode, 200);
    });
  });
  group('equality', () {
    test('full-field equality, not id-only', () {
      final a = WooProduct.fromJson({'id': 1, 'name': 'A', 'price': '5.00'});
      final b = WooProduct.fromJson({'id': 1, 'name': 'B', 'price': '9.00'});
      expect(a, isNot(b));
      expect(
        WooProduct.fromJson({'id': 1, 'name': 'A', 'price': '5.00'}),
        a,
      );
    });
    test('copyWith replaces only given fields', () {
      final order = WooOrder(id: 7, status: WooOrderStatus.pending);
      final updated = order.copyWith(
        status: WooOrderStatus.processing,
        total: 42.0,
      );
      expect(updated.id, 7);
      expect(updated.status, WooOrderStatus.processing);
      expect(updated.total, 42.0);
      expect(order.status, WooOrderStatus.pending);
    });
  });
}
