import '../../base/models/metadata.dart';
import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';
import 'line_item.dart';
import 'order_fee_line.dart';
import 'shipping_line.dart';
import 'tax.dart';
import 'tax_line.dart';

class WooOrderRefund {
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
  factory WooOrderRefund.fromJson(Map<String, dynamic> json) => WooOrderRefund(
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
      );
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
  final int? id;
  final DateTime? dateCreated;
  final DateTime? dateCreatedGmt;
  final String? amount;
  final String? reason;
  final int? refundedBy;
  final bool? refundedPayment;
  final List<WooMetaData>? metaData;
  final List<WooLineItem>? lineItems;
  final List<WooTaxLine>? taxLines;
  final List<WooShippingLine>? shippingLines;
  final List<WooOrderFeeLine>? feeLines;
  final bool? apiRefund;
  final bool? apiRestock;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putDate('date_created', dateCreated)
    ..putDate('date_created_gmt', dateCreatedGmt)
    ..putIfPresent('amount', amount)
    ..putIfPresent('reason', reason)
    ..putIfPresent('refunded_by', refundedBy)
    ..putIfPresent('refunded_payment', refundedPayment)
    ..putIfPresent('meta_data', metaData?.map((v) => v.toJson()).toList())
    ..putIfPresent(
      'line_items',
      lineItems
          ?.map(
            (item) => <String, dynamic>{
              'id': item.id,
              'refund_total': item.total,
              'refund_tax': [
                for (final tax in item.taxes ?? const <WooTax>[])
                  {'id': tax.id, 'refund_total': tax.taxTotal},
              ],
            },
          )
          .toList(),
    )
    ..putIfPresent('tax_lines', taxLines?.map((v) => v.toJson()).toList())
    ..putIfPresent(
        'shipping_lines', shippingLines?.map((v) => v.toJson()).toList())
    ..putIfPresent('fee_lines', feeLines?.map((v) => v.toJson()).toList())
    ..putIfPresent('api_refund', apiRefund)
    ..putIfPresent('api_restock', apiRestock);
  WooOrderRefund copyWith({
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
  }) =>
      WooOrderRefund(
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
      );
  @override
  String toString() {
    return 'WooOrderRefund(id: $id, amount: $amount, reason: $reason, refundedBy: $refundedBy)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooOrderRefund &&
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
          other.apiRestock == apiRestock;
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
      ]);
}
