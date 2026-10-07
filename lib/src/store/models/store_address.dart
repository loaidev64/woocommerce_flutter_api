import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooStoreAddress {
  const WooStoreAddress({
    this.firstName = '',
    this.lastName = '',
    this.company = '',
    this.address1 = '',
    this.address2 = '',
    this.city = '',
    this.state = '',
    this.postcode = '',
    this.country = '',
    this.email = '',
    this.phone = '',
  });

  factory WooStoreAddress.fromJson(Map<String, dynamic> json) =>
      WooStoreAddress(
        firstName: WooJson.readString(json, 'first_name') ?? '',
        lastName: WooJson.readString(json, 'last_name') ?? '',
        company: WooJson.readString(json, 'company') ?? '',
        address1: WooJson.readString(json, 'address_1') ?? '',
        address2: WooJson.readString(json, 'address_2') ?? '',
        city: WooJson.readString(json, 'city') ?? '',
        state: WooJson.readString(json, 'state') ?? '',
        postcode: WooJson.readString(json, 'postcode') ?? '',
        country: WooJson.readString(json, 'country') ?? '',
        email: WooJson.readString(json, 'email') ?? '',
        phone: WooJson.readString(json, 'phone') ?? '',
      );

  factory WooStoreAddress.fake() => WooStoreAddress(
        firstName: FakeHelper.firstName(),
        lastName: FakeHelper.lastName(),
        company: FakeHelper.company(),
        address1: FakeHelper.address(),
        address2: FakeHelper.address(),
        city: FakeHelper.city(),
        state: FakeHelper.state(),
        postcode: FakeHelper.zipCode(),
        country: FakeHelper.countryCode(),
        email: FakeHelper.email(),
        phone: FakeHelper.phoneNumber(),
      );

  final String firstName;

  final String lastName;

  final String company;

  final String address1;

  final String address2;

  final String city;

  final String state;

  final String postcode;

  final String country;

  final String email;

  final String phone;

  String get fullName => <String>[firstName, lastName]
      .where((value) => value.isNotEmpty)
      .join(' ');

  bool get isEmpty =>
      firstName.isEmpty &&
      lastName.isEmpty &&
      address1.isEmpty &&
      city.isEmpty &&
      postcode.isEmpty &&
      country.isEmpty;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'first_name': firstName,
        'last_name': lastName,
        'company': company,
        'address_1': address1,
        'address_2': address2,
        'city': city,
        'state': state,
        'postcode': postcode,
        'country': country,
        if (email.isNotEmpty) 'email': email,
        if (phone.isNotEmpty) 'phone': phone,
      };

  WooStoreAddress copyWith({
    String? firstName,
    String? lastName,
    String? company,
    String? address1,
    String? address2,
    String? city,
    String? state,
    String? postcode,
    String? country,
    String? email,
    String? phone,
  }) =>
      WooStoreAddress(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        company: company ?? this.company,
        address1: address1 ?? this.address1,
        address2: address2 ?? this.address2,
        city: city ?? this.city,
        state: state ?? this.state,
        postcode: postcode ?? this.postcode,
        country: country ?? this.country,
        email: email ?? this.email,
        phone: phone ?? this.phone,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooStoreAddress &&
          other.firstName == firstName &&
          other.lastName == lastName &&
          other.company == company &&
          other.address1 == address1 &&
          other.address2 == address2 &&
          other.city == city &&
          other.state == state &&
          other.postcode == postcode &&
          other.country == country &&
          other.email == email &&
          other.phone == phone;

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
        email,
        phone,
      ]);

  @override
  String toString() => 'WooStoreAddress(${<String>[
        fullName,
        city,
        country,
      ].where((value) => value.isNotEmpty).join(', ')})';
}
