import '../../base/models/metadata.dart';
import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';
import '../../order/models/billing.dart';
import '../../order/models/shipping.dart';
import '../enums/customer_role.dart';

class WooCustomer {
  WooCustomer({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.email,
    this.firstName,
    this.lastName,
    this.role,
    this.username,
    this.password,
    this.billing,
    this.shipping,
    this.isPayingCustomer,
    this.avatarUrl,
    this.metaData,
  });
  factory WooCustomer.fromJson(Map<String, dynamic> json) {
    final billingJson = WooJson.readMap(json, 'billing');
    final shippingJson = WooJson.readMap(json, 'shipping');
    return WooCustomer(
      id: WooJson.readInt(json, 'id'),
      dateCreated: WooJson.readDate(json, 'date_created'),
      dateCreatedGmt: WooJson.readDate(json, 'date_created_gmt'),
      dateModified: WooJson.readDate(json, 'date_modified'),
      dateModifiedGmt: WooJson.readDate(json, 'date_modified_gmt'),
      email: WooJson.readString(json, 'email'),
      firstName: WooJson.readString(json, 'first_name'),
      lastName: WooJson.readString(json, 'last_name'),
      role: WooJson.readEnum(json, 'role', WooCustomerRole.values),
      username: WooJson.readString(json, 'username'),
      password: WooJson.readString(json, 'password'),
      billing: billingJson == null ? null : WooBilling.fromJson(billingJson),
      shipping:
          shippingJson == null ? null : WooShipping.fromJson(shippingJson),
      isPayingCustomer: WooJson.readBool(json, 'is_paying_customer'),
      avatarUrl: WooJson.readString(json, 'avatar_url'),
      metaData: WooJson.readList(json, 'meta_data', WooMetaData.fromJson),
    );
  }
  factory WooCustomer.fake({int? id}) => WooCustomer(
        id: id ?? FakeHelper.integer(),
        firstName: FakeHelper.firstName(),
        lastName: FakeHelper.lastName(),
        email: FakeHelper.email(),
        password: FakeHelper.firstName(),
        username: FakeHelper.firstName(),
        avatarUrl: FakeHelper.image(),
        billing: WooBilling.fake(),
        dateCreated: FakeHelper.datetime(),
        dateCreatedGmt: FakeHelper.datetime(),
        dateModified: FakeHelper.datetime(),
        dateModifiedGmt: FakeHelper.datetime(),
        isPayingCustomer: FakeHelper.boolean(),
        metaData: FakeHelper.list(() => WooMetaData.fake()),
        role: WooCustomerRole.customer,
        shipping: WooShipping.fake(),
      );
  final int? id;
  final DateTime? dateCreated;
  final DateTime? dateCreatedGmt;
  final DateTime? dateModified;
  final DateTime? dateModifiedGmt;
  final String? email;
  final String? firstName;
  final String? lastName;
  final WooCustomerRole? role;
  final String? username;
  final String? password;
  final WooBilling? billing;
  final WooShipping? shipping;
  final bool? isPayingCustomer;
  final String? avatarUrl;
  final List<WooMetaData>? metaData;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putDate('date_created', dateCreated)
    ..putDate('date_created_gmt', dateCreatedGmt)
    ..putDate('date_modified', dateModified)
    ..putDate('date_modified_gmt', dateModifiedGmt)
    ..putIfPresent('email', email)
    ..putIfPresent('first_name', firstName)
    ..putIfPresent('last_name', lastName)
    ..putEnum('role', role)
    ..putIfPresent('username', username)
    ..putIfPresent('password', password)
    ..putIfPresent('billing', billing?.toJson())
    ..putIfPresent('shipping', shipping?.toJson())
    ..putIfPresent('is_paying_customer', isPayingCustomer)
    ..putIfPresent('avatar_url', avatarUrl)
    ..putIfPresent('meta_data', metaData?.map((m) => m.toJson()).toList());
  WooCustomer copyWith({
    int? id,
    DateTime? dateCreated,
    DateTime? dateCreatedGmt,
    DateTime? dateModified,
    DateTime? dateModifiedGmt,
    String? email,
    String? firstName,
    String? lastName,
    WooCustomerRole? role,
    String? username,
    String? password,
    WooBilling? billing,
    WooShipping? shipping,
    bool? isPayingCustomer,
    String? avatarUrl,
    List<WooMetaData>? metaData,
  }) =>
      WooCustomer(
        id: id ?? this.id,
        dateCreated: dateCreated ?? this.dateCreated,
        dateCreatedGmt: dateCreatedGmt ?? this.dateCreatedGmt,
        dateModified: dateModified ?? this.dateModified,
        dateModifiedGmt: dateModifiedGmt ?? this.dateModifiedGmt,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        role: role ?? this.role,
        username: username ?? this.username,
        password: password ?? this.password,
        billing: billing ?? this.billing,
        shipping: shipping ?? this.shipping,
        isPayingCustomer: isPayingCustomer ?? this.isPayingCustomer,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        metaData: metaData ?? this.metaData,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooCustomer &&
          other.id == id &&
          other.dateCreated == dateCreated &&
          other.dateCreatedGmt == dateCreatedGmt &&
          other.dateModified == dateModified &&
          other.dateModifiedGmt == dateModifiedGmt &&
          other.email == email &&
          other.firstName == firstName &&
          other.lastName == lastName &&
          other.role == role &&
          other.username == username &&
          other.password == password &&
          other.billing == billing &&
          other.shipping == shipping &&
          other.isPayingCustomer == isPayingCustomer &&
          other.avatarUrl == avatarUrl &&
          WooJson.listEquals(other.metaData, metaData);
  @override
  int get hashCode => Object.hashAll([
        id,
        dateCreated,
        dateCreatedGmt,
        dateModified,
        dateModifiedGmt,
        email,
        firstName,
        lastName,
        role,
        username,
        password,
        billing,
        shipping,
        isPayingCustomer,
        avatarUrl,
        ...(metaData ?? const []),
      ]);
  @override
  String toString() =>
      'WooCustomer(id: $id, email: $email, firstName: $firstName, '
      'lastName: $lastName, role: $role)';
}
