library;

// ignore_for_file: avoid_print
import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

final _baseUrl = 'https://yourstore.com';
final _consumerKey = 'ck_your_consumer_key';
final _consumerSecret = 'cs_your_consumer_secret';
WooCommerce createClient({bool useFaker = true}) => WooCommerce(
      baseUrl: _baseUrl,
      consumerKey: _consumerKey,
      consumerSecret: _consumerSecret,
    );
void main() {
  fakeDataExample();
}

Future<void> productsExample() async {
  final woocommerce = createClient(useFaker: false);
  final created = await woocommerce.createProduct(
    WooProduct(
      name: 'Vinyl Album',
      type: WooProductType.simple,
      regularPrice: 20.0,
      salePrice: 15.0,
      status: WooProductStatus.publish,
      catalogVisibility: WooProductCatalogVisibility.visible,
    ),
  );
  print('Created product #${created.id}: ${created.name}');
  final updated = await woocommerce.updateProduct(
    created.id!,
    created.copyWith(
      description: 'Limited pressing',
      stockStatus: WooProductStockStatus.instock,
    ),
  );
  print('Updated product: ${updated.name} (${updated.status?.value})');
  final deleted = await woocommerce.deleteProduct(created.id!);
  print('Deleted: ${deleted.deleted}');
}

Future<void> paginationExample() async {
  final woocommerce = createClient(useFaker: false);
  var page = await woocommerce.getProducts(perPage: 20);
  print('${page.totalItems} products across ${page.totalPages} pages');
  print('Page ${page.page}: ${page.items.length} items');
  while (page.hasNextPage) {
    page = await woocommerce.getProducts(page: page.page + 1, perPage: 20);
    print('Page ${page.page}: ${page.items.length} items');
  }
}

Future<void> ordersExample() async {
  final woocommerce = createClient(useFaker: false);
  final ordersPage = await woocommerce.getOrders(
    status: [WooOrderStatus.processing],
    order: WooSort.desc,
    orderBy: WooOrderBy.date,
  );
  print('${ordersPage.totalItems} processing orders');
  for (final order in ordersPage.items.take(3)) {
    print('Order #${order.id}: ${order.status?.value} — ${order.total}');
  }
  final order = ordersPage.items.firstOrNull;
  if (order != null) {
    final completed = await woocommerce.updateOrder(
      order.id!,
      order.copyWith(status: WooOrderStatus.completed),
    );
    print('Order #${completed.id} → ${completed.status?.value}');
    print('Currency (ISO code): ${completed.currency ?? WooCurrency.usd}');
  }
}

Future<void> productAttributesExample() async {
  final woocommerce = createClient(useFaker: false);
  final attribute = await woocommerce.createProductAttribute(
    WooProductAttribute(
      name: 'Size',
      slug: 'size',
      type: WooProductAttributeType.select,
      orderBy: WooProductAttributeOrderBy.menuOrder,
      hasArchives: true,
    ),
  );
  print('Created attribute #${attribute.id}: ${attribute.name}');
  final term = await woocommerce.createProductAttributeTerm(
    attribute.id!,
    WooProductAttributeTerm(name: 'Medium', slug: 'medium'),
  );
  print('Created term #${term.id}: ${term.name}');
  final terms = await woocommerce.getProductAttributeTerms(attribute.id!);
  print('${terms.totalItems} terms on this attribute');
}

Future<void> errorHandlingExample() async {
  final woocommerce = createClient(useFaker: false);
  try {
    await woocommerce.getProduct(999999);
  } on WooCommerceNotFoundException {
    print('Product does not exist');
  } on WooCommerceAuthException {
    print('Check your consumer key and secret');
  } on WooCommerceValidationException catch (e) {
    print('Invalid request: ${e.code} — ${e.message}');
  } on WooCommerceRateLimitException catch (e) {
    print('Rate limited; retry after ${e.retryAfterSeconds ?? 'a while'}s');
  } on WooCommerceException catch (e) {
    print('${e.statusCode}: ${e.message}');
  }
}

Future<void> cartAndCheckoutExample() async {
  final woocommerce = createClient(useFaker: false);

  await woocommerce.addToCart(id: 799, quantity: 2);
  await woocommerce.addToCart(
    id: 815,
    variation: {'pa_colour': 'blue'},
  );

  final cart = await woocommerce.getCart();
  print('${cart.itemsCount} items — ${cart.totals.totalPrice}');

  final quoted = await woocommerce.updateCartCustomer(
    shippingAddress: const WooStoreAddress(postcode: 'N1 7GU', country: 'GB'),
  );
  for (final package in quoted.shippingPackages) {
    for (final rate in package.rates) {
      print('${rate.name} — $rate');
    }
  }

  await woocommerce.applyCoupon('SAVE10');

  final result = await woocommerce.checkoutAndClear(
    billingAddress: const WooStoreAddress(
      firstName: 'Ada',
      lastName: 'Lovelace',
      address1: '12 Analytical Way',
      city: 'London',
      postcode: 'N1 7GU',
      country: 'GB',
      email: 'ada@example.com',
    ),
    paymentMethod: 'cod',
    expectedTotal: quoted.totals.totalPrice,
  );

  if (result.paymentResult.needsRedirect) {
    print('Finish paying at ${result.paymentResult.redirectUrl}');
  } else if (result.isPaid) {
    print('Order ${result.orderId} placed');
  }
}

void fakeDataExample() {
  final woocommerce = createClient();
  final products = woocommerce.getProducts(perPage: 5);
  products.then((page) {
    for (final product in page.items) {
      print('${product.name} — \$${product.price}');
    }
  });
}
