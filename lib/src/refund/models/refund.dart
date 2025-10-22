import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

/// WooCommerce Refund Model
///
/// Represents a refund transaction in WooCommerce, extending the base WooOrderRefund
/// with additional parent order information. This model provides comprehensive refund
/// details including financial information, line items, and metadata.
///
/// ## Key Features
///
/// - **Parent Order Tracking**: Links refunds to their originating orders
/// - **Financial Details**: Tracks refund amounts, reasons, and payment status
/// - **Line Item Support**: Detailed breakdown of refunded items
/// - **Tax and Shipping**: Handles tax lines and shipping line refunds
/// - **Metadata Support**: Custom data storage for refund-specific information
///
/// ## Usage Examples
///
/// ### Creating a Refund
///
/// ```dart
/// final refund = WooRefund(
///   parentId: 123,
///   amount: '25.00',
///   reason: 'Defective product',
///   refundedBy: 1,
/// );
/// ```
///
/// ### Working with Refund Data
///
/// ```dart
/// // Check refund details
/// if (refund.amount != null) {
///   print('Refund amount: \$${refund.amount}');
/// }
///
/// // Access parent order information
/// if (refund.parentId != null) {
///   print('Parent order ID: ${refund.parentId}');
/// }
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
/// final refund = WooRefund.fromJson(jsonData);
/// ```
class WooRefund extends WooOrderRefund {

  /// Creates a new WooRefund instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional
  ///
  /// ## Optional Parameters
  ///
  /// * [id] - Unique identifier for the refund
  /// * [dateCreated] - Date and time when the refund was created
  /// * [dateCreatedGmt] - Date and time when the refund was created (GMT)
  /// * [amount] - Refund amount as a string
  /// * [reason] - Reason for the refund
  /// * [refundedBy] - ID of the user who processed the refund
  /// * [refundedPayment] - Whether the payment was refunded
  /// * [metaData] - Custom metadata for the refund
  /// * [lineItems] - List of refunded line items
  /// * [taxLines] - List of tax lines for the refund
  /// * [shippingLines] - List of shipping lines for the refund
  /// * [feeLines] - List of fee lines for the refund
  /// * [apiRefund] - Whether the refund was processed via API
  /// * [apiRestock] - Whether inventory was restocked
  /// * [parentId] - ID of the parent order this refund belongs to
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final refund = WooRefund(
  ///   parentId: 123,
  ///   amount: '25.00',
  ///   reason: 'Defective product',
  ///   refundedBy: 1,
  /// );
  /// ```
  WooRefund({
    super.id,
    super.dateCreated,
    super.dateCreatedGmt,
    super.amount,
    super.reason,
    super.refundedBy,
    super.refundedPayment,
    super.metaData,
    super.lineItems,
    super.taxLines,
    super.shippingLines,
    super.feeLines,
    super.apiRefund,
    super.apiRestock,
    this.parentId,
  });

  /// Creates a WooRefund instance from JSON data
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
  /// A `WooRefund` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final refund = WooRefund.fromJson(jsonData);
  /// ```
  WooRefund.fromJson(Map<String, dynamic> json) : parentId = json['parent_id'] {
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

  /// Creates a fake WooRefund instance for testing purposes
  ///
  /// This factory constructor generates a refund with random but realistic
  /// data, making it useful for testing and development.
  ///
  /// ## Returns
  ///
  /// A `WooRefund` instance with randomly generated fake data.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final fakeRefund = WooRefund.fake();
  /// ```
  factory WooRefund.fake() => WooRefund(
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
        parentId: FakeHelper.integer(),
      );
  /// The ID of the order the refund is associated with.
  ///
  /// This field links the refund to its parent order, allowing you to track
  /// which order the refund was issued for. This is essential for order
  /// management and financial reporting.
  int? parentId;

  /// Converts the WooRefund instance to JSON format
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
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['parent_id'] = parentId;
    return data;
  }

  /// Returns a string representation of the WooRefund instance
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
  /// final refund = WooRefund(id: 1, parentId: 123, amount: '25.00');
  /// print(refund.toString());
  /// // Output: {id: 1, parent_id: 123, amount: 25.00, ...}
  /// ```
  @override
  String toString() => toJson().toString();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WooOrderRefund && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
