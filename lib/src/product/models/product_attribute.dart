import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';
import '../enums/product_attribute_order_by.dart';
import '../enums/product_attribute_type.dart';

class WooProductAttribute {
  WooProductAttribute({
    this.id,
    this.name,
    this.slug,
    this.type,
    this.orderBy,
    this.hasArchives,
  });
  factory WooProductAttribute.fromJson(Map<String, dynamic> json) =>
      WooProductAttribute(
        id: WooJson.readInt(json, 'id'),
        name: WooJson.readString(json, 'name'),
        slug: WooJson.readString(json, 'slug'),
        type: WooJson.readEnum(json, 'type', WooProductAttributeType.values),
        orderBy: WooJson.readEnum(
          json,
          'order_by',
          WooProductAttributeOrderBy.values,
        ),
        hasArchives: WooJson.readBool(json, 'has_archives'),
      );
  factory WooProductAttribute.fake({int? id}) => WooProductAttribute(
        id: id ?? FakeHelper.integer(),
        name: FakeHelper.word(),
        slug: FakeHelper.word(),
        type: WooProductAttributeType.fake(),
        orderBy: WooProductAttributeOrderBy.fake(),
        hasArchives: FakeHelper.boolean(),
      );
  final int? id;
  final String? name;
  final String? slug;
  final WooProductAttributeType? type;
  final WooProductAttributeOrderBy? orderBy;
  final bool? hasArchives;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putIfPresent('name', name)
    ..putIfPresent('slug', slug)
    ..putEnum('type', type)
    ..putEnum('order_by', orderBy)
    ..putIfPresent('has_archives', hasArchives);
  WooProductAttribute copyWith({
    int? id,
    String? name,
    String? slug,
    WooProductAttributeType? type,
    WooProductAttributeOrderBy? orderBy,
    bool? hasArchives,
  }) =>
      WooProductAttribute(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        type: type ?? this.type,
        orderBy: orderBy ?? this.orderBy,
        hasArchives: hasArchives ?? this.hasArchives,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooProductAttribute &&
          other.id == id &&
          other.name == name &&
          other.slug == slug &&
          other.type == type &&
          other.orderBy == orderBy &&
          other.hasArchives == hasArchives;
  @override
  int get hashCode =>
      Object.hashAll([id, name, slug, type, orderBy, hasArchives]);
  @override
  String toString() => 'WooProductAttribute(id: $id, name: $name, slug: $slug)';
}
