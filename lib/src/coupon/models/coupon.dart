import '../../base/models/metadata.dart';
import '../../helpers/fake_helper.dart';

/// WooCommerce Coupon Model
///
/// This class represents a discount coupon in WooCommerce with comprehensive
/// rules, restrictions, and usage tracking capabilities. Coupons can provide
/// percentage or fixed amount discounts with various conditions and limitations.
///
/// ## Key Features
///
/// - **Flexible Discount Types**: Percentage, fixed cart, or fixed product discounts
/// - **Usage Controls**: Limit total usage, per-user usage, and individual use restrictions
/// - **Product/Category Targeting**: Apply to specific products or categories
/// - **Amount Restrictions**: Set minimum and maximum order amounts
/// - **Email Restrictions**: Limit usage to specific customer emails
/// - **Expiration Support**: Set coupon expiration dates
/// - **Free Shipping**: Enable free shipping when coupon is applied
///
/// ## Usage Examples
///
/// ### Creating a Coupon
///
/// ```dart
/// final coupon = WooCoupon(
///   code: 'SAVE20',
///   discountType: 'percent',
///   amount: '20',
///   description: '20% off your order',
///   usageLimit: 100,
/// );
/// ```
///
/// ### Working with Coupon Data
///
/// ```dart
/// // Check if coupon is expired
/// if (coupon.dateExpires != null && 
///     coupon.dateExpires!.isBefore(DateTime.now())) {
///   print('Coupon has expired');
/// }
///
/// // Check usage limits
/// if (coupon.usageLimit != null && 
///     coupon.usageCount! >= coupon.usageLimit!) {
///   print('Coupon usage limit reached');
/// }
/// ```
///
/// ## JSON Serialization
///
/// The class supports full JSON serialization for API communication:
///
/// ```dart
/// // Convert to JSON for API requests
/// final json = coupon.toJson();
///
/// // Create from JSON response
/// final coupon = WooCoupon.fromJson(jsonData);
/// ```
class WooCoupon {
  /// Unique identifier for the coupon
  ///
  /// This ID is automatically assigned by WooCommerce when the coupon is created.
  final int? id;

  /// Coupon code
  ///
  /// The code that customers enter to apply the discount.
  /// Must be unique across all coupons.
  final String? code;

  /// Discount amount
  ///
  /// The amount of discount, either as a fixed value or percentage.
  /// Should always be numeric, even for percentage discounts.
  final String? amount;

  /// Date and time when the coupon was created (local time)
  ///
  /// This timestamp reflects when the coupon was first created in the store's local timezone.
  final DateTime? dateCreated;

  /// Date and time when the coupon was created (GMT)
  ///
  /// This timestamp reflects when the coupon was first created in GMT/UTC timezone.
  final DateTime? dateCreatedGmt;

  /// Date and time when the coupon was last modified (local time)
  ///
  /// This timestamp reflects when the coupon was last updated in the store's local timezone.
  final DateTime? dateModified;

  /// Date and time when the coupon was last modified (GMT)
  ///
  /// This timestamp reflects when the coupon was last updated in GMT/UTC timezone.
  final DateTime? dateModifiedGmt;

  /// Type of discount
  ///
  /// - `percent`: Percentage discount
  /// - `fixed_cart`: Fixed amount discount for entire cart
  /// - `fixed_product`: Fixed amount discount per product
  final String? discountType;

  /// Coupon description
  ///
  /// Description of the coupon for administrative purposes.
  final String? description;

  /// Date and time when the coupon expires (local time)
  ///
  /// The coupon will no longer be valid after this date.
  final DateTime? dateExpires;

  /// Date and time when the coupon expires (GMT)
  ///
  /// The coupon will no longer be valid after this date in GMT/UTC timezone.
  final DateTime? dateExpiresGmt;

  /// Number of times the coupon has been used
  ///
  /// Tracks how many times this coupon has been applied to orders.
  final int? usageCount;

  /// Whether the coupon can only be used individually
  ///
  /// If true, the coupon cannot be combined with other coupons.
  final bool? individualUse;

  /// List of product IDs the coupon can be used on
  ///
  /// If specified, the coupon can only be applied to these specific products.
  final List<int>? productIds;

  /// List of product IDs the coupon cannot be used on
  ///
  /// If specified, the coupon cannot be applied to these products.
  final List<int>? excludedProductIds;

  /// Maximum number of times the coupon can be used in total
  ///
  /// Once this limit is reached, the coupon becomes invalid.
  final int? usageLimit;

  /// Maximum number of times the coupon can be used per customer
  ///
  /// Limits how many times each customer can use this coupon.
  final int? usageLimitPerUser;

  /// Maximum number of items the coupon can be applied to
  ///
  /// Limits the number of items in the cart that can use this coupon.
  final int? limitUsageToXItems;

  /// Whether this coupon enables free shipping
  ///
  /// If true, applying this coupon will make shipping free.
  final bool? freeShipping;

  /// List of category IDs the coupon applies to
  ///
  /// If specified, the coupon can only be applied to products in these categories.
  final List<int>? productCategories;

  /// List of category IDs the coupon does not apply to
  ///
  /// If specified, the coupon cannot be applied to products in these categories.
  final List<int>? excludedProductCategories;

  /// Whether the coupon excludes items on sale
  ///
  /// If true, the coupon will not be applied to items that are currently on sale.
  final bool? excludeSaleItems;

  /// Minimum order amount required to apply the coupon
  ///
  /// The cart total must be at least this amount for the coupon to be valid.
  final String? minimumAmount;

  /// Maximum order amount allowed when using the coupon
  ///
  /// The cart total cannot exceed this amount for the coupon to be valid.
  final String? maximumAmount;

  /// List of email addresses that can use this coupon
  ///
  /// If specified, only customers with these email addresses can use the coupon.
  final List<String>? emailRestrictions;

  /// List of users who have used this coupon
  ///
  /// Tracks which users or guest emails have applied this coupon.
  final List<String>? usedBy;

  /// Additional metadata related to the coupon
  ///
  /// Custom fields and additional data associated with the coupon.
  final List<WooMetaData>? metaData;

  /// Creates a new WooCoupon instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional for maximum flexibility.
  ///
  /// ## Optional Parameters
  ///
  /// * [id] - Unique identifier for the coupon
  /// * [code] - Coupon code that customers enter
  /// * [amount] - Discount amount (percentage or fixed value)
  /// * [discountType] - Type of discount (percent, fixed_cart, fixed_product)
  /// * [description] - Description of the coupon
  /// * [dateExpires] - Expiration date for the coupon
  /// * [usageLimit] - Maximum number of times the coupon can be used
  /// * [usageLimitPerUser] - Maximum uses per customer
  /// * [minimumAmount] - Minimum order amount required
  /// * [maximumAmount] - Maximum order amount allowed
  /// * [freeShipping] - Whether the coupon enables free shipping
  /// * [individualUse] - Whether the coupon can only be used individually
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final coupon = WooCoupon(
  ///   code: 'SAVE20',
  ///   discountType: 'percent',
  ///   amount: '20',
  ///   description: '20% off your order',
  ///   usageLimit: 100,
  /// );
  /// ```
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

  /// Creates a WooCoupon instance from JSON data
  ///
  /// This factory constructor is used to deserialize coupon data received
  /// from the WooCommerce REST API.
  ///
  /// ## Parameters
  ///
  /// * [json] - A Map containing the coupon data in JSON format
  ///
  /// ## Returns
  ///
  /// A `WooCoupon` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final coupon = WooCoupon.fromJson(jsonData);
  /// ```
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

  /// Creates a fake WooCoupon instance for testing purposes
  ///
  /// This factory constructor generates a coupon with random but realistic
  /// data, making it useful for testing and development.
  ///
  /// ## Parameters
  ///
  /// * [id] - Optional specific ID to use for the fake coupon
  ///
  /// ## Returns
  ///
  /// A `WooCoupon` instance with randomly generated fake data.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final fakeCoupon = WooCoupon.fake();
  /// final fakeCouponWithId = WooCoupon.fake(123);
  /// ```
  factory WooCoupon.fake([int? id]) => WooCoupon(
        id: id ?? FakeHelper.integer(),
        code: FakeHelper.code(),
        amount: FakeHelper.decimal().toString(),
        dateCreated: FakeHelper.datetime(),
        dateCreatedGmt: FakeHelper.datetime(),
        dateModified: FakeHelper.datetime(),
        dateModifiedGmt: FakeHelper.datetime(),
        discountType:
            FakeHelper.randomItem(['percent', 'fixed_cart', 'fixed_product']),
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

  /// Converts the WooCoupon instance to JSON format
  ///
  /// This method serializes the coupon data into a Map that can be sent
  /// to the WooCommerce REST API.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the coupon data in JSON format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final jsonData = coupon.toJson();
  /// ```
  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'amount': amount,
        'date_created': dateCreated?.toIso8601String(),
        'date_created_gmt': dateCreatedGmt?.toIso8601String(),
        'date_modified': dateModified?.toIso8601String(),
        'date_modified_gmt': dateModifiedGmt?.toIso8601String(),
        'discount_type': discountType,
        'description': description,
        'date_expires': dateExpires?.toIso8601String(),
        'date_expires_gmt': dateExpiresGmt?.toIso8601String(),
        'usage_count': usageCount,
        'individual_use': individualUse,
        'product_ids': productIds,
        'excluded_product_ids': excludedProductIds,
        'usage_limit': usageLimit,
        'usage_limit_per_user': usageLimitPerUser,
        'limit_usage_to_x_items': limitUsageToXItems,
        'free_shipping': freeShipping,
        'product_categories': productCategories,
        'excluded_product_categories': excludedProductCategories,
        'exclude_sale_items': excludeSaleItems,
        'minimum_amount': minimumAmount,
        'maximum_amount': maximumAmount,
        'email_restrictions': emailRestrictions,
        'used_by': usedBy,
        'meta_data': metaData?.map((meta) => meta.toJson()).toList(),
      };

  /// Returns a string representation of the WooCoupon instance
  ///
  /// This method provides a human-readable representation of the coupon,
  /// displaying all main fields for debugging and logging purposes.
  ///
  /// ## Returns
  ///
  /// A `String` containing the coupon's main field values in a readable format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final coupon = WooCoupon(
  ///   id: 123,
  ///   code: 'SAVE20',
  ///   discountType: 'percent',
  ///   amount: '20',
  /// );
  /// print(coupon.toString());
  /// // Output: WooCoupon(id: 123, code: SAVE20, discountType: percent, amount: 20, usageCount: 0)
  /// ```
  @override
  String toString() {
    return 'WooCoupon(id: $id, code: $code, discountType: $discountType, amount: $amount, usageCount: $usageCount)';
  }
}
