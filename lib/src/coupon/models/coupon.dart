import '../../base/models/metadata.dart';
import '../../helpers/fake_helper.dart';

class WooCoupon {
  /// Unique identifier for the coupon (read-only).
  final int? id;

  /// Coupon code (mandatory).
  final String? code;

  /// The amount of discount. Should always be numeric, even if it's a percentage.
  final String? amount;

  /// The date the coupon was created, in the site's timezone (read-only).
  final DateTime? dateCreated;

  /// The date the coupon was created, as GMT (read-only).
  final DateTime? dateCreatedGmt;

  /// The date the coupon was last modified, in the site's timezone (read-only).
  final DateTime? dateModified;

  /// The date the coupon was last modified, as GMT (read-only).
  final DateTime? dateModifiedGmt;

  /// Type of discount: percent, fixed_cart, or fixed_product. Default is fixed_cart.
  final String? discountType;

  /// Description of the coupon.
  final String? description;

  /// The date the coupon expires, in the site's timezone.
  final DateTime? dateExpires;

  /// The date the coupon expires, as GMT.
  final DateTime? dateExpiresGmt;

  /// Number of times the coupon has been used (read-only).
  final int? usageCount;

  /// If true, the coupon can only be used individually (default is false).
  final bool? individualUse;

  /// List of product IDs the coupon can be used on.
  final List<int>? productIds;

  /// List of product IDs the coupon cannot be used on.
  final List<int>? excludedProductIds;

  /// Maximum number of times the coupon can be used in total.
  final int? usageLimit;

  /// Maximum number of times the coupon can be used per customer.
  final int? usageLimitPerUser;

  /// Max number of items in the cart the coupon can be applied to.
  final int? limitUsageToXItems;

  /// If true, this coupon enables free shipping (default is false).
  final bool? freeShipping;

  /// List of category IDs the coupon applies to.
  final List<int>? productCategories;

  /// List of category IDs the coupon does not apply to.
  final List<int>? excludedProductCategories;

  /// If true, the coupon will not be applied to items with sale prices (default is false).
  final bool? excludeSaleItems;

  /// Minimum order amount required to apply the coupon.
  final String? minimumAmount;

  /// Maximum order amount allowed when using the coupon.
  final String? maximumAmount;

  /// List of email addresses that can use this coupon.
  final List<String>? emailRestrictions;

  /// List of user IDs or guest emails that have used the coupon (read-only).
  final List<String>? usedBy;

  /// Additional metadata related to the coupon.
  final List<WooMetaData>? metaData;

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
        id: json['id'],
        code: json['code'],
        amount: json['amount'],
        dateCreated: json['date_created'] != null
            ? DateTime.parse(json['date_created'])
            : null,
        dateCreatedGmt: json['date_created_gmt'] != null
            ? DateTime.parse(json['date_created_gmt'])
            : null,
        dateModified: json['date_modified'] != null
            ? DateTime.parse(json['date_modified'])
            : null,
        dateModifiedGmt: json['date_modified_gmt'] != null
            ? DateTime.parse(json['date_modified_gmt'])
            : null,
        discountType: json['discount_type'],
        description: json['description'],
        dateExpires: json['date_expires'] != null
            ? DateTime.parse(json['date_expires'])
            : null,
        dateExpiresGmt: json['date_expires_gmt'] != null
            ? DateTime.parse(json['date_expires_gmt'])
            : null,
        usageCount: json['usage_count'],
        individualUse: json['individual_use'],
        productIds: json['product_ids']?.cast<int>(),
        excludedProductIds: json['excluded_product_ids']?.cast<int>(),
        usageLimit: json['usage_limit'],
        usageLimitPerUser: json['usage_limit_per_user'],
        limitUsageToXItems: json['limit_usage_to_x_items'],
        freeShipping: json['free_shipping'],
        productCategories: json['product_categories']?.cast<int>(),
        excludedProductCategories:
            json['excluded_product_categories']?.cast<int>(),
        excludeSaleItems: json['exclude_sale_items'],
        minimumAmount: json['minimum_amount'],
        maximumAmount: json['maximum_amount'],
        emailRestrictions: json['email_restrictions']?.cast<String>(),
        usedBy: json['used_by']?.cast<String>(),
        metaData: (json['meta_data'] as List?)
            ?.map((i) => WooMetaData.fromJson(i))
            .toList(),
      );

  factory WooCoupon.fake() => WooCoupon(
        id: FakeHelper.integer(),
        code: FakeHelper.code(),
        amount: FakeHelper.decimal().toString(),
        dateCreated: FakeHelper.datetime(),
        dateCreatedGmt: FakeHelper.datetime(),
        dateModified: FakeHelper.datetime(),
        dateModifiedGmt: FakeHelper.datetime(),
        discountType: FakeHelper.word(),
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
        minimumAmount: FakeHelper.decimal().toString(),
        maximumAmount: FakeHelper.decimal().toString(),
        emailRestrictions: FakeHelper.list(() => FakeHelper.word()),
        usedBy: FakeHelper.list(() => FakeHelper.word()),
        metaData: FakeHelper.list(() => WooMetaData.fake()),
      );
}
