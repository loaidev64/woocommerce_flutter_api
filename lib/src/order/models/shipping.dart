import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

class WooShipping {
  /// First name.
  String? firstName;

  /// Last name.
  String? lastName;

  /// Company name.
  String? company;

  /// Address line 1
  String? address1;

  /// Address line 2
  String? address2;

  /// City name.
  String? city;

  /// ISO code or name of the state, province or district.
  String? state;

  /// Postal code.
  String? postcode;

  /// Country code in ISO 3166-1 alpha-2 format.
  String? country;

  WooShipping(
      {this.firstName,
      this.lastName,
      this.company,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.postcode,
      this.country});

  WooShipping.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    company = json['company'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['company'] = company;
    data['address_1'] = address1;
    data['address_2'] = address2;
    data['city'] = city;
    data['state'] = state;
    data['postcode'] = postcode;
    data['country'] = country;
    return data;
  }

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
}
