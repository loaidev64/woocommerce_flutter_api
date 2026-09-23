import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooTaxRate {
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
  factory WooTaxRate.fromJson(Map<String, dynamic> json) => WooTaxRate(
        id: WooJson.readInt(json, 'id'),
        country: WooJson.readString(json, 'country'),
        state: WooJson.readString(json, 'state'),
        postcode: WooJson.readString(json, 'postcode'),
        city: WooJson.readString(json, 'city'),
        postcodes: _readStringList(json, 'postcodes'),
        cities: _readStringList(json, 'cities'),
        rate: WooJson.readString(json, 'rate'),
        name: WooJson.readString(json, 'name'),
        priority: WooJson.readInt(json, 'priority') ?? 1,
        compound: WooJson.readBool(json, 'compound') ?? false,
        shipping: WooJson.readBool(json, 'shipping') ?? true,
        order: WooJson.readInt(json, 'order'),
        taxClass: WooJson.readString(json, 'class') ?? 'standard',
      );
  factory WooTaxRate.fake({int? id}) => WooTaxRate(
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
  final int? id;
  final String? country;
  final String? state;
  final String? postcode;
  final String? city;
  final List<String>? postcodes;
  final List<String>? cities;
  final String? rate;
  final String? name;
  final int? priority;
  final bool? compound;
  final bool? shipping;
  final int? order;
  final String? taxClass;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putIfPresent('country', country)
    ..putIfPresent('state', state)
    ..putIfPresent('postcode', postcode)
    ..putIfPresent('city', city)
    ..putIfPresent('postcodes', postcodes)
    ..putIfPresent('cities', cities)
    ..putIfPresent('rate', rate)
    ..putIfPresent('name', name)
    ..putIfPresent('priority', priority)
    ..putIfPresent('compound', compound)
    ..putIfPresent('shipping', shipping)
    ..putIfPresent('order', order)
    ..putIfPresent('class', taxClass);
  WooTaxRate copyWith({
    int? id,
    String? country,
    String? state,
    String? postcode,
    String? city,
    List<String>? postcodes,
    List<String>? cities,
    String? rate,
    String? name,
    int? priority,
    bool? compound,
    bool? shipping,
    int? order,
    String? taxClass,
  }) =>
      WooTaxRate(
        id: id ?? this.id,
        country: country ?? this.country,
        state: state ?? this.state,
        postcode: postcode ?? this.postcode,
        city: city ?? this.city,
        postcodes: postcodes ?? this.postcodes,
        cities: cities ?? this.cities,
        rate: rate ?? this.rate,
        name: name ?? this.name,
        priority: priority ?? this.priority,
        compound: compound ?? this.compound,
        shipping: shipping ?? this.shipping,
        order: order ?? this.order,
        taxClass: taxClass ?? this.taxClass,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooTaxRate &&
        other.id == id &&
        other.country == country &&
        other.state == state &&
        other.postcode == postcode &&
        other.city == city &&
        WooJson.listEquals(other.postcodes, postcodes) &&
        WooJson.listEquals(other.cities, cities) &&
        other.rate == rate &&
        other.name == name &&
        other.priority == priority &&
        other.compound == compound &&
        other.shipping == shipping &&
        other.order == order &&
        other.taxClass == taxClass;
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        country,
        state,
        postcode,
        city,
        Object.hashAll(postcodes ?? const []),
        Object.hashAll(cities ?? const []),
        rate,
        name,
        priority,
        compound,
        shipping,
        order,
        taxClass,
      ]);
  @override
  String toString() => 'WooTaxRate(id: $id, country: $country, '
      'state: $state, rate: $rate, name: $name)';
  static List<String>? _readStringList(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is! List) return null;
    return [for (final element in value) element.toString()];
  }
}
