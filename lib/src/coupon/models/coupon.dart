import '../../base/models/metadata.dart';
import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';
import '../enums/coupon_discount_type.dart';

class WooCoupon {
  WooCoupon({
    this.id,
    this.code,
    this.amount,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.discountType,
    this.description,
    this.dateExpires,
    this.dateExpiresGmt,
    this.usageCount,
    this.individualUse,
    this.productIds,
    this.excludedProductIds,
    this.usageLimit,
    this.usageLimitPerUser,
    this.limitUsageToXItems,
    this.freeShipping,
    this.productCategories,
    this.excludedProductCategories,
    this.excludeSaleItems,
    this.minimumAmount,
    this.maximumAmount,
    this.emailRestrictions,
    this.usedBy,
    this.metaData,
  });
  factory WooCoupon.fromJson(Map<String, dynamic> json) => WooCoupon(
        id: WooJson.readInt(json, 'id'),
        code: WooJson.readString(json, 'code'),
        amount: WooJson.readDouble(json, 'amount'),
        dateCreated: WooJson.readDate(json, 'date_created'),
        dateCreatedGmt: WooJson.readDate(json, 'date_created_gmt'),
        dateModified: WooJson.readDate(json, 'date_modified'),
        dateModifiedGmt: WooJson.readDate(json, 'date_modified_gmt'),
        discountType: WooJson.readEnum(
            json, 'discount_type', WooCouponDiscountType.values),
        description: WooJson.readString(json, 'description'),
        dateExpires: WooJson.readDate(json, 'date_expires'),
        dateExpiresGmt: WooJson.readDate(json, 'date_expires_gmt'),
        usageCount: WooJson.readInt(json, 'usage_count'),
        individualUse: WooJson.readBool(json, 'individual_use'),
        productIds: WooJson.readIntList(json, 'product_ids'),
        excludedProductIds: WooJson.readIntList(json, 'excluded_product_ids'),
        usageLimit: WooJson.readInt(json, 'usage_limit'),
        usageLimitPerUser: WooJson.readInt(json, 'usage_limit_per_user'),
        limitUsageToXItems: WooJson.readInt(json, 'limit_usage_to_x_items'),
        freeShipping: WooJson.readBool(json, 'free_shipping'),
        productCategories: WooJson.readIntList(json, 'product_categories'),
        excludedProductCategories:
            WooJson.readIntList(json, 'excluded_product_categories'),
        excludeSaleItems: WooJson.readBool(json, 'exclude_sale_items'),
        minimumAmount: WooJson.readDouble(json, 'minimum_amount'),
        maximumAmount: WooJson.readDouble(json, 'maximum_amount'),
        emailRestrictions: _readStringList(json, 'email_restrictions'),
        usedBy: _readStringList(json, 'used_by'),
        metaData: WooJson.readList(json, 'meta_data', WooMetaData.fromJson),
      );
  factory WooCoupon.fake({int? id}) => WooCoupon(
        id: id ?? FakeHelper.integer(),
        code: FakeHelper.code(),
        amount: FakeHelper.decimal(),
        dateCreated: FakeHelper.datetime(),
        dateCreatedGmt: FakeHelper.datetime(),
        dateModified: FakeHelper.datetime(),
        dateModifiedGmt: FakeHelper.datetime(),
        discountType: WooCouponDiscountType.fake(),
        description: FakeHelper.sentence(),
        dateExpires: FakeHelper.datetime(),
        dateExpiresGmt: FakeHelper.datetime(),
        usageCount: FakeHelper.integer(),
        individualUse: FakeHelper.boolean(),
        productIds: FakeHelper.listOfIntegers(),
        excludedProductIds: FakeHelper.listOfIntegers(),
        usageLimit: FakeHelper.integer(),
        usageLimitPerUser: FakeHelper.integer(),
        limitUsageToXItems: FakeHelper.integer(),
        freeShipping: FakeHelper.boolean(),
        productCategories: FakeHelper.listOfIntegers(),
        excludedProductCategories: FakeHelper.listOfIntegers(),
        excludeSaleItems: FakeHelper.boolean(),
        minimumAmount: FakeHelper.decimal(),
        maximumAmount: FakeHelper.decimal(),
        emailRestrictions: FakeHelper.list(() => FakeHelper.word()),
        usedBy: FakeHelper.list(() => FakeHelper.word()),
        metaData: FakeHelper.list(() => WooMetaData.fake()),
      );
  static List<String>? _readStringList(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is! List) return null;
    return [
      for (final element in value)
        if (element != null) element.toString()
    ];
  }

  final int? id;
  final String? code;
  final double? amount;
  final DateTime? dateCreated;
  final DateTime? dateCreatedGmt;
  final DateTime? dateModified;
  final DateTime? dateModifiedGmt;
  final WooCouponDiscountType? discountType;
  final String? description;
  final DateTime? dateExpires;
  final DateTime? dateExpiresGmt;
  final int? usageCount;
  final bool? individualUse;
  final List<int>? productIds;
  final List<int>? excludedProductIds;
  final int? usageLimit;
  final int? usageLimitPerUser;
  final int? limitUsageToXItems;
  final bool? freeShipping;
  final List<int>? productCategories;
  final List<int>? excludedProductCategories;
  final bool? excludeSaleItems;
  final double? minimumAmount;
  final double? maximumAmount;
  final List<String>? emailRestrictions;
  final List<String>? usedBy;
  final List<WooMetaData>? metaData;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putIfPresent('code', code)
    ..putIfPresent('amount', amount)
    ..putDate('date_created', dateCreated)
    ..putDate('date_created_gmt', dateCreatedGmt)
    ..putDate('date_modified', dateModified)
    ..putDate('date_modified_gmt', dateModifiedGmt)
    ..putEnum('discount_type', discountType)
    ..putIfPresent('description', description)
    ..putDate('date_expires', dateExpires)
    ..putDate('date_expires_gmt', dateExpiresGmt)
    ..putIfPresent('usage_count', usageCount)
    ..putIfPresent('individual_use', individualUse)
    ..putIfPresent('product_ids', productIds)
    ..putIfPresent('excluded_product_ids', excludedProductIds)
    ..putIfPresent('usage_limit', usageLimit)
    ..putIfPresent('usage_limit_per_user', usageLimitPerUser)
    ..putIfPresent('limit_usage_to_x_items', limitUsageToXItems)
    ..putIfPresent('free_shipping', freeShipping)
    ..putIfPresent('product_categories', productCategories)
    ..putIfPresent('excluded_product_categories', excludedProductCategories)
    ..putIfPresent('exclude_sale_items', excludeSaleItems)
    ..putIfPresent('minimum_amount', minimumAmount)
    ..putIfPresent('maximum_amount', maximumAmount)
    ..putIfPresent('email_restrictions', emailRestrictions)
    ..putIfPresent('used_by', usedBy)
    ..putIfPresent(
        'meta_data', metaData?.map((meta) => meta.toJson()).toList());
  WooCoupon copyWith({
    int? id,
    String? code,
    double? amount,
    DateTime? dateCreated,
    DateTime? dateCreatedGmt,
    DateTime? dateModified,
    DateTime? dateModifiedGmt,
    WooCouponDiscountType? discountType,
    String? description,
    DateTime? dateExpires,
    DateTime? dateExpiresGmt,
    int? usageCount,
    bool? individualUse,
    List<int>? productIds,
    List<int>? excludedProductIds,
    int? usageLimit,
    int? usageLimitPerUser,
    int? limitUsageToXItems,
    bool? freeShipping,
    List<int>? productCategories,
    List<int>? excludedProductCategories,
    bool? excludeSaleItems,
    double? minimumAmount,
    double? maximumAmount,
    List<String>? emailRestrictions,
    List<String>? usedBy,
    List<WooMetaData>? metaData,
  }) =>
      WooCoupon(
        id: id ?? this.id,
        code: code ?? this.code,
        amount: amount ?? this.amount,
        dateCreated: dateCreated ?? this.dateCreated,
        dateCreatedGmt: dateCreatedGmt ?? this.dateCreatedGmt,
        dateModified: dateModified ?? this.dateModified,
        dateModifiedGmt: dateModifiedGmt ?? this.dateModifiedGmt,
        discountType: discountType ?? this.discountType,
        description: description ?? this.description,
        dateExpires: dateExpires ?? this.dateExpires,
        dateExpiresGmt: dateExpiresGmt ?? this.dateExpiresGmt,
        usageCount: usageCount ?? this.usageCount,
        individualUse: individualUse ?? this.individualUse,
        productIds: productIds ?? this.productIds,
        excludedProductIds: excludedProductIds ?? this.excludedProductIds,
        usageLimit: usageLimit ?? this.usageLimit,
        usageLimitPerUser: usageLimitPerUser ?? this.usageLimitPerUser,
        limitUsageToXItems: limitUsageToXItems ?? this.limitUsageToXItems,
        freeShipping: freeShipping ?? this.freeShipping,
        productCategories: productCategories ?? this.productCategories,
        excludedProductCategories:
            excludedProductCategories ?? this.excludedProductCategories,
        excludeSaleItems: excludeSaleItems ?? this.excludeSaleItems,
        minimumAmount: minimumAmount ?? this.minimumAmount,
        maximumAmount: maximumAmount ?? this.maximumAmount,
        emailRestrictions: emailRestrictions ?? this.emailRestrictions,
        usedBy: usedBy ?? this.usedBy,
        metaData: metaData ?? this.metaData,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooCoupon &&
          other.id == id &&
          other.code == code &&
          other.amount == amount &&
          other.dateCreated == dateCreated &&
          other.dateCreatedGmt == dateCreatedGmt &&
          other.dateModified == dateModified &&
          other.dateModifiedGmt == dateModifiedGmt &&
          other.discountType == discountType &&
          other.description == description &&
          other.dateExpires == dateExpires &&
          other.dateExpiresGmt == dateExpiresGmt &&
          other.usageCount == usageCount &&
          other.individualUse == individualUse &&
          WooJson.listEquals(other.productIds, productIds) &&
          WooJson.listEquals(other.excludedProductIds, excludedProductIds) &&
          other.usageLimit == usageLimit &&
          other.usageLimitPerUser == usageLimitPerUser &&
          other.limitUsageToXItems == limitUsageToXItems &&
          other.freeShipping == freeShipping &&
          WooJson.listEquals(other.productCategories, productCategories) &&
          WooJson.listEquals(
              other.excludedProductCategories, excludedProductCategories) &&
          other.excludeSaleItems == excludeSaleItems &&
          other.minimumAmount == minimumAmount &&
          other.maximumAmount == maximumAmount &&
          WooJson.listEquals(other.emailRestrictions, emailRestrictions) &&
          WooJson.listEquals(other.usedBy, usedBy) &&
          WooJson.listEquals(other.metaData, metaData);
  @override
  int get hashCode => Object.hashAll([
        id,
        code,
        amount,
        dateCreated,
        dateCreatedGmt,
        dateModified,
        dateModifiedGmt,
        discountType,
        description,
        dateExpires,
        dateExpiresGmt,
        usageCount,
        individualUse,
        usageLimit,
        usageLimitPerUser,
        limitUsageToXItems,
        freeShipping,
        excludeSaleItems,
        minimumAmount,
        maximumAmount,
        ...(productIds ?? const []),
        ...(excludedProductIds ?? const []),
        ...(productCategories ?? const []),
        ...(excludedProductCategories ?? const []),
        ...(emailRestrictions ?? const []),
        ...(usedBy ?? const []),
        ...(metaData ?? const []),
      ]);
  @override
  String toString() =>
      'WooCoupon(id: $id, code: $code, discountType: $discountType, '
      'amount: $amount, usageCount: $usageCount)';
}
