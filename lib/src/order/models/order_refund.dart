import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

/// WooCommerce Order Refund Model
///
/// Represents a refund for a WooCommerce order, containing all refund details,
/// line items, and financial information. This model is used to manage order
/// refunds and track refund history in your WooCommerce store.
///
/// ## Refund Structure
///
/// A WooCommerce order refund consists of several key components:
///
/// - **Refund Information**: ID, creation date, amount, and reason
/// - **Financial Data**: Refund amount, taxes, and payment processing
/// - **Line Items**: Specific products and quantities being refunded
/// - **Tax Information**: Tax lines and calculations for the refund
/// - **Shipping**: Shipping costs and taxes being refunded
/// - **Fees**: Additional fees and their refund amounts
/// - **Metadata**: Custom refund metadata and notes
///
/// ## Refund Process
///
/// Refunds can be processed in different ways:
///
/// 1. **API Refund**: Uses payment gateway API to process refund
/// 2. **Manual Refund**: Manual refund without gateway processing
/// 3. **Partial Refund**: Refund specific line items or amounts
/// 4. **Full Refund**: Complete refund of the entire order
///
/// ## Key Features
///
/// - **Refund Information**: ID, date, amount, reason, and processing details
/// - **Financial Data**: Refund totals, taxes, and payment processing
/// - **Line Items**: Products and quantities being refunded
/// - **Tax Information**: Tax calculations and refund amounts
/// - **Shipping**: Shipping costs and taxes being refunded
/// - **Fees**: Additional fees and their refund amounts
/// - **Metadata**: Custom refund metadata and administrative notes
///
/// ## Usage Examples
///
/// ### Creating a New Refund
///
/// ```dart
/// final refund = WooOrderRefund(
///   amount: '25.00',
///   reason: 'Customer requested refund',
///   lineItems: [
///     WooLineItem(
///       id: 1,
///       quantity: 1,
///       total: 25.00,
///     ),
///   ],
///   apiRefund: true,
///   apiRestock: true,
/// );
/// ```
///
/// ### Working with Refund Data
///
/// ```dart
/// // Check refund amount
/// print('Refund amount: \$${refund.amount}');
///
/// // Check if refund was processed via API
/// if (refund.apiRefund == true) {
///   print('Refund processed via payment gateway');
/// }
///
/// // Access refund line items
/// for (final item in refund.lineItems ?? []) {
///   print('Refunded item: ${item.name}, Qty: ${item.quantity}');
/// }
///
/// // Check refund date
/// if (refund.dateCreated != null) {
///   print('Refund created on: ${refund.dateCreated}');
/// }
/// ```
///
/// ### Refund Processing
///
/// ```dart
/// // Create a full refund
/// final fullRefund = WooOrderRefund(
///   amount: order.total.toString(),
///   reason: 'Full order refund',
///   apiRefund: true,
///   apiRestock: true,
/// );
///
/// // Create a partial refund
/// final partialRefund = WooOrderRefund(
///   amount: '15.00',
///   reason: 'Partial refund for damaged item',
///   lineItems: [
///     WooLineItem(
///       id: 1,
///       quantity: 1,
///       total: 15.00,
///     ),
///   ],
///   apiRefund: false,
///   apiRestock: true,
/// );
/// ```
///
/// ## JSON Serialization
///
/// The class supports full JSON serialization for API communication:
///
/// ```dart
/// // Convert to JSON for API requests
/// final json = refund.toJson();
///
/// // Create from JSON response
/// final refund = WooOrderRefund.fromJson(jsonData);
/// ```
class WooOrderRefund {
  /// Unique identifier for the refund
  ///
  /// This ID is automatically assigned by WooCommerce when the refund is created.
  /// It's used to identify the refund in API calls and is read-only.
  int? id;

  /// Date and time when the refund was created (local time)
  ///
  /// This timestamp reflects when the refund was created in the store's local timezone.
  /// This field is read-only and set automatically by WooCommerce.
  DateTime? dateCreated;

  /// Date and time when the refund was created (GMT)
  ///
  /// This timestamp reflects when the refund was created in GMT/UTC timezone.
  /// This field is read-only and set automatically by WooCommerce.
  DateTime? dateCreatedGmt;

  /// Total refund amount
  ///
  /// The amount to be refunded to the customer. This can be a partial or full
  /// refund amount. Must be a valid decimal number as a string.
  String? amount;

  /// Reason for the refund
  ///
  /// A description explaining why the refund was issued. This helps track
  /// refund reasons for reporting and customer service purposes.
  String? reason;

  /// User ID of the user who created the refund
  ///
  /// The ID of the user (admin, shop manager, etc.) who processed the refund.
  /// This field is read-only and set automatically by WooCommerce.
  int? refundedBy;

  /// Whether the payment was refunded via the API
  ///
  /// If true, the refund was processed through the payment gateway API.
  /// If false, it was a manual refund. This field is read-only.
  bool? refundedPayment;

  /// Custom refund metadata
  ///
  /// Additional custom data associated with the refund, including
  /// administrative notes and custom fields.
  List<WooMetaData>? metaData;

  /// Line items being refunded
  ///
  /// The specific products and quantities that are being refunded.
  /// Each line item includes the product details and refund amounts.
  List<WooLineItem>? lineItems;

  /// Tax lines for the refund
  ///
  /// Tax calculations and amounts for the refunded items.
  /// This field is read-only and calculated automatically.
  List<WooTaxLine>? taxLines;

  /// Shipping lines for the refund
  ///
  /// Shipping costs and methods being refunded, including
  /// any shipping-related taxes.
  List<WooShippingLine>? shippingLines;

  /// Fee lines for the refund
  ///
  /// Additional fees and charges being refunded, including
  /// any fee-related taxes.
  List<WooOrderFeeLine>? feeLines;

  /// Whether to use payment gateway API for refund
  ///
  /// When true, the payment gateway API will be used to process the refund.
  /// When false, it will be a manual refund. This is a write-only field.
  bool? apiRefund;

  /// Whether to restock refunded items
  ///
  /// When true, the refunded items will be added back to inventory.
  /// When false, inventory levels will remain unchanged. This is a write-only field.
  bool? apiRestock;

  /// Creates a new WooOrderRefund instance
  ///
  /// ## Required Parameters
  ///
  /// * [amount] - Total refund amount as a string
  /// * [reason] - Reason for the refund
  ///
  /// ## Optional Parameters
  ///
  /// * [id] - Unique identifier for the refund (read-only)
  /// * [dateCreated] - Date when refund was created (read-only)
  /// * [dateCreatedGmt] - Date when refund was created in GMT (read-only)
  /// * [refundedBy] - User ID who created the refund (read-only)
  /// * [refundedPayment] - Whether payment was refunded via API (read-only)
  /// * [metaData] - Custom refund metadata
  /// * [lineItems] - Line items being refunded
  /// * [taxLines] - Tax lines for the refund (read-only)
  /// * [shippingLines] - Shipping lines for the refund
  /// * [feeLines] - Fee lines for the refund
  /// * [apiRefund] - Whether to use payment gateway API (write-only)
  /// * [apiRestock] - Whether to restock refunded items (write-only)
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Create a full refund
  /// final refund = WooOrderRefund(
  ///   amount: '99.99',
  ///   reason: 'Customer requested full refund',
  ///   apiRefund: true,
  ///   apiRestock: true,
  /// );
  ///
  /// // Create a partial refund
  /// final partialRefund = WooOrderRefund(
  ///   amount: '25.00',
  ///   reason: 'Partial refund for damaged item',
  ///   lineItems: [
  ///     WooLineItem(
  ///       id: 1,
  ///       quantity: 1,
  ///       total: 25.00,
  ///     ),
  ///   ],
  /// );
  /// ```
  WooOrderRefund({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.amount,
    this.reason,
    this.refundedBy,
    this.refundedPayment,
    this.metaData,
    this.lineItems,
    this.taxLines,
    this.shippingLines,
    this.feeLines,
    this.apiRefund,
    this.apiRestock,
  });

  /// Creates a WooOrderRefund instance from JSON data
  ///
  /// This factory constructor is used to deserialize refund data received
  /// from the WooCommerce REST API.
  ///
  /// ## Parameters
  ///
  /// * [json] - A Map containing the refund data in JSON format
  ///
  /// ## Returns
  ///
  /// A `WooOrderRefund` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final refund = WooOrderRefund.fromJson(jsonData);
  /// ```
  WooOrderRefund.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = DateTime.tryParse(json['date_created']);
    dateCreatedGmt = DateTime.tryParse(json['date_created_gmt']);
    amount = json['amount'];
    reason = json['reason'];
    refundedBy = json['refunded_by'];
    refundedPayment = json['refunded_payment'];
    metaData = (json['meta_data'] as List)
        .map((i) => WooMetaData.fromJson(i))
        .toList();
    lineItems = (json['line_items'] as List)
        .map((i) => WooLineItem.fromJson(i))
        .toList();
    taxLines =
        (json['tax_lines'] as List).map((i) => WooTaxLine.fromJson(i)).toList();
    shippingLines = (json['shipping_lines'] as List)
        .map((i) => WooShippingLine.fromJson(i))
        .toList();
    feeLines = (json['fee_lines'] as List)
        .map((i) => WooOrderFeeLine.fromJson(i))
        .toList();
    apiRefund = json['api_refund'];
    apiRestock = json['api_restock'];
  }

  /// Converts the WooOrderRefund instance to JSON format
  ///
  /// This method serializes the refund data into a Map that can be sent
  /// to the WooCommerce REST API.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the refund data in JSON format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final jsonData = refund.toJson();
  /// ```
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date_created'] = dateCreated?.toIso8601String();
    data['date_created_gmt'] = dateCreatedGmt?.toIso8601String();
    data['amount'] = amount;
    data['reason'] = reason;
    data['refunded_by'] = refundedBy;
    data['refunded_payment'] = refundedPayment;
    if (metaData != null) {
      data['meta_data'] = metaData!.map((v) => v.toJson()).toList();
    }
    if (lineItems != null) {
      data['line_items'] = lineItems!
          .map((v) => {
                'id': v.id,
                'refund_total': v.total,
                'refund_tax': v.taxes
                    ?.map((e) => {
                          'id': e.id,
                          'refund_total': e.taxTotal,
                        })
                    .toList(),
              })
          .toList();
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
    data['api_refund'] = apiRefund;
    data['api_restock'] = apiRestock;
    return data;
  }

  /// Returns a string representation of the WooOrderRefund instance
  ///
  /// This method provides a human-readable representation of the refund,
  /// displaying all main fields for debugging and logging purposes.
  ///
  /// ## Returns
  ///
  /// A `String` containing the refund's main field values in a readable format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final refund = WooOrderRefund(
  ///   id: 123,
  ///   amount: '25.00',
  ///   reason: 'Customer requested refund',
  /// );
  /// print(refund.toString());
  /// // Output: WooOrderRefund(id: 123, amount: 25.00, reason: Customer requested refund)
  /// ```
  @override
  String toString() {
    return 'WooOrderRefund(id: $id, amount: $amount, reason: $reason, refundedBy: $refundedBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WooOrderRefund && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  /// Creates a fake WooOrderRefund instance for testing purposes
  ///
  /// This factory constructor generates a refund with random but realistic
  /// data, making it useful for testing, development, and demonstration purposes.
  /// The generated refund will have valid data for all fields.
  ///
  /// ## Generated Data
  ///
  /// The fake refund includes:
  /// - Random refund ID and amount
  /// - Random reason and refunded by user
  /// - Random timestamps for creation dates
  /// - Random line items, tax lines, and shipping lines
  /// - Random metadata and fee lines
  /// - Random API refund and restock settings
  ///
  /// ## Returns
  ///
  /// A `WooOrderRefund` instance with randomly generated fake data.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// // Generate a fake refund for testing
  /// final fakeRefund = WooOrderRefund.fake();
  /// print('Fake refund amount: ${fakeRefund.amount}');
  /// print('Reason: ${fakeRefund.reason}');
  ///
  /// // Use in tests
  /// test('refund creation', () {
  ///   final refund = WooOrderRefund.fake();
  ///   expect(refund.id, isNotNull);
  ///   expect(refund.amount, isNotNull);
  ///   expect(refund.reason, isNotNull);
  /// });
  /// ```
  factory WooOrderRefund.fake() => WooOrderRefund(
        id: FakeHelper.integer(),
        dateCreated: FakeHelper.datetime(),
        dateCreatedGmt: FakeHelper.datetime(),
        amount: FakeHelper.decimal().toString(),
        reason: FakeHelper.sentence(),
        refundedBy: FakeHelper.integer(),
        refundedPayment: FakeHelper.boolean(),
        metaData: FakeHelper.list(() => WooMetaData.fake()),
        lineItems: FakeHelper.list(() => WooLineItem.fake()),
        taxLines: FakeHelper.list(() => WooTaxLine.fake()),
        shippingLines: FakeHelper.list(() => WooShippingLine.fake()),
        feeLines: FakeHelper.list(() => WooOrderFeeLine.fake()),
        apiRefund: FakeHelper.boolean(),
        apiRestock: FakeHelper.boolean(),
      );
}
