import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooShipping {
  WooShipping({
    this.firstName,
    this.lastName,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postcode,
    this.country,
  });
  factory WooShipping.fromJson(Map<String, dynamic> json) => WooShipping(
        firstName: WooJson.readString(json, 'first_name'),
        lastName: WooJson.readString(json, 'last_name'),
        company: WooJson.readString(json, 'company'),
        address1: WooJson.readString(json, 'address_1'),
        address2: WooJson.readString(json, 'address_2'),
        city: WooJson.readString(json, 'city'),
        state: WooJson.readString(json, 'state'),
        postcode: WooJson.readString(json, 'postcode'),
        country: WooJson.readString(json, 'country'),
      );
  factory WooShipping.fake() => WooShipping(
        firstName: FakeHelper.firstName(),
        lastName: FakeHelper.lastName(),
        address1: FakeHelper.address(),
        address2: FakeHelper.address(),
        city: FakeHelper.city(),
        country: FakeHelper.country(),
        state: FakeHelper.state(),
        company: FakeHelper.company(),
        postcode: FakeHelper.zipCode(),
      );
  final String? firstName;
  final String? lastName;
  final String? company;
  final String? address1;
  final String? address2;
  final String? city;
  final String? state;
  final String? postcode;
  final String? country;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('first_name', firstName)
    ..putIfPresent('last_name', lastName)
    ..putIfPresent('company', company)
    ..putIfPresent('address_1', address1)
    ..putIfPresent('address_2', address2)
    ..putIfPresent('city', city)
    ..putIfPresent('state', state)
    ..putIfPresent('postcode', postcode)
    ..putIfPresent('country', country);
  WooShipping copyWith({
    String? firstName,
    String? lastName,
    String? company,
    String? address1,
    String? address2,
    String? city,
    String? state,
    String? postcode,
    String? country,
  }) =>
      WooShipping(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        company: company ?? this.company,
        address1: address1 ?? this.address1,
        address2: address2 ?? this.address2,
        city: city ?? this.city,
        state: state ?? this.state,
        postcode: postcode ?? this.postcode,
        country: country ?? this.country,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooShipping &&
          other.firstName == firstName &&
          other.lastName == lastName &&
          other.company == company &&
          other.address1 == address1 &&
          other.address2 == address2 &&
          other.city == city &&
          other.state == state &&
          other.postcode == postcode &&
          other.country == country;
  @override
  int get hashCode => Object.hashAll([
        firstName,
        lastName,
        company,
        address1,
        address2,
        city,
        state,
        postcode,
        country,
      ]);
  @override
  String toString() {
    return 'WooShipping(firstName: $firstName, lastName: $lastName, city: $city, country: $country)';
  }
}
