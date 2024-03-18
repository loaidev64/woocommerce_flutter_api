import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

void main() async {
  final woocommerce = WooCommerce(
    baseUrl: 'https://example.com',
    username: 'djasio',
    password: 'ldp[sald]',
    useFaker: true,
  );
  final products = await woocommerce.getCategories();

  print(products);
}
