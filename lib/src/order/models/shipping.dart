import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

/// Represents shipping address information for a WooCommerce order.
///
/// Contains customer shipping details including name, address, and company information.
/// Used for order fulfillment and delivery purposes.
class WooShipping {

  /// Creates a new WooShipping instance.
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

  /// Creates a WooShipping instance from JSON data.
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
  /// Recipient's first name.
  String? firstName;

  /// Recipient's last name.
  String? lastName;

  /// Company name (optional).
  String? company;

  /// Primary address line.
  String? address1;

  /// Secondary address line (apartment, suite, etc.).
  String? address2;

  /// City name.
  String? city;

  /// State, province, or district code/name.
  String? state;

  /// Postal or ZIP code.
  String? postcode;

  /// Country code in ISO 3166-1 alpha-2 format.
  String? country;

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

  /// Returns a string representation of the WooShipping instance.
  ///
  /// Displays all main fields for debugging and logging purposes.
  @override
  String toString() {
    return 'WooShipping(firstName: $firstName, lastName: $lastName, city: $city, country: $country)';
  }
}
