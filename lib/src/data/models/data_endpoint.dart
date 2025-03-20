import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

class WooDataEndpoint {
  final String? slug;
  final String? description;

  WooDataEndpoint({this.slug, this.description});

  factory WooDataEndpoint.fromJson(Map<String, dynamic> json) => WooDataEndpoint(
    slug: json['slug'],
    description: json['description'],
  );

  factory WooDataEndpoint.fake() => WooDataEndpoint(
    slug: FakeHelper.word(),
    description: FakeHelper.sentence(),
  );
}