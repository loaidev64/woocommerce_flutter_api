import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooDataEndpoint {
  WooDataEndpoint({this.slug, this.description});
  factory WooDataEndpoint.fromJson(Map<String, dynamic> json) =>
      WooDataEndpoint(
        slug: WooJson.readString(json, 'slug'),
        description: WooJson.readString(json, 'description'),
      );
  factory WooDataEndpoint.fake() => WooDataEndpoint(
        slug: FakeHelper.word(),
        description: FakeHelper.sentence(),
      );
  final String? slug;
  final String? description;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('slug', slug)
    ..putIfPresent('description', description);
  WooDataEndpoint copyWith({String? slug, String? description}) =>
      WooDataEndpoint(
        slug: slug ?? this.slug,
        description: description ?? this.description,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooDataEndpoint &&
        other.slug == slug &&
        other.description == description;
  }

  @override
  int get hashCode => Object.hashAll([slug, description]);
  @override
  String toString() => 'WooDataEndpoint(slug: $slug)';
}
