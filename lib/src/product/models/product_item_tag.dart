import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

class WooProductItemTag {
  /// Tag ID.
  final int? id;

  /// Tag name.
  final String? name;

  /// Tag slug.
  final String? slug;

  WooProductItemTag(this.id, this.name, this.slug);

  WooProductItemTag.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        slug = json['slug'];

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'slug': slug};

  @override
  toString() => 'Tag: $name';

  factory WooProductItemTag.fake() => WooProductItemTag(
        FakeHelper.integer(),
        FakeHelper.word(),
        FakeHelper.url(),
      );
}
