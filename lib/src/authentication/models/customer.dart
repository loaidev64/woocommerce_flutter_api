import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

class WooCustomer {
  /// Unique identifier for the resource.
  int? id;

  /// The date the customer was created, in the site's timezone.
  DateTime? dateCreated;

  /// The date the customer was created, as GMT.
  DateTime? dateCreatedGmt;

  /// The date the customer was last modified, in the site's timezone.
  DateTime? dateModified;

  /// The date the customer was last modified, as GMT.
  DateTime? dateModifiedGmt;

  /// The email address for the customer.
  String? email;

  /// Customer first name.
  String? firstName;

  /// Customer last name.
  String? lastName;

  /// Customer role.
  String? role;

  /// Customer login name.
  String? username;

  /// Customer password.
  String? password;

  /// List of billing address data.
  WooBilling? billing;

  /// List of shipping address data.
  WooShipping? shipping;

  /// Is the customer a paying customer?
  bool? isPayingCustomer;

  /// Avatar URL.
  String? avatarUrl;

  /// Meta data.
  List<WooMetaData>? metaData;

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

  WooCustomer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = DateTime.tryParse(json['date_created']);
    dateCreatedGmt = DateTime.tryParse(json['date_created_gmt']);
    dateModified = DateTime.tryParse(json['date_modified']);
    dateModifiedGmt = DateTime.tryParse(json['date_modified_gmt']);
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    role = json['role'];
    username = json['username'];
    billing =
        json['billing'] != null ? WooBilling.fromJson(json['billing']) : null;
    shipping = json['shipping'] != null
        ? WooShipping.fromJson(json['shipping'])
        : null;
    isPayingCustomer = json['is_paying_customer'];
    avatarUrl = json['avatar_url'];
    metaData = (json['meta_data'] as List)
        .map((i) => WooMetaData.fromJson(i))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date_created'] = dateCreated?.toIso8601String();
    data['date_created_gmt'] = dateCreatedGmt?.toIso8601String();
    data['date_modified'] = dateModified?.toIso8601String();
    data['date_modified_gmt'] = dateModifiedGmt?.toIso8601String();
    data['email'] = email;
    if (firstName != null) {
      data['first_name'] = firstName;
    }
    if (lastName != null) {
      data['last_name'] = lastName;
    }
    data['role'] = role;
    data['username'] = username;
    data['password'] = password;
    if (billing != null) {
      data['billing'] = billing!.toJson();
    }
    if (shipping != null) {
      data['shipping'] = shipping!.toJson();
    }
    data['is_paying_customer'] = isPayingCustomer;
    data['avatar_url'] = avatarUrl;
    if (metaData != null) {
      data['meta_data'] = metaData!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  toString() => toJson().toString();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WooCustomer && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }

  factory WooCustomer.fake([int? id]) => WooCustomer(
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
        role: 'customer',
        shipping: WooShipping.fake(),
      );
}
