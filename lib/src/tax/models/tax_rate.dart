import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

class WooTaxRate {
  /// Unique identifier for the resource. Read-only.
  int? id;

  /// Country ISO 3166 code.
  String? country;

  /// State code.
  String? state;

  /// Postcode/ZIP. Deprecated as of WooCommerce 5.3.
  String? postcode;

  /// City name. Deprecated as of WooCommerce 5.3.
  String? city;

  /// Postcodes/ZIPs. Introduced in WooCommerce 5.3.
  List<String>? postcodes;

  /// City names. Introduced in WooCommerce 5.3.
  List<String>? cities;

  /// Tax rate.
  String? rate;

  /// Tax rate name.
  String? name;

  /// Tax priority. Default is 1.
  int? priority;

  /// Whether or not this is a compound tax rate. Default is false.
  bool? compound;

  /// Whether or not this tax rate also gets applied to shipping. Default is true.
  bool? shipping;

  /// Indicates the order that will appear in queries.
  int? order;

  /// Tax class. Default is standard.
  String? taxClass;

  WooTaxRate({
    this.id,
    this.country,
    this.state,
    this.postcode,
    this.city,
    this.postcodes,
    this.cities,
    this.rate,
    this.name,
    this.priority = 1,
    this.compound = false,
    this.shipping = true,
    this.order,
    this.taxClass = 'standard',
  });

  WooTaxRate.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        country = json['country'],
        state = json['state'],
        postcode = json['postcode'],
        city = json['city'],
        postcodes = json['postcodes'] != null
            ? List<String>.from(json['postcodes'])
            : null,
        cities =
            json['cities'] != null ? List<String>.from(json['cities']) : null,
        rate = json['rate'],
        name = json['name'],
        priority = json['priority'],
        compound = json['compound'],
        shipping = json['shipping'],
        order = json['order'],
        taxClass = json['class'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'country': country,
        'state': state,
        'postcode': postcode,
        'city': city,
        'postcodes': postcodes,
        'cities': cities,
        'rate': rate,
        'name': name,
        'priority': priority,
        'compound': compound,
        'shipping': shipping,
        'order': order,
        'class': taxClass,
      };

  @override
  String toString() => toJson().toString();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WooTaxRate &&
        other.id == id &&
        other.country == country &&
        other.state == state &&
        other.postcode == postcode &&
        other.city == city &&
        other.postcodes == postcodes &&
        other.cities == cities &&
        other.rate == rate &&
        other.name == name &&
        other.priority == priority &&
        other.compound == compound &&
        other.shipping == shipping &&
        other.order == order &&
        other.taxClass == taxClass;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      country.hashCode ^
      state.hashCode ^
      postcode.hashCode ^
      city.hashCode ^
      postcodes.hashCode ^
      cities.hashCode ^
      rate.hashCode ^
      name.hashCode ^
      priority.hashCode ^
      compound.hashCode ^
      shipping.hashCode ^
      order.hashCode ^
      taxClass.hashCode;

  factory WooTaxRate.fake([int? id]) => WooTaxRate(
        id: id ?? FakeHelper.integer(),
        country: FakeHelper.countryCode(),
        state: FakeHelper.state(),
        postcode: FakeHelper.zipCode(),
        city: FakeHelper.city(),
        postcodes: FakeHelper.list(FakeHelper.zipCode),
        cities: FakeHelper.list(FakeHelper.city),
        rate: FakeHelper.decimal().toString(),
        name: FakeHelper.word(),
        priority: FakeHelper.integer(min: 1, max: 10),
        compound: FakeHelper.boolean(),
        shipping: FakeHelper.boolean(),
        order: FakeHelper.integer(),
        taxClass: FakeHelper.word(),
      );
}
