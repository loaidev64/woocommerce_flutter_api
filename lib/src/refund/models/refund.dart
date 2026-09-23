import '../../base/models/metadata.dart';
import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';
import '../../order/models/line_item.dart';
import '../../order/models/order_fee_line.dart';
import '../../order/models/order_refund.dart';
import '../../order/models/shipping_line.dart';
import '../../order/models/tax_line.dart';

class WooRefund extends WooOrderRefund {
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
  factory WooRefund.fromJson(Map<String, dynamic> json) => WooRefund(
        id: WooJson.readInt(json, 'id'),
        dateCreated: WooJson.readDate(json, 'date_created'),
        dateCreatedGmt: WooJson.readDate(json, 'date_created_gmt'),
        amount: WooJson.readString(json, 'amount'),
        reason: WooJson.readString(json, 'reason'),
        refundedBy: WooJson.readInt(json, 'refunded_by'),
        refundedPayment: WooJson.readBool(json, 'refunded_payment'),
        metaData: WooJson.readList(json, 'meta_data', WooMetaData.fromJson),
        lineItems: WooJson.readList(json, 'line_items', WooLineItem.fromJson),
        taxLines: WooJson.readList(json, 'tax_lines', WooTaxLine.fromJson),
        shippingLines:
            WooJson.readList(json, 'shipping_lines', WooShippingLine.fromJson),
        feeLines: WooJson.readList(json, 'fee_lines', WooOrderFeeLine.fromJson),
        apiRefund: WooJson.readBool(json, 'api_refund'),
        apiRestock: WooJson.readBool(json, 'api_restock'),
        parentId: WooJson.readInt(json, 'parent_id'),
      );
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
  final int? parentId;
  @override
  Map<String, dynamic> toJson() =>
      super.toJson()..putIfPresent('parent_id', parentId);
  @override
  WooRefund copyWith({
    int? id,
    DateTime? dateCreated,
    DateTime? dateCreatedGmt,
    String? amount,
    String? reason,
    int? refundedBy,
    bool? refundedPayment,
    List<WooMetaData>? metaData,
    List<WooLineItem>? lineItems,
    List<WooTaxLine>? taxLines,
    List<WooShippingLine>? shippingLines,
    List<WooOrderFeeLine>? feeLines,
    bool? apiRefund,
    bool? apiRestock,
    int? parentId,
  }) =>
      WooRefund(
        id: id ?? this.id,
        dateCreated: dateCreated ?? this.dateCreated,
        dateCreatedGmt: dateCreatedGmt ?? this.dateCreatedGmt,
        amount: amount ?? this.amount,
        reason: reason ?? this.reason,
        refundedBy: refundedBy ?? this.refundedBy,
        refundedPayment: refundedPayment ?? this.refundedPayment,
        metaData: metaData ?? this.metaData,
        lineItems: lineItems ?? this.lineItems,
        taxLines: taxLines ?? this.taxLines,
        shippingLines: shippingLines ?? this.shippingLines,
        feeLines: feeLines ?? this.feeLines,
        apiRefund: apiRefund ?? this.apiRefund,
        apiRestock: apiRestock ?? this.apiRestock,
        parentId: parentId ?? this.parentId,
      );
  @override
  String toString() {
    return 'WooRefund(id: $id, parentId: $parentId, amount: $amount, reason: $reason)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooRefund &&
          other.id == id &&
          other.dateCreated == dateCreated &&
          other.dateCreatedGmt == dateCreatedGmt &&
          other.amount == amount &&
          other.reason == reason &&
          other.refundedBy == refundedBy &&
          other.refundedPayment == refundedPayment &&
          WooJson.listEquals(other.metaData, metaData) &&
          WooJson.listEquals(other.lineItems, lineItems) &&
          WooJson.listEquals(other.taxLines, taxLines) &&
          WooJson.listEquals(other.shippingLines, shippingLines) &&
          WooJson.listEquals(other.feeLines, feeLines) &&
          other.apiRefund == apiRefund &&
          other.apiRestock == apiRestock &&
          other.parentId == parentId;
  @override
  int get hashCode => Object.hashAll([
        id,
        dateCreated,
        dateCreatedGmt,
        amount,
        reason,
        refundedBy,
        refundedPayment,
        ...(metaData ?? const []),
        ...(lineItems ?? const []),
        ...(taxLines ?? const []),
        ...(shippingLines ?? const []),
        ...(feeLines ?? const []),
        apiRefund,
        apiRestock,
        parentId,
      ]);
}
