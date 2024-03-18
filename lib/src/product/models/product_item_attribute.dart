import 'package:faker/faker.dart';
import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

class WooProductItemAttribute {
  /// Attribute ID.
  final int? id;

  /// Attribute name.
  final String? name;

  /// Attribute position.
  final int? position;

  /// Define if the attribute is visible on the "Additional information" tab in the product's page. Default is false.
  final bool? visible;

  /// Define if the attribute can be used as variation. Default is false.
  final bool? variation;

  /// List of available term names of the attribute.
  final List<String>? options;

  WooProductItemAttribute(this.id, this.name, this.position, this.visible,
      this.variation, this.options);

  WooProductItemAttribute.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        position = json['position'],
        visible = json['visible'],
        variation = json['variation'],
        options = json['options'].cast<String>();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'position': position,
        'visible': visible,
        'variation': variation,
        'options': options,
      };

  factory WooProductItemAttribute.fake() => WooProductItemAttribute(
        FakeHelper.integer(),
        FakeHelper.word(),
        FakeHelper.integer(),
        FakeHelper.boolean(),
        FakeHelper.boolean(),
        List.filled(Faker().randomGenerator.integer(10), FakeHelper.word()),
      );
}

class WooProductDefaultAttribute {
  /// Attribute ID.
  final int? id;

  /// Attribute name.
  final String? name;

  /// Selected attribute term name.
  final String? option;

  WooProductDefaultAttribute(this.id, this.name, this.option);

  WooProductDefaultAttribute.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        option = json['option'];

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'option': option};

  factory WooProductDefaultAttribute.fake() => WooProductDefaultAttribute(
        FakeHelper.integer(),
        FakeHelper.word(),
        FakeHelper.word(),
      );
}
