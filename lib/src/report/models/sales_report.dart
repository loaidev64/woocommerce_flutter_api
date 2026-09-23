import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooSalesReport {
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
  factory WooSalesReport.fromJson(Map<String, dynamic> json) {
    final totalsJson = WooJson.readMap(json, 'totals');
    return WooSalesReport(
      totalSales: WooJson.readString(json, 'total_sales'),
      netSales: WooJson.readString(json, 'net_sales'),
      averageSales: WooJson.readString(json, 'average_sales'),
      totalOrders: WooJson.readInt(json, 'total_orders'),
      totalItems: WooJson.readInt(json, 'total_items'),
      totalTax: WooJson.readString(json, 'total_tax'),
      totalShipping: WooJson.readString(json, 'total_shipping'),
      totalRefunds: WooJson.readInt(json, 'total_refunds'),
      totalDiscount: WooJson.readInt(json, 'total_discount'),
      totalsGroupedBy: WooJson.readString(json, 'totals_grouped_by'),
      totals: totalsJson == null
          ? null
          : [
              for (final entry in totalsJson.entries)
                if (entry.value is Map<String, dynamic>)
                  WooSalesReportTotals.fromJson(
                    entry.value as Map<String, dynamic>,
                    entry.key,
                  ),
            ],
    );
  }
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
  final String? totalSales;
  final String? netSales;
  final String? averageSales;
  final int? totalOrders;
  final int? totalItems;
  final String? totalTax;
  final String? totalShipping;
  final int? totalRefunds;
  final int? totalDiscount;
  final String? totalsGroupedBy;
  final List<WooSalesReportTotals>? totals;
  WooSalesReport copyWith({
    String? totalSales,
    String? netSales,
    String? averageSales,
    int? totalOrders,
    int? totalItems,
    String? totalTax,
    String? totalShipping,
    int? totalRefunds,
    int? totalDiscount,
    String? totalsGroupedBy,
    List<WooSalesReportTotals>? totals,
  }) =>
      WooSalesReport(
        totalSales: totalSales ?? this.totalSales,
        netSales: netSales ?? this.netSales,
        averageSales: averageSales ?? this.averageSales,
        totalOrders: totalOrders ?? this.totalOrders,
        totalItems: totalItems ?? this.totalItems,
        totalTax: totalTax ?? this.totalTax,
        totalShipping: totalShipping ?? this.totalShipping,
        totalRefunds: totalRefunds ?? this.totalRefunds,
        totalDiscount: totalDiscount ?? this.totalDiscount,
        totalsGroupedBy: totalsGroupedBy ?? this.totalsGroupedBy,
        totals: totals ?? this.totals,
      );
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
        WooJson.listEquals(other.totals, totals);
  }

  @override
  int get hashCode => Object.hashAll([
        totalSales,
        netSales,
        averageSales,
        totalOrders,
        totalItems,
        totalTax,
        totalShipping,
        totalRefunds,
        totalDiscount,
        totalsGroupedBy,
        ...(totals ?? const []),
      ]);
  @override
  String toString() => 'WooSalesReport(totalSales: $totalSales, '
      'netSales: $netSales, totalOrders: $totalOrders)';
}

class WooSalesReportTotals {
  WooSalesReportTotals({
    this.date,
    this.sales,
    this.orders,
    this.items,
    this.tax,
    this.shipping,
    this.discount,
    this.customers,
  });
  factory WooSalesReportTotals.fromJson(
          Map<String, dynamic> json, String key) =>
      WooSalesReportTotals(
        date: DateTime.tryParse(key),
        sales: WooJson.readString(json, 'sales'),
        orders: WooJson.readInt(json, 'orders'),
        items: WooJson.readInt(json, 'items'),
        tax: WooJson.readString(json, 'tax'),
        shipping: WooJson.readString(json, 'shipping'),
        discount: WooJson.readString(json, 'discount'),
        customers: WooJson.readInt(json, 'customers'),
      );
  factory WooSalesReportTotals.fake() => WooSalesReportTotals(
        date: FakeHelper.datetime(),
        sales: FakeHelper.decimal().toString(),
        orders: FakeHelper.integer(),
        items: FakeHelper.integer(),
        tax: FakeHelper.decimal().toString(),
        shipping: FakeHelper.decimal().toString(),
        discount: FakeHelper.decimal().toString(),
        customers: FakeHelper.integer(),
      );
  final DateTime? date;
  final String? sales;
  final int? orders;
  final int? items;
  final String? tax;
  final String? shipping;
  final String? discount;
  final int? customers;
  WooSalesReportTotals copyWith({
    DateTime? date,
    String? sales,
    int? orders,
    int? items,
    String? tax,
    String? shipping,
    String? discount,
    int? customers,
  }) =>
      WooSalesReportTotals(
        date: date ?? this.date,
        sales: sales ?? this.sales,
        orders: orders ?? this.orders,
        items: items ?? this.items,
        tax: tax ?? this.tax,
        shipping: shipping ?? this.shipping,
        discount: discount ?? this.discount,
        customers: customers ?? this.customers,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooSalesReportTotals &&
        other.date == date &&
        other.sales == sales &&
        other.orders == orders &&
        other.items == items &&
        other.tax == tax &&
        other.shipping == shipping &&
        other.discount == discount &&
        other.customers == customers;
  }

  @override
  int get hashCode => Object.hashAll([
        date,
        sales,
        orders,
        items,
        tax,
        shipping,
        discount,
        customers,
      ]);
  @override
  String toString() => 'WooSalesReportTotals(date: $date, '
      'sales: $sales, orders: $orders)';
}
