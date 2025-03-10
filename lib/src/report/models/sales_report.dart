import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

class WooSalesReport {
  /// Gross sales in the period. Read-only.
  String? totalSales;

  /// Net sales in the period. Read-only.
  String? netSales;

  /// Average net daily sales. Read-only.
  String? averageSales;

  /// Total of orders placed. Read-only.
  int? totalOrders;

  /// Total of items purchased. Read-only.
  int? totalItems;

  /// Total charged for taxes. Read-only.
  String? totalTax;

  /// Total charged for shipping. Read-only.
  String? totalShipping;

  /// Total of refunded orders. Read-only.
  int? totalRefunds;

  /// Total of coupons used. Read-only.
  int? totalDiscount;

  /// Group type. Read-only.
  String? totalsGroupedBy;

  /// Totals grouped by date. Read-only.
  List<WooSalesReportTotals>? totals;

  WooSalesReport({
    this.totalSales,
    this.netSales,
    this.averageSales,
    this.totalOrders,
    this.totalItems,
    this.totalTax,
    this.totalShipping,
    this.totalRefunds,
    this.totalDiscount,
    this.totalsGroupedBy,
    this.totals,
  });

  WooSalesReport.fromJson(Map<String, dynamic> json)
      : totalSales = json['total_sales'],
        netSales = json['net_sales'],
        averageSales = json['average_sales'],
        totalOrders = json['total_orders'],
        totalItems = json['total_items'],
        totalTax = json['total_tax'],
        totalShipping = json['total_shipping'],
        totalRefunds = json['total_refunds'],
        totalDiscount = json['total_discount'],
        totalsGroupedBy = json['totals_grouped_by'],
        totals = (json['totals'] as Map<String, dynamic>?)
            ?.map(
              (key, value) => MapEntry(
                key,
                WooSalesReportTotals.fromJson(value, key),
              ),
            )
            .values
            .toList();

  Map<String, dynamic> _toJson() => {
        'total_sales': totalSales,
        'net_sales': netSales,
        'average_sales': averageSales,
        'total_orders': totalOrders,
        'total_items': totalItems,
        'total_tax': totalTax,
        'total_shipping': totalShipping,
        'total_refunds': totalRefunds,
        'total_discount': totalDiscount,
        'totals_grouped_by': totalsGroupedBy,
        'totals': totals?.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() => _toJson().toString();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WooSalesReport &&
        other.totalSales == totalSales &&
        other.netSales == netSales &&
        other.averageSales == averageSales &&
        other.totalOrders == totalOrders &&
        other.totalItems == totalItems &&
        other.totalTax == totalTax &&
        other.totalShipping == totalShipping &&
        other.totalRefunds == totalRefunds &&
        other.totalDiscount == totalDiscount &&
        other.totalsGroupedBy == totalsGroupedBy &&
        other.totals == totals;
  }

  @override
  int get hashCode =>
      totalSales.hashCode ^
      netSales.hashCode ^
      averageSales.hashCode ^
      totalOrders.hashCode ^
      totalItems.hashCode ^
      totalTax.hashCode ^
      totalShipping.hashCode ^
      totalRefunds.hashCode ^
      totalDiscount.hashCode ^
      totalsGroupedBy.hashCode ^
      totals.hashCode;

  factory WooSalesReport.fake() => WooSalesReport(
        totalSales: FakeHelper.decimal().toString(),
        netSales: FakeHelper.decimal().toString(),
        averageSales: FakeHelper.decimal().toString(),
        totalOrders: FakeHelper.integer(),
        totalItems: FakeHelper.integer(),
        totalTax: FakeHelper.decimal().toString(),
        totalShipping: FakeHelper.decimal().toString(),
        totalRefunds: FakeHelper.integer(),
        totalDiscount: FakeHelper.integer(),
        totalsGroupedBy: FakeHelper.word(),
        totals: FakeHelper.list(WooSalesReportTotals.fake),
      );
}

class WooSalesReportTotals {
  // the date of this total.
  DateTime? date;

  /// Total sales for the date.
  String? sales;

  /// Total orders for the date.
  int? orders;

  /// Total items sold for the date.
  int? items;

  /// Total tax for the date.
  String? tax;

  /// Total shipping for the date.
  String? shipping;

  /// Total discount for the date.
  String? discount;

  /// Total customers for the date.
  int? customers;

  WooSalesReportTotals({
    this.sales,
    this.orders,
    this.items,
    this.tax,
    this.shipping,
    this.discount,
    this.customers,
    this.date,
  });

  WooSalesReportTotals.fromJson(Map<String, dynamic> json, String key)
      : sales = json['sales'],
        orders = json['orders'],
        items = json['items'],
        tax = json['tax'],
        shipping = json['shipping'],
        discount = json['discount'],
        customers = json['customers'],
        date = DateTime.tryParse(key);

  Map<String, dynamic> toJson() => {
        'sales': sales,
        'orders': orders,
        'items': items,
        'tax': tax,
        'shipping': shipping,
        'discount': discount,
        'date': date?.toIso8601String(),
        'customers': customers,
      };

  @override
  String toString() => toJson().toString();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WooSalesReportTotals &&
        other.sales == sales &&
        other.orders == orders &&
        other.items == items &&
        other.tax == tax &&
        other.shipping == shipping &&
        other.discount == discount &&
        other.customers == customers;
  }

  @override
  int get hashCode =>
      sales.hashCode ^
      orders.hashCode ^
      items.hashCode ^
      tax.hashCode ^
      shipping.hashCode ^
      discount.hashCode ^
      customers.hashCode;

  factory WooSalesReportTotals.fake() => WooSalesReportTotals(
        sales: FakeHelper.decimal().toString(),
        orders: FakeHelper.integer(),
        items: FakeHelper.integer(),
        tax: FakeHelper.decimal().toString(),
        shipping: FakeHelper.decimal().toString(),
        discount: FakeHelper.decimal().toString(),
        customers: FakeHelper.integer(),
        date: FakeHelper.datetime(),
      );
}
