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

class WooOrder {
  /// Unique identifier for the resource.
  int? id;

  /// Parent order ID.
  int? parentId;

  /// Order number.
  String? number;

  /// Order key.
  String? orderKey;

  /// Shows where the order was created. Example: rest-api
  String? createdVia;

  /// Version of WooCommerce which last updated the order.
  String? version;

  /// Order status. Options: pending, processing, on-hold, completed, cancelled, refunded, failed and trash. Default is pending.
  WooOrderStatus? status;

  /// Currency the order was created with, in ISO format. Options: AED, AFN, ALL, AMD, ANG, AOA, ARS, AUD, AWG, AZN, BAM, BBD, BDT, BGN, BHD, BIF, BMD, BND, BOB, BRL, BSD, BTC, BTN, BWP, BYR, BZD, CAD, CDF, CHF, CLP, CNY, COP, CRC, CUC, CUP, CVE, CZK, DJF, DKK, DOP, DZD, EGP, ERN, ETB, EUR, FJD, FKP,
  /// GBP, GEL, GGP, GHS, GIP, GMD, GNF, GTQ, GYD, HKD, HNL, HRK, HTG, HUF, IDR, ILS, IMP, INR, IQD, IRR, IRT, ISK, JEP, JMD, JOD, JPY, KES, KGS, KHR, KMF, KPW, KRW, KWD, KYD, KZT, LAK, LBP, LKR, LRD, LSL, LYD, MAD, MDL, MGA, MKD, MMK, MNT, MOP, MRO, MUR, MVR, MWK, MXN, MYR, MZN, NAD, NGN, NIO, NOK, NPR, NZD, OMR, PAB, PEN, PGK, PHP, PKR, PLN,
  /// PRB, PYG, QAR, RON, RSD, RUB, RWF, SAR, SBD, SCR, SDG, SEK, SGD, SHP, SLL, SOS, SRD, SSP, STD, SYP, SZL, THB, TJS, TMT, TND, TOP, TRY, TTD, TWD, TZS, UAH, UGX, USD, UYU, UZS, VEF, VND, VUV, WST, XAF, XCD, XOF, XPF, YER, ZAR and ZMW. Default is USD.
  WooOrderCurrency? currency;

  /// The date the order was created, in the site's timezone.
  DateTime? dateCreated;

  /// The date the order was created, as GMT.
  DateTime? dateCreatedGmt;

  /// The date the order was last modified, in the site's timezone.
  DateTime? dateModified;

  /// The date the order was last modified, as GMT.
  DateTime? dateModifiedGmt;

  /// Total discount amount for the order.
  double? discountTotal;

  /// Total discount tax amount for the order.
  double? discountTax;

  /// Total shipping amount for the order.
  double? shippingTotal;

  /// Total shipping tax amount for the order.
  double? shippingTax;

  /// Sum of line item taxes only.
  double? cartTax;

  /// Grand total.
  double? total;

  /// Sum of all taxes.
  double? totalTax;

  /// True the prices included tax during checkout.
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

  /// Meta data.
  List<WooMetaData>? metaData;

  /// Line items data.
  List<WooLineItem>? lineItems;

  /// Tax lines data.
  List<WooTaxLine>? taxLines;

  /// Shipping lines data.
  List<WooShippingLine>? shippingLines;

  /// Fee lines data.
  List<WooOrderFeeLine>? feeLines;

  /// Coupons line data.
  List<WooOrderCouponLine>? couponLines;

  /// List of refunds
  List<WooRefund>? refunds;

  /// Define if the order is paid. It will set the status to processing and reduce stock items. Default is false.
  bool? setPaid;

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
        refunds!.add(WooRefund.fromJson(v));
      });
    }
  }

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
    data['date_created'] = dateCreated;
    data['date_created_gmt'] = dateCreatedGmt;
    data['date_modified'] = dateModified;
    data['date_modified_gmt'] = dateModifiedGmt;
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
    data['date_paid'] = datePaid;
    data['date_paid_gmt'] = datePaidGmt;
    data['date_completed'] = dateCompleted;
    data['date_completed_gmt'] = dateCompletedGmt;
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

  @override
  toString() => toJson().toString();

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
        refunds: FakeHelper.list(() => WooRefund.fake()),
        setPaid: FakeHelper.boolean(),
      );
}
