// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

/// Represents billing address information for a WooCommerce order.
///
/// Contains customer billing details including name, address, contact information,
/// and company details. Used for order processing and customer communication.
class WooBilling {
  /// Customer's first name.
  String? firstName;

  /// Customer's last name.
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

  /// Customer's email address.
  String? email;

  /// Customer's phone number.
  String? phone;

  /// Creates a new WooBilling instance.
  WooBilling(
      {this.firstName,
      this.lastName,
      this.company,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.postcode,
      this.country,
      this.email,
      this.phone});

  /// Creates a WooBilling instance from JSON data.
  WooBilling.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    company = json['company'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
    email = json['email'];
    phone = json['phone'];
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
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }

  factory WooBilling.fake() => WooBilling(
        firstName: FakeHelper.firstName(),
        lastName: FakeHelper.lastName(),
        address1: FakeHelper.address(),
        address2: FakeHelper.address(),
        city: FakeHelper.city(),
        country: FakeHelper.country(),
        state: FakeHelper.state(),
        company: FakeHelper.company(),
        email: FakeHelper.email(),
        phone: FakeHelper.phoneNumber(),
        postcode: FakeHelper.zipCode(),
      );

  /// Returns a string representation of the WooBilling instance.
  ///
  /// Displays all main fields for debugging and logging purposes.
  @override
  String toString() {
    return 'WooBilling(firstName: $firstName, lastName: $lastName, email: $email, phone: $phone)';
  }
}
