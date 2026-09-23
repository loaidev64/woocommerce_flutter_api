import 'package:faker/faker.dart';
import '../../base/models/metadata.dart';
import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';
import '../enums/currency.dart';
import '../enums/order_status.dart';
import 'billing.dart';
import 'line_item.dart';
import 'order_coupon_line.dart';
import 'order_fee_line.dart';
import 'refund.dart';
import 'shipping.dart';
import 'shipping_line.dart';
import 'tax_line.dart';

class WooOrder {
  WooOrder({
    this.id,
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
  factory WooOrder.fromJson(Map<String, dynamic> json) => WooOrder(
        id: WooJson.readInt(json, 'id'),
        parentId: WooJson.readInt(json, 'parent_id'),
        number: WooJson.readString(json, 'number'),
        orderKey: WooJson.readString(json, 'order_key'),
        createdVia: WooJson.readString(json, 'created_via'),
        version: WooJson.readString(json, 'version'),
        status: WooJson.readEnum(json, 'status', WooOrderStatus.values),
        currency: WooJson.readString(json, 'currency'),
        dateCreated: WooJson.readDate(json, 'date_created'),
        dateCreatedGmt: WooJson.readDate(json, 'date_created_gmt'),
        dateModified: WooJson.readDate(json, 'date_modified'),
        dateModifiedGmt: WooJson.readDate(json, 'date_modified_gmt'),
        discountTotal: WooJson.readDouble(json, 'discount_total'),
        discountTax: WooJson.readDouble(json, 'discount_tax'),
        shippingTotal: WooJson.readDouble(json, 'shipping_total'),
        shippingTax: WooJson.readDouble(json, 'shipping_tax'),
        cartTax: WooJson.readDouble(json, 'cart_tax'),
        total: WooJson.readDouble(json, 'total'),
        totalTax: WooJson.readDouble(json, 'total_tax'),
        pricesIncludeTax: WooJson.readBool(json, 'prices_include_tax'),
        customerId: WooJson.readInt(json, 'customer_id'),
        customerIpAddress: WooJson.readString(json, 'customer_ip_address'),
        customerUserAgent: WooJson.readString(json, 'customer_user_agent'),
        customerNote: WooJson.readString(json, 'customer_note'),
        billing: switch (WooJson.readMap(json, 'billing')) {
          null => null,
          final value => WooBilling.fromJson(value),
        },
        shipping: switch (WooJson.readMap(json, 'shipping')) {
          null => null,
          final value => WooShipping.fromJson(value),
        },
        paymentMethod: WooJson.readString(json, 'payment_method'),
        paymentMethodTitle: WooJson.readString(json, 'payment_method_title'),
        transactionId: WooJson.readString(json, 'transaction_id'),
        datePaid: WooJson.readDate(json, 'date_paid'),
        datePaidGmt: WooJson.readDate(json, 'date_paid_gmt'),
        dateCompleted: WooJson.readDate(json, 'date_completed'),
        dateCompletedGmt: WooJson.readDate(json, 'date_completed_gmt'),
        cartHash: WooJson.readString(json, 'cart_hash'),
        metaData: WooJson.readList(json, 'meta_data', WooMetaData.fromJson),
        lineItems: WooJson.readList(json, 'line_items', WooLineItem.fromJson),
        taxLines: WooJson.readList(json, 'tax_lines', WooTaxLine.fromJson),
        shippingLines:
            WooJson.readList(json, 'shipping_lines', WooShippingLine.fromJson),
        feeLines: WooJson.readList(json, 'fee_lines', WooOrderFeeLine.fromJson),
        couponLines:
            WooJson.readList(json, 'coupon_lines', WooOrderCouponLine.fromJson),
        refunds: WooJson.readList(json, 'refunds', WooRefunds.fromJson),
        setPaid: WooJson.readBool(json, 'set_paid') ?? false,
      );
  factory WooOrder.fake() => WooOrder(
        id: FakeHelper.integer(),
        parentId: FakeHelper.integer(),
        number: FakeHelper.integer().toString(),
        orderKey: FakeHelper.word(),
        createdVia: 'rest-api',
        version: FakeHelper.integer().toString(),
        status: WooOrderStatus.fake(),
        currency: WooCurrency.fake(),
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
  final int? id;
  final int? parentId;
  final String? number;
  final String? orderKey;
  final String? createdVia;
  final String? version;
  final WooOrderStatus? status;
  final String? currency;
  final DateTime? dateCreated;
  final DateTime? dateCreatedGmt;
  final DateTime? dateModified;
  final DateTime? dateModifiedGmt;
  final double? discountTotal;
  final double? discountTax;
  final double? shippingTotal;
  final double? shippingTax;
  final double? cartTax;
  final double? total;
  final double? totalTax;
  final bool? pricesIncludeTax;
  final int? customerId;
  final String? customerIpAddress;
  final String? customerUserAgent;
  final String? customerNote;
  final WooBilling? billing;
  final WooShipping? shipping;
  final String? paymentMethod;
  final String? paymentMethodTitle;
  final String? transactionId;
  final DateTime? datePaid;
  final DateTime? datePaidGmt;
  final DateTime? dateCompleted;
  final DateTime? dateCompletedGmt;
  final String? cartHash;
  final List<WooMetaData>? metaData;
  final List<WooLineItem>? lineItems;
  final List<WooTaxLine>? taxLines;
  final List<WooShippingLine>? shippingLines;
  final List<WooOrderFeeLine>? feeLines;
  final List<WooOrderCouponLine>? couponLines;
  final List<WooRefunds>? refunds;
  final bool setPaid;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putIfPresent('parent_id', parentId)
    ..putIfPresent('number', number)
    ..putIfPresent('order_key', orderKey)
    ..putIfPresent('created_via', createdVia)
    ..putIfPresent('version', version)
    ..putEnum('status', status)
    ..putIfPresent('currency', currency)
    ..putDate('date_created', dateCreated)
    ..putDate('date_created_gmt', dateCreatedGmt)
    ..putDate('date_modified', dateModified)
    ..putDate('date_modified_gmt', dateModifiedGmt)
    ..putIfPresent('discount_total', discountTotal)
    ..putIfPresent('discount_tax', discountTax)
    ..putIfPresent('shipping_total', shippingTotal)
    ..putIfPresent('shipping_tax', shippingTax)
    ..putIfPresent('cart_tax', cartTax)
    ..putIfPresent('total', total)
    ..putIfPresent('total_tax', totalTax)
    ..putIfPresent('prices_include_tax', pricesIncludeTax)
    ..putIfPresent('customer_id', customerId)
    ..putIfPresent('customer_ip_address', customerIpAddress)
    ..putIfPresent('customer_user_agent', customerUserAgent)
    ..putIfPresent('customer_note', customerNote)
    ..putIfPresent('billing', billing?.toJson())
    ..putIfPresent('shipping', shipping?.toJson())
    ..putIfPresent('payment_method', paymentMethod)
    ..putIfPresent('payment_method_title', paymentMethodTitle)
    ..putIfPresent('transaction_id', transactionId)
    ..putDate('date_paid', datePaid)
    ..putDate('date_paid_gmt', datePaidGmt)
    ..putDate('date_completed', dateCompleted)
    ..putDate('date_completed_gmt', dateCompletedGmt)
    ..putIfPresent('cart_hash', cartHash)
    ..putIfPresent('meta_data', metaData?.map((v) => v.toJson()).toList())
    ..putIfPresent('line_items', lineItems?.map((v) => v.toJson()).toList())
    ..putIfPresent('tax_lines', taxLines?.map((v) => v.toJson()).toList())
    ..putIfPresent(
        'shipping_lines', shippingLines?.map((v) => v.toJson()).toList())
    ..putIfPresent('fee_lines', feeLines?.map((v) => v.toJson()).toList())
    ..putIfPresent('coupon_lines', couponLines?.map((v) => v.toJson()).toList())
    ..putIfPresent('refunds', refunds?.map((v) => v.toJson()).toList())
    ..putIfPresent('set_paid', setPaid);
  WooOrder copyWith({
    int? id,
    int? parentId,
    String? number,
    String? orderKey,
    String? createdVia,
    String? version,
    WooOrderStatus? status,
    String? currency,
    DateTime? dateCreated,
    DateTime? dateCreatedGmt,
    DateTime? dateModified,
    DateTime? dateModifiedGmt,
    double? discountTotal,
    double? discountTax,
    double? shippingTotal,
    double? shippingTax,
    double? cartTax,
    double? total,
    double? totalTax,
    bool? pricesIncludeTax,
    int? customerId,
    String? customerIpAddress,
    String? customerUserAgent,
    String? customerNote,
    WooBilling? billing,
    WooShipping? shipping,
    String? paymentMethod,
    String? paymentMethodTitle,
    String? transactionId,
    DateTime? datePaid,
    DateTime? datePaidGmt,
    DateTime? dateCompleted,
    DateTime? dateCompletedGmt,
    String? cartHash,
    List<WooMetaData>? metaData,
    List<WooLineItem>? lineItems,
    List<WooTaxLine>? taxLines,
    List<WooShippingLine>? shippingLines,
    List<WooOrderFeeLine>? feeLines,
    List<WooOrderCouponLine>? couponLines,
    List<WooRefunds>? refunds,
    bool? setPaid,
  }) =>
      WooOrder(
        id: id ?? this.id,
        parentId: parentId ?? this.parentId,
        number: number ?? this.number,
        orderKey: orderKey ?? this.orderKey,
        createdVia: createdVia ?? this.createdVia,
        version: version ?? this.version,
        status: status ?? this.status,
        currency: currency ?? this.currency,
        dateCreated: dateCreated ?? this.dateCreated,
        dateCreatedGmt: dateCreatedGmt ?? this.dateCreatedGmt,
        dateModified: dateModified ?? this.dateModified,
        dateModifiedGmt: dateModifiedGmt ?? this.dateModifiedGmt,
        discountTotal: discountTotal ?? this.discountTotal,
        discountTax: discountTax ?? this.discountTax,
        shippingTotal: shippingTotal ?? this.shippingTotal,
        shippingTax: shippingTax ?? this.shippingTax,
        cartTax: cartTax ?? this.cartTax,
        total: total ?? this.total,
        totalTax: totalTax ?? this.totalTax,
        pricesIncludeTax: pricesIncludeTax ?? this.pricesIncludeTax,
        customerId: customerId ?? this.customerId,
        customerIpAddress: customerIpAddress ?? this.customerIpAddress,
        customerUserAgent: customerUserAgent ?? this.customerUserAgent,
        customerNote: customerNote ?? this.customerNote,
        billing: billing ?? this.billing,
        shipping: shipping ?? this.shipping,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        paymentMethodTitle: paymentMethodTitle ?? this.paymentMethodTitle,
        transactionId: transactionId ?? this.transactionId,
        datePaid: datePaid ?? this.datePaid,
        datePaidGmt: datePaidGmt ?? this.datePaidGmt,
        dateCompleted: dateCompleted ?? this.dateCompleted,
        dateCompletedGmt: dateCompletedGmt ?? this.dateCompletedGmt,
        cartHash: cartHash ?? this.cartHash,
        metaData: metaData ?? this.metaData,
        lineItems: lineItems ?? this.lineItems,
        taxLines: taxLines ?? this.taxLines,
        shippingLines: shippingLines ?? this.shippingLines,
        feeLines: feeLines ?? this.feeLines,
        couponLines: couponLines ?? this.couponLines,
        refunds: refunds ?? this.refunds,
        setPaid: setPaid ?? this.setPaid,
      );
  @override
  String toString() {
    return 'WooOrder(id: $id, number: $number, status: $status, total: $total, customerId: $customerId)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooOrder &&
          other.id == id &&
          other.parentId == parentId &&
          other.number == number &&
          other.orderKey == orderKey &&
          other.createdVia == createdVia &&
          other.version == version &&
          other.status == status &&
          other.currency == currency &&
          other.dateCreated == dateCreated &&
          other.dateCreatedGmt == dateCreatedGmt &&
          other.dateModified == dateModified &&
          other.dateModifiedGmt == dateModifiedGmt &&
          other.discountTotal == discountTotal &&
          other.discountTax == discountTax &&
          other.shippingTotal == shippingTotal &&
          other.shippingTax == shippingTax &&
          other.cartTax == cartTax &&
          other.total == total &&
          other.totalTax == totalTax &&
          other.pricesIncludeTax == pricesIncludeTax &&
          other.customerId == customerId &&
          other.customerIpAddress == customerIpAddress &&
          other.customerUserAgent == customerUserAgent &&
          other.customerNote == customerNote &&
          other.billing == billing &&
          other.shipping == shipping &&
          other.paymentMethod == paymentMethod &&
          other.paymentMethodTitle == paymentMethodTitle &&
          other.transactionId == transactionId &&
          other.datePaid == datePaid &&
          other.datePaidGmt == datePaidGmt &&
          other.dateCompleted == dateCompleted &&
          other.dateCompletedGmt == dateCompletedGmt &&
          other.cartHash == cartHash &&
          WooJson.listEquals(other.metaData, metaData) &&
          WooJson.listEquals(other.lineItems, lineItems) &&
          WooJson.listEquals(other.taxLines, taxLines) &&
          WooJson.listEquals(other.shippingLines, shippingLines) &&
          WooJson.listEquals(other.feeLines, feeLines) &&
          WooJson.listEquals(other.couponLines, couponLines) &&
          WooJson.listEquals(other.refunds, refunds) &&
          other.setPaid == setPaid;
  @override
  int get hashCode => Object.hashAll([
        id,
        parentId,
        number,
        orderKey,
        createdVia,
        version,
        status,
        currency,
        dateCreated,
        dateCreatedGmt,
        dateModified,
        dateModifiedGmt,
        discountTotal,
        discountTax,
        shippingTotal,
        shippingTax,
        cartTax,
        total,
        totalTax,
        pricesIncludeTax,
        customerId,
        customerIpAddress,
        customerUserAgent,
        customerNote,
        billing,
        shipping,
        paymentMethod,
        paymentMethodTitle,
        transactionId,
        datePaid,
        datePaidGmt,
        dateCompleted,
        dateCompletedGmt,
        cartHash,
        ...(metaData ?? const []),
        ...(lineItems ?? const []),
        ...(taxLines ?? const []),
        ...(shippingLines ?? const []),
        ...(feeLines ?? const []),
        ...(couponLines ?? const []),
        ...(refunds ?? const []),
        setPaid,
      ]);
}
