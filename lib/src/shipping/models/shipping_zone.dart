import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooShippingZone {
  WooShippingZone({this.id, this.name, this.order});
  factory WooShippingZone.fromJson(Map<String, dynamic> json) =>
      WooShippingZone(
        id: WooJson.readInt(json, 'id'),
        name: WooJson.readString(json, 'name'),
        order: WooJson.readInt(json, 'order'),
      );
  factory WooShippingZone.fake() => WooShippingZone(
        id: FakeHelper.integer(),
        name: FakeHelper.sentence(),
        order: FakeHelper.integer(),
      );
  final int? id;
  final String? name;
  final int? order;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putIfPresent('name', name)
    ..putIfPresent('order', order);
  WooShippingZone copyWith({int? id, String? name, int? order}) =>
      WooShippingZone(
        id: id ?? this.id,
        name: name ?? this.name,
        order: order ?? this.order,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooShippingZone &&
        other.id == id &&
        other.name == name &&
        other.order == order;
  }

  @override
  int get hashCode => Object.hashAll([id, name, order]);
  @override
  String toString() => 'WooShippingZone(id: $id, name: $name, order: $order)';
}
