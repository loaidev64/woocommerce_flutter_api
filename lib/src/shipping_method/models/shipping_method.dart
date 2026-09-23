import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooShippingMethod {
  WooShippingMethod({this.id, this.title, this.description});
  factory WooShippingMethod.fromJson(Map<String, dynamic> json) =>
      WooShippingMethod(
        id: WooJson.readString(json, 'id'),
        title: WooJson.readString(json, 'title'),
        description: WooJson.readString(json, 'description'),
      );
  factory WooShippingMethod.fake() => WooShippingMethod(
        id: FakeHelper.word(),
        title: FakeHelper.sentence(),
        description: FakeHelper.sentence(),
      );
  final String? id;
  final String? title;
  final String? description;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putIfPresent('title', title)
    ..putIfPresent('description', description);
  WooShippingMethod copyWith(
          {String? id, String? title, String? description}) =>
      WooShippingMethod(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooShippingMethod &&
        other.id == id &&
        other.title == title &&
        other.description == description;
  }

  @override
  int get hashCode => Object.hashAll([id, title, description]);
  @override
  String toString() => 'WooShippingMethod(id: $id, title: $title)';
}
