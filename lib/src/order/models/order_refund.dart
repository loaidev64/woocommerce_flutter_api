import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

class WooOrderRefund {
  /// Unique identifier for the resource. Read-only.
  int? id;

  /// The date the order refund was created, in the site's timezone. Read-only.
  DateTime? dateCreated;

  /// The date the order refund was created, as GMT. Read-only.
  DateTime? dateCreatedGmt;

  /// Total refund amount. Optional.
  String? amount;

  /// Reason for refund.
  String? reason;

  /// User ID of user who created the refund.
  int? refundedBy;

  /// If the payment was refunded via the API. Read-only.
  bool? refundedPayment;

  /// Meta data.
  List<WooMetaData>? metaData;

  /// Line items data.
  List<WooLineItem>? lineItems;

  /// Tax lines data. Read-only.
  List<WooTaxLine>? taxLines;

  /// Shipping lines data.
  List<WooShippingLine>? shippingLines;

  /// Fee lines data.
  List<WooOrderFeeLine>? feeLines;

  /// When true, the payment gateway API is used to generate the refund. Write-only.
  bool? apiRefund;

  /// When true, the selected line items are restocked. Write-only.
  bool? apiRestock;

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

  @override
  String toString() => toJson().toString();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WooOrderRefund && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

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
