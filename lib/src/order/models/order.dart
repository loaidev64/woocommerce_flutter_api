import 'package:faker/faker.dart';
import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';
import 'package:woocommerce_flutter_api/src/order/models/line_item.dart';
import 'package:woocommerce_flutter_api/src/order/models/shipping_line.dart';
import 'package:woocommerce_flutter_api/src/order/models/tax_line.dart';

import '../../base/models/metadata.dart';
import '../enums/order_currency.dart';
import '../enums/order_status.dart';
import 'billing.dart';
import 'order_coupon_line.dart';
import 'order_fee_line.dart';
import 'refund.dart';
import 'shipping.dart';

/// WooCommerce Order Model
///
/// Represents a complete WooCommerce order with all its details, line items,
/// customer information, and financial data. This is the core model for managing
/// orders in your WooCommerce store, supporting all order types and statuses.
///
/// ## Order Structure
///
/// A WooCommerce order consists of several key components:
///
/// - **Order Information**: ID, number, key, status, and currency
/// - **Customer Data**: Customer ID, IP address, and user agent
/// - **Addresses**: Billing and shipping address information
/// - **Financial Data**: Totals, taxes, discounts, and payment information
/// - **Line Items**: Products, quantities, and prices in the order
/// - **Timestamps**: Creation, modification, payment, and completion dates
/// - **Metadata**: Custom order metadata and administrative notes
///
/// ## Order Lifecycle
///
/// Orders progress through different statuses during their lifecycle:
///
/// 1. **Pending**: Order is created but payment is pending
/// 2. **Processing**: Payment is confirmed, order is being prepared
/// 3. **On Hold**: Order is temporarily paused (e.g., awaiting payment)
/// 4. **Completed**: Order is fulfilled and delivered
/// 5. **Cancelled**: Order is cancelled before completion
/// 6. **Refunded**: Order is refunded to the customer
///
/// ## Key Features
///
/// - **Order Information**: ID, number, key, status, currency
/// - **Customer Data**: Customer ID, IP address, user agent
/// - **Addresses**: Billing and shipping address information
/// - **Financial**: Totals, taxes, discounts, payment information
/// - **Line Items**: Products, quantities, prices in the order
/// - **Timestamps**: Creation, modification, payment, completion dates
/// - **Metadata**: Custom order metadata and notes
///
/// ## Usage Examples
///
/// ### Creating a New Order
///
/// ```dart
/// final order = WooOrder(
///   id: 0, // Will be assigned by WooCommerce
///   status: WooOrderStatus.pending,
///   currency: WooOrderCurrency.usd,
///   customerId: 123,
///   billing: WooBilling(
///     firstName: 'John',
///     lastName: 'Doe',
///     email: 'john@example.com',
///   ),
/// );
/// ```
///
/// ### Working with Order Data
///
/// ```dart
/// // Check order status
/// if (order.status == WooOrderStatus.completed) {
///   print('Order is completed');
/// }
///
/// // Get order total
/// print('Order total: \$${order.total}');
///
/// // Access line items
/// for (final item in order.lineItems ?? []) {
///   print('Item: ${item.name}, Qty: ${item.quantity}');
/// }
///
/// // Access billing information
/// if (order.billing != null) {
///   print('Customer: ${order.billing!.firstName} ${order.billing!.lastName}');
///   print('Email: ${order.billing!.email}');
/// }
/// ```
///
/// ### Order Status Management
///
/// ```dart
/// // Update order status
/// order.status = WooOrderStatus.processing;
/// await wooCommerce.updateOrder(order);
///
/// // Check if order is paid
/// if (order.datePaid != null) {
///   print('Order was paid on: ${order.datePaid}');
/// }
///
/// // Check if order is completed
/// if (order.dateCompleted != null) {
///   print('Order was completed on: ${order.dateCompleted}');
/// }
/// ```
///
/// ## JSON Serialization
///
/// The class supports full JSON serialization for API communication:
///
/// ```dart
/// // Convert to JSON for API requests
/// final json = order.toJson();
///
/// // Create from JSON response
/// final order = WooOrder.fromJson(jsonData);
/// ```
class WooOrder {
  /// Unique identifier for the order
  ///
  /// This ID is automatically assigned by WooCommerce when the order is created.
  /// It's used to identify the order in API calls and is required for updates.
  int? id;

  /// Parent order ID
  ///
  /// For child orders (like refunds or partial orders), this references
  /// the parent order. For main orders, this is typically null.
  int? parentId;

  /// Order number
  ///
  /// A human-readable order number displayed to customers.
  /// This is different from the order ID and is often formatted as a sequence.
  String? number;

  /// Order key
  ///
  /// A unique key used for order identification in URLs and API calls.
  /// This key is used for guest order lookups and order tracking.
  String? orderKey;

  /// Source where the order was created
  ///
  /// Indicates how the order was created (e.g., 'rest-api', 'checkout', 'admin').
  /// Useful for tracking order origins and analytics.
  String? createdVia;

  /// WooCommerce version that last updated the order
  ///
  /// Tracks which version of WooCommerce last modified the order.
  /// Useful for compatibility and debugging purposes.
  String? version;

  /// Order status
  ///
  /// Current status of the order in the fulfillment process:
  /// - `WooOrderStatus.pending`: Payment is pending
  /// - `WooOrderStatus.processing`: Payment confirmed, being prepared
  /// - `WooOrderStatus.onHold`: Temporarily paused
  /// - `WooOrderStatus.completed`: Order fulfilled and delivered
  /// - `WooOrderStatus.cancelled`: Order cancelled
  /// - `WooOrderStatus.refunded`: Order refunded
  /// - `WooOrderStatus.failed`: Payment failed
  /// - `WooOrderStatus.trash`: Order deleted
  WooOrderStatus? status;

  /// Currency used for the order
  ///
  /// The currency in which the order was placed. Supports all major
  /// currencies including USD, EUR, GBP, and many others.
  /// Default is USD if not specified.
  WooOrderCurrency? currency;

  /// Date and time when the order was created (local time)
  ///
  /// This timestamp reflects when the order was first created in the store's local timezone.
  DateTime? dateCreated;

  /// Date and time when the order was created (GMT)
  ///
  /// This timestamp reflects when the order was first created in GMT/UTC timezone.
  DateTime? dateCreatedGmt;

  /// Date and time when the order was last modified (local time)
  ///
  /// This timestamp reflects when the order was last updated in the store's local timezone.
  DateTime? dateModified;

  /// Date and time when the order was last modified (GMT)
  ///
  /// This timestamp reflects when the order was last updated in GMT/UTC timezone.
  DateTime? dateModifiedGmt;

  /// Total discount amount for the order
  ///
  /// The total amount of discounts applied to the order, including
  /// coupon discounts and other promotional reductions.
  double? discountTotal;

  /// Total discount tax amount for the order
  ///
  /// The tax amount associated with the discounts applied to the order.
  /// This is relevant when taxes are calculated on discounted amounts.
  double? discountTax;

  /// Total shipping amount for the order
  ///
  /// The total cost of shipping for the order, including all shipping
  /// methods and any shipping-related fees.
  double? shippingTotal;

  /// Total shipping tax amount for the order
  ///
  /// The tax amount applied to shipping costs, if shipping is taxable
  /// in the customer's location.
  double? shippingTax;

  /// Sum of line item taxes only
  ///
  /// The total tax amount calculated on product line items,
  /// excluding shipping taxes and other fees.
  double? cartTax;

  /// Grand total of the order
  ///
  /// The final amount the customer pays, including all products,
  /// taxes, shipping, and fees, minus any discounts.
  double? total;

  /// Sum of all taxes applied to the order
  ///
  /// The total amount of all taxes, including product taxes,
  /// shipping taxes, and any other applicable taxes.
  double? totalTax;

  /// Whether prices included tax during checkout
  ///
  /// If true, the displayed prices already include tax.
  /// If false, tax is calculated and added at checkout.
  bool? pricesIncludeTax;

  /// User ID who owns the order. 0 for guests. Default is 0.
  int? customerId;

  /// Customer's IP address.
  String? customerIpAddress;

  /// User agent of the customer.
  String? customerUserAgent;

  /// Note left by customer during checkout.
  String? customerNote;

  /// Billing address.
  WooBilling? billing;

  /// Shipping address.
  WooShipping? shipping;

  /// Payment method ID.
  String? paymentMethod;

  /// Payment method title.
  String? paymentMethodTitle;

  /// Unique transaction ID.
  String? transactionId;

  /// The date the order was paid, in the site's timezone.
  DateTime? datePaid;

  /// The date the order was paid, as GMT.
  DateTime? datePaidGmt;

  /// The date the order was completed, in the site's timezone.
  DateTime? dateCompleted;

  /// The date the order was completed, as GMT.
  DateTime? dateCompletedGmt;

  /// MD5 hash of cart items to ensure orders are not modified.
  String? cartHash;

  /// Custom order metadata.
  List<WooMetaData>? metaData;

  /// Line items in the order.
  List<WooLineItem>? lineItems;

  /// Tax lines for the order.
  List<WooTaxLine>? taxLines;

  /// Shipping lines for the order.
  List<WooShippingLine>? shippingLines;

  /// Fee lines for the order.
  List<WooOrderFeeLine>? feeLines;

  /// Coupon lines for the order.
  List<WooOrderCouponLine>? couponLines;

  /// List of refunds for the order.
  List<WooRefunds>? refunds;

  /// Define if the order is paid. It will set the status to processing and reduce stock items. Default is false.
  bool? setPaid;

  /// Creates a new WooOrder instance
  ///
  /// ## Required Parameters
  ///
  /// * [id] - Unique identifier for the order (use 0 for new orders)
  ///
  /// ## Optional Parameters
  ///
  /// * [parentId] - Parent order ID for child orders
  /// * [number] - Human-readable order number
  /// * [orderKey] - Unique order key for identification
  /// * [status] - Order status (default: pending)
  /// * [currency] - Order currency (default: USD)
  /// * [customerId] - ID of the customer who placed the order
  /// * [billing] - Billing address information
  /// * [shipping] - Shipping address information
  /// * [lineItems] - Products and quantities in the order
  /// * [total] - Grand total of the order
  /// * [discountTotal] - Total discount amount
  /// * [shippingTotal] - Total shipping cost
  /// * [totalTax] - Total tax amount
  /// * [paymentMethod] - Payment method used
  /// * [setPaid] - Whether to mark the order as paid
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a new order
  /// final order = WooOrder(
  ///   id: 0, // New order
  ///   status: WooOrderStatus.pending,
  ///   currency: WooOrderCurrency.usd,
  ///   customerId: 123,
  ///   billing: WooBilling(
  ///     firstName: 'John',
  ///     lastName: 'Doe',
  ///     email: 'john@example.com',
  ///   ),
  ///   lineItems: [
  ///     WooLineItem(
  ///       productId: 456,
  ///       quantity: 2,
  ///       total: 59.98,
  ///     ),
  ///   ],
  ///   total: 59.98,
  /// );
  ///
  /// // Create an order with payment
  /// final paidOrder = WooOrder(
  ///   id: 0,
  ///   status: WooOrderStatus.processing,
  ///   setPaid: true,
  ///   paymentMethod: 'stripe',
  ///   transactionId: 'txn_123456',
  /// );
  /// ```
  WooOrder({
    required int this.id,
    this.parentId,
    this.number,
    this.orderKey,
    this.createdVia,
    this.version,
    this.status,
    this.currency,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.discountTotal,
    this.discountTax,
    this.shippingTotal,
    this.shippingTax,
    this.cartTax,
    this.total,
    this.totalTax,
    this.pricesIncludeTax,
    this.customerId,
    this.customerIpAddress,
    this.customerUserAgent,
    this.customerNote,
    this.billing,
    this.shipping,
    this.paymentMethod,
    this.paymentMethodTitle,
    this.transactionId,
    this.datePaid,
    this.datePaidGmt,
    this.dateCompleted,
    this.dateCompletedGmt,
    this.cartHash,
    this.metaData,
    this.lineItems,
    this.taxLines,
    this.shippingLines,
    this.feeLines,
    this.couponLines,
    this.refunds,
    this.setPaid = false,
  });

  /// Creates a WooOrder instance from JSON data
  ///
  /// This factory constructor is used to deserialize order data received
  /// from the WooCommerce REST API.
  ///
  /// ## Parameters
  ///
  /// * [json] - A Map containing the order data in JSON format
  ///
  /// ## Returns
  ///
  /// A `WooOrder` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final order = WooOrder.fromJson(jsonData);
  /// ```
  WooOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    number = json['number'];
    orderKey = json['order_key'];
    createdVia = json['created_via'];
    version = json['version'];
    status = json['status'];
    currency = json['currency'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    discountTotal = json['discount_total'];
    discountTax = json['discount_tax'];
    shippingTotal = json['shipping_total'];
    shippingTax = json['shipping_tax'];
    cartTax = json['cart_tax'];
    total = json['total'];
    totalTax = json['total_tax'];
    pricesIncludeTax = json['prices_include_tax'];
    customerId = json['customer_id'];
    customerIpAddress = json['customer_ip_address'];
    customerUserAgent = json['customer_user_agent'];
    customerNote = json['customer_note'];
    billing =
        json['billing'] != null ? WooBilling.fromJson(json['billing']) : null;
    shipping = json['shipping'] != null
        ? WooShipping.fromJson(json['shipping'])
        : null;
    paymentMethod = json['payment_method'];
    paymentMethodTitle = json['payment_method_title'];
    transactionId = json['transaction_id'];
    datePaid = json['date_paid'];
    datePaidGmt = json['date_paid_gmt'];
    dateCompleted = json['date_completed'];
    dateCompletedGmt = json['date_completed_gmt'];
    cartHash = json['cart_hash'];
    metaData = (json['meta_data'] as List)
        .map((i) => WooMetaData.fromJson(i))
        .toList();
    if (json['line_items'] != null) {
      lineItems = <WooLineItem>[];
      json['line_items'].forEach((v) {
        lineItems!.add(WooLineItem.fromJson(v));
      });
    }
    if (json['tax_lines'] != null) {
      taxLines = <WooTaxLine>[];
      json['tax_lines'].forEach((v) {
        taxLines!.add(WooTaxLine.fromJson(v));
      });
    }
    if (json['shipping_lines'] != null) {
      shippingLines = <WooShippingLine>[];
      json['shipping_lines'].forEach((v) {
        shippingLines!.add(WooShippingLine.fromJson(v));
      });
    }
    if (json['fee_lines'] != null) {
      feeLines = <WooOrderFeeLine>[];
      json['fee_lines'].forEach((v) {
        feeLines!.add(WooOrderFeeLine.fromJson(v));
      });
    }
    if (json['coupon_lines'] != null) {
      couponLines = [];
      json['coupon_lines'].forEach((v) {
        couponLines!.add(WooOrderCouponLine.fromJson(v));
      });
    }

    if (json['refunds'] != null) {
      refunds = [];
      json['refunds'].forEach((v) {
        refunds!.add(WooRefunds.fromJson(v));
      });
    }
  }

  /// Converts the WooOrder instance to JSON format
  ///
  /// This method serializes the order data into a Map that can be sent
  /// to the WooCommerce REST API.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the order data in JSON format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final jsonData = order.toJson();
  /// ```
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['parent_id'] = parentId;
    data['number'] = number;
    data['order_key'] = orderKey;
    data['created_via'] = createdVia;
    data['version'] = version;
    data['status'] = status?.name;
    data['currency'] = currency?.name;
    data['date_created'] = dateCreated?.toIso8601String();
    data['date_created_gmt'] = dateCreatedGmt?.toIso8601String();
    data['date_modified'] = dateModified?.toIso8601String();
    data['date_modified_gmt'] = dateModifiedGmt?.toIso8601String();
    data['discount_total'] = discountTotal;
    data['discount_tax'] = discountTax;
    data['shipping_total'] = shippingTotal;
    data['shipping_tax'] = shippingTax;
    data['cart_tax'] = cartTax;
    data['total'] = total;
    data['total_tax'] = totalTax;
    data['prices_include_tax'] = pricesIncludeTax;
    data['customer_id'] = customerId;
    data['customer_ip_address'] = customerIpAddress;
    data['customer_user_agent'] = customerUserAgent;
    data['customer_note'] = customerNote;
    if (billing != null) {
      data['billing'] = billing!.toJson();
    }
    if (shipping != null) {
      data['shipping'] = shipping!.toJson();
    }
    data['payment_method'] = paymentMethod;
    data['payment_method_title'] = paymentMethodTitle;
    data['transaction_id'] = transactionId;
    data['date_paid'] = datePaid?.toIso8601String();
    data['date_paid_gmt'] = datePaidGmt?.toIso8601String();
    data['date_completed'] = dateCompleted?.toIso8601String();
    data['date_completed_gmt'] = dateCompletedGmt?.toIso8601String();
    data['cart_hash'] = cartHash;
    if (metaData != null) {
      data['meta_data'] = metaData!.map((v) => v.toJson()).toList();
    }
    if (lineItems != null) {
      data['line_items'] = lineItems!.map((v) => v.toJson()).toList();
    }
    if (taxLines != null) {
      data['tax_lines'] = taxLines!.map((v) => v.toJson()).toList();
    }
    if (shippingLines != null) {
      data['shipping_lines'] = shippingLines!.map((v) => v.toJson()).toList();
    }
    if (feeLines != null) {
      data['fee_lines'] = feeLines!.map((v) => v.toJson()).toList();
    }
    if (couponLines != null) {
      data['coupon_lines'] = couponLines!.map((v) => v.toJson()).toList();
    }

    if (refunds != null) {
      data['refunds'] = refunds!.map((v) => v.toJson()).toList();
    }

    data['set_paid'] = setPaid;

    return data;
  }

  /// Returns a string representation of the WooOrder instance
  ///
  /// This method provides a human-readable representation of the order,
  /// displaying all main fields for debugging and logging purposes.
  ///
  /// ## Returns
  ///
  /// A `String` containing the order's main field values in a readable format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final order = WooOrder(
  ///   id: 123,
  ///   number: '12345',
  ///   status: WooOrderStatus.completed,
  ///   total: 99.99,
  ///   customerId: 456,
  /// );
  /// print(order.toString());
  /// // Output: WooOrder(id: 123, number: 12345, status: completed, total: 99.99, customerId: 456)
  /// ```
  @override
  String toString() {
    return 'WooOrder(id: $id, number: $number, status: $status, total: $total, customerId: $customerId)';
  }

  /// Creates a fake WooOrder instance for testing purposes
  ///
  /// This factory constructor generates an order with random but realistic
  /// data, making it useful for testing, development, and demonstration purposes.
  /// The generated order will have valid data for all fields.
  ///
  /// ## Generated Data
  ///
  /// The fake order includes:
  /// - Random order ID and number
  /// - Random status from available statuses
  /// - Random currency from available currencies
  /// - Random customer information
  /// - Random billing and shipping addresses
  /// - Random line items with products
  /// - Random financial totals
  /// - Random timestamps
  ///
  /// ## Returns
  ///
  /// A `WooOrder` instance with randomly generated fake data.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Generate a fake order for testing
  /// final fakeOrder = WooOrder.fake();
  /// print('Fake order: ${fakeOrder.number}');
  /// print('Status: ${fakeOrder.status}');
  /// print('Total: ${fakeOrder.total}');
  ///
  /// // Use in tests
  /// test('order creation', () {
  ///   final order = WooOrder.fake();
  ///   expect(order.id, isNotNull);
  ///   expect(order.status, isNotNull);
  ///   expect(order.total, isNotNull);
  /// });
  /// ```
  factory WooOrder.fake() => WooOrder(
        id: FakeHelper.integer(),
        parentId: FakeHelper.integer(),
        number: FakeHelper.integer().toString(),
        orderKey: FakeHelper.word(),
        createdVia: 'rest-api',
        version: FakeHelper.integer().toString(),
        status: WooOrderStatus.fake(),
        currency: WooOrderCurrency.fake(),
        dateCreated: FakeHelper.datetime(),
        dateCreatedGmt: FakeHelper.datetime(),
        dateModified: FakeHelper.datetime(),
        dateModifiedGmt: FakeHelper.datetime(),
        discountTotal: FakeHelper.decimal(),
        discountTax: FakeHelper.decimal(),
        shippingTotal: FakeHelper.decimal(),
        shippingTax: FakeHelper.decimal(),
        cartTax: FakeHelper.decimal(),
        total: FakeHelper.decimal(),
        totalTax: FakeHelper.decimal(),
        pricesIncludeTax: FakeHelper.boolean(),
        customerId: FakeHelper.integer(),
        customerIpAddress: Faker().internet.ipv4Address(),
        customerUserAgent: Faker().internet.userAgent(),
        customerNote: FakeHelper.sentence(),
        billing: WooBilling.fake(),
        shipping: WooShipping.fake(),
        paymentMethod: FakeHelper.word(),
        paymentMethodTitle: FakeHelper.word(),
        transactionId: FakeHelper.integer().toString(),
        datePaid: FakeHelper.datetime(),
        datePaidGmt: FakeHelper.datetime(),
        dateCompleted: FakeHelper.datetime(),
        dateCompletedGmt: FakeHelper.datetime(),
        cartHash: Faker().guid.guid(),
        metaData: FakeHelper.list(() => WooMetaData.fake()),
        lineItems: FakeHelper.list(() => WooLineItem.fake()),
        taxLines: FakeHelper.list(() => WooTaxLine.fake()),
        shippingLines: FakeHelper.list(() => WooShippingLine.fake()),
        feeLines: FakeHelper.list(() => WooOrderFeeLine.fake()),
        couponLines: FakeHelper.list(() => WooOrderCouponLine.fake()),
        refunds: FakeHelper.list(() => WooRefunds.fake()),
        setPaid: FakeHelper.boolean(),
      );
}
