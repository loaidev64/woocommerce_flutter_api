import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooTaxClass {
  WooTaxClass({this.slug, this.name});
  factory WooTaxClass.fromJson(Map<String, dynamic> json) => WooTaxClass(
        slug: WooJson.readString(json, 'slug'),
        name: WooJson.readString(json, 'name'),
      );
  factory WooTaxClass.fake() => WooTaxClass(
        slug: FakeHelper.word(),
        name: FakeHelper.word(),
      );
  final String? slug;
  final String? name;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('slug', slug)
    ..putIfPresent('name', name);
  WooTaxClass copyWith({String? slug, String? name}) => WooTaxClass(
        slug: slug ?? this.slug,
        name: name ?? this.name,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooTaxClass && other.slug == slug && other.name == name;
  }

  @override
  int get hashCode => Object.hashAll([slug, name]);
  @override
  String toString() => 'WooTaxClass(slug: $slug, name: $name)';
}
