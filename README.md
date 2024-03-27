<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

This is a package to woocommerce api.

## Features

- Authentication
- Notifications
- Cart
- Woocommerce API

## Getting started

flutter pub add woocommerce_flutter_api

## Usage


```dart
final woocommerce = WooCommerce(
    baseUrl: 'https://example.com',
    username: 'ck_12abc34n56j',
    password: 'cs_1uab8h3s3op',
    useFaker: true,
  );

final products = await woocommerce.getProducts();

print(products);
```

## Additional information

You can reach us using amjadqasem07@gmail.com if you have some questions.