import 'package:faker/faker.dart';
import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

/// Represents a product attribute with options and settings.
///
/// Brief description of the model's purpose and usage for product attributes.
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

  /// Creates a new WooProductItemAttribute instance.
  WooProductItemAttribute(this.id, this.name, this.position, this.visible,
      this.variation, this.options);

  /// Creates a WooProductItemAttribute instance from JSON data.
  WooProductItemAttribute.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        position = json['position'],
        visible = json['visible'],
        variation = json['variation'],
        options = json['options'].cast<String>();

  /// Converts the WooProductItemAttribute instance to JSON format.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'position': position,
        'visible': visible,
        'variation': variation,
        'options': options,
      };

  /// Creates a fake WooProductItemAttribute instance for testing purposes.
  factory WooProductItemAttribute.fake() => WooProductItemAttribute(
        FakeHelper.integer(),
        FakeHelper.word(),
        FakeHelper.integer(),
        FakeHelper.boolean(),
        FakeHelper.boolean(),
        List.filled(Faker().randomGenerator.integer(10), FakeHelper.word()),
      );

  /// Returns a string representation of the WooProductItemAttribute instance.
  ///
  /// Displays all main fields for debugging and logging purposes.
  @override
  String toString() {
    return 'WooProductItemAttribute(id: $id, name: $name, position: $position, visible: $visible, variation: $variation, options: $options)';
  }
}

/// Represents a default product attribute with selected option.
///
/// Brief description of the model's purpose and usage for default product attributes.
class WooProductDefaultAttribute {
  /// Attribute ID.
  final int? id;

  /// Attribute name.
  final String? name;

  /// Selected attribute term name.
  final String? option;

  /// Creates a new WooProductDefaultAttribute instance.
  WooProductDefaultAttribute(this.id, this.name, this.option);

  /// Creates a WooProductDefaultAttribute instance from JSON data.
  WooProductDefaultAttribute.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        option = json['option'];

  /// Converts the WooProductDefaultAttribute instance to JSON format.
  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'option': option};

  /// Creates a fake WooProductDefaultAttribute instance for testing purposes.
  factory WooProductDefaultAttribute.fake() => WooProductDefaultAttribute(
        FakeHelper.integer(),
        FakeHelper.word(),
        FakeHelper.word(),
      );

  /// Returns a string representation of the WooProductDefaultAttribute instance.
  ///
  /// Displays all main fields for debugging and logging purposes.
  @override
  String toString() {
    return 'WooProductDefaultAttribute(id: $id, name: $name, option: $option)';
  }
}
