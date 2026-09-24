import 'package:faker/faker.dart';
import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooProductItemAttribute {
  WooProductItemAttribute({
    this.id,
    this.name,
    this.position,
    this.visible,
    this.variation,
    this.options,
  });
  factory WooProductItemAttribute.fromJson(Map<String, dynamic> json) {
    final rawOptions = json['options'];
    return WooProductItemAttribute(
      id: WooJson.readInt(json, 'id'),
      name: WooJson.readString(json, 'name'),
      position: WooJson.readInt(json, 'position'),
      visible: WooJson.readBool(json, 'visible'),
      variation: WooJson.readBool(json, 'variation'),
      options: rawOptions is List
          ? [
              for (final option in rawOptions)
                if (option != null) option.toString()
            ]
          : json['option'] != null
              ? [json['option'] as String]
              : null,
    );
  }
  factory WooProductItemAttribute.fake() => WooProductItemAttribute(
        id: FakeHelper.integer(),
        name: FakeHelper.word(),
        position: FakeHelper.integer(),
        visible: FakeHelper.boolean(),
        variation: FakeHelper.boolean(),
        options:
            List.filled(Faker().randomGenerator.integer(10), FakeHelper.word()),
      );
  final int? id;
  final String? name;
  final int? position;
  final bool? visible;
  final bool? variation;
  final List<String>? options;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putIfPresent('name', name)
    ..putIfPresent('position', position)
    ..putIfPresent('visible', visible)
    ..putIfPresent('variation', variation)
    ..putIfPresent('options', options);
  WooProductItemAttribute copyWith({
    int? id,
    String? name,
    int? position,
    bool? visible,
    bool? variation,
    List<String>? options,
  }) =>
      WooProductItemAttribute(
        id: id ?? this.id,
        name: name ?? this.name,
        position: position ?? this.position,
        visible: visible ?? this.visible,
        variation: variation ?? this.variation,
        options: options ?? this.options,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductItemAttribute &&
          other.id == id &&
          other.name == name &&
          other.position == position &&
          other.visible == visible &&
          other.variation == variation &&
          WooJson.listEquals(other.options, options);
  @override
  int get hashCode => Object.hashAll([
        id,
        name,
        position,
        visible,
        variation,
        ...(options ?? const []),
      ]);
  @override
  String toString() =>
      'WooProductItemAttribute(id: $id, name: $name, position: $position, '
      'visible: $visible, variation: $variation, options: $options)';
}

class WooProductDefaultAttribute {
  WooProductDefaultAttribute({this.id, this.name, this.option});
  factory WooProductDefaultAttribute.fromJson(Map<String, dynamic> json) =>
      WooProductDefaultAttribute(
        id: WooJson.readInt(json, 'id'),
        name: WooJson.readString(json, 'name'),
        option: WooJson.readString(json, 'option'),
      );
  factory WooProductDefaultAttribute.fake() => WooProductDefaultAttribute(
        id: FakeHelper.integer(),
        name: FakeHelper.word(),
        option: FakeHelper.word(),
      );
  final int? id;
  final String? name;
  final String? option;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putIfPresent('name', name)
    ..putIfPresent('option', option);
  WooProductDefaultAttribute copyWith({
    int? id,
    String? name,
    String? option,
  }) =>
      WooProductDefaultAttribute(
        id: id ?? this.id,
        name: name ?? this.name,
        option: option ?? this.option,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductDefaultAttribute &&
          other.id == id &&
          other.name == name &&
          other.option == option;
  @override
  int get hashCode => Object.hashAll([id, name, option]);
  @override
  String toString() =>
      'WooProductDefaultAttribute(id: $id, name: $name, option: $option)';
}
