import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

class WooRefund extends WooOrderRefund {
  /// The ID of the order the refund is associated with.
  int? parentId;

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

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['parent_id'] = parentId;
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
}
