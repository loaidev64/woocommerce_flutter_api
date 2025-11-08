import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

/// WooCommerce Sales Report Model
///
/// Represents comprehensive sales analytics data for a WooCommerce store.
/// This model provides detailed insights into sales performance, including
/// gross sales, net sales, order statistics, and time-based breakdowns.
///
/// ## Key Features
///
/// - **Sales Analytics**: Track gross sales, net sales, and average daily sales
/// - **Order Statistics**: Monitor total orders, items sold, and refunds
/// - **Financial Breakdown**: Track taxes, shipping costs, and discounts
/// - **Time-based Data**: Access detailed totals grouped by date periods
///
/// ## Usage Examples
///
/// ### Creating a Sales Report
///
/// ```dart
/// final salesReport = WooSalesReport(
///   totalSales: '15000.00',
///   netSales: '12000.00',
///   totalOrders: 150,
/// );
/// ```
///
/// ### Working with Sales Data
///
/// ```dart
/// // Check sales performance
/// if (salesReport.totalSales != null) {
///   print('Total Sales: \$${salesReport.totalSales}');
/// }
///
/// // Access time-based breakdown
/// for (final total in salesReport.totals ?? []) {
///   print('Date: ${total.date}, Sales: ${total.sales}');
/// }
/// ```
///
/// ## JSON Serialization
///
/// The class supports full JSON serialization for API communication:
///
/// ```dart
/// // Convert to JSON for API requests
/// final json = salesReport.toJson();
///
/// // Create from JSON response
/// final salesReport = WooSalesReport.fromJson(jsonData);
/// ```
class WooSalesReport {

  /// Creates a new WooSalesReport instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional
  ///
  /// ## Optional Parameters
  ///
  /// * [totalSales] - Gross sales amount for the period
  /// * [netSales] - Net sales amount after deductions
  /// * [averageSales] - Average daily sales amount
  /// * [totalOrders] - Total number of orders placed
  /// * [totalItems] - Total quantity of items sold
  /// * [totalTax] - Total tax amount collected
  /// * [totalShipping] - Total shipping charges collected
  /// * [totalRefunds] - Total number of refunded orders
  /// * [totalDiscount] - Total number of coupons used
  /// * [totalsGroupedBy] - Grouping method for time-based data
  /// * [totals] - List of detailed time-based sales data
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final salesReport = WooSalesReport(
  ///   totalSales: '15000.00',
  ///   netSales: '12000.00',
  ///   totalOrders: 150,
  /// );
  /// ```
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

  /// Creates a WooSalesReport instance from JSON data
  ///
  /// This factory constructor is used to deserialize sales report data received
  /// from the WooCommerce REST API.
  ///
  /// ## Parameters
  ///
  /// * [json] - A Map containing the sales report data in JSON format
  ///
  /// ## Returns
  ///
  /// A `WooSalesReport` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final salesReport = WooSalesReport.fromJson(jsonData);
  /// ```
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

  /// Creates a fake WooSalesReport instance for testing purposes
  ///
  /// This factory constructor generates a sales report with random but realistic
  /// data, making it useful for testing and development.
  ///
  /// ## Returns
  ///
  /// A `WooSalesReport` instance with randomly generated fake data.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final fakeSalesReport = WooSalesReport.fake();
  /// ```
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
  /// Gross sales in the period. Read-only.
  ///
  /// The total revenue before any deductions such as taxes, shipping,
  /// or discounts. This represents the raw sales amount.
  String? totalSales;

  /// Net sales in the period. Read-only.
  ///
  /// The total revenue after deducting taxes, shipping, and discounts.
  /// This represents the actual revenue received by the store.
  String? netSales;

  /// Average net daily sales. Read-only.
  ///
  /// The average daily net sales calculated over the reporting period.
  /// Useful for understanding daily performance trends.
  String? averageSales;

  /// Total of orders placed. Read-only.
  ///
  /// The total number of orders received during the reporting period.
  /// This count includes all orders regardless of their status.
  int? totalOrders;

  /// Total of items purchased. Read-only.
  ///
  /// The total quantity of items sold across all orders in the period.
  /// This represents the sum of all product quantities sold.
  int? totalItems;

  /// Total charged for taxes. Read-only.
  ///
  /// The total amount of taxes collected on all orders during the period.
  /// This includes all applicable tax types (sales tax, VAT, etc.).
  String? totalTax;

  /// Total charged for shipping. Read-only.
  ///
  /// The total amount collected for shipping costs across all orders.
  /// This includes both paid and free shipping charges.
  String? totalShipping;

  /// Total of refunded orders. Read-only.
  ///
  /// The total number of orders that have been refunded during the period.
  /// This helps track customer satisfaction and return rates.
  int? totalRefunds;

  /// Total of coupons used. Read-only.
  ///
  /// The total number of discount coupons applied to orders during the period.
  /// This helps track promotional campaign effectiveness.
  int? totalDiscount;

  /// Group type. Read-only.
  ///
  /// The grouping method used for the time-based totals breakdown.
  /// Common values include 'day', 'week', 'month', or 'year'.
  String? totalsGroupedBy;

  /// Totals grouped by date. Read-only.
  ///
  /// A list of detailed sales data broken down by time periods.
  /// Each entry contains sales metrics for a specific date or period.
  List<WooSalesReportTotals>? totals;

  /// Converts the WooSalesReport instance to JSON format
  ///
  /// This method serializes the sales report data into a Map that can be sent
  /// to the WooCommerce REST API.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the sales report data in JSON format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final jsonData = salesReport.toJson();
  /// ```
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

  /// Returns a string representation of the WooSalesReport instance
  ///
  /// This method provides a human-readable representation of the sales report,
  /// displaying all main fields for debugging and logging purposes.
  ///
  /// ## Returns
  ///
  /// A `String` containing the sales report's main field values in a readable format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final salesReport = WooSalesReport(totalSales: '15000.00', totalOrders: 150);
  /// print(salesReport.toString());
  /// // Output: {total_sales: 15000.00, total_orders: 150, ...}
  /// ```
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
}

/// WooCommerce Sales Report Totals Model
///
/// Represents detailed sales data for a specific time period within a sales report.
/// This model provides granular breakdown of sales metrics for individual dates
/// or time periods, allowing for detailed analysis of sales performance.
///
/// ## Key Features
///
/// - **Time-based Data**: Sales metrics for specific dates or periods
/// - **Financial Metrics**: Sales amounts, taxes, shipping, and discounts
/// - **Order Statistics**: Order counts and item quantities
/// - **Customer Analytics**: Customer count for the period
///
/// ## Usage Examples
///
/// ### Working with Time-based Data
///
/// ```dart
/// final total = WooSalesReportTotals(
///   date: DateTime.now(),
///   sales: '1200.00',
///   orders: 15,
///   items: 45,
/// );
/// ```
///
/// ### Accessing Sales Data
///
/// ```dart
/// // Check sales performance for a specific date
/// if (total.sales != null) {
///   print('Sales for ${total.date}: \$${total.sales}');
/// }
/// ```
///
/// ## JSON Serialization
///
/// The class supports full JSON serialization for API communication:
///
/// ```dart
/// // Convert to JSON for API requests
/// final json = total.toJson();
///
/// // Create from JSON response
/// final total = WooSalesReportTotals.fromJson(jsonData, dateKey);
/// ```
class WooSalesReportTotals {

  /// Creates a new WooSalesReportTotals instance
  ///
  /// ## Required Parameters
  ///
  /// None - all parameters are optional
  ///
  /// ## Optional Parameters
  ///
  /// * [sales] - Total sales amount for the period
  /// * [orders] - Number of orders for the period
  /// * [items] - Total quantity of items sold
  /// * [tax] - Total tax amount collected
  /// * [shipping] - Total shipping charges collected
  /// * [discount] - Total discount amount applied
  /// * [customers] - Number of unique customers
  /// * [date] - The date or time period this data represents
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final total = WooSalesReportTotals(
  ///   date: DateTime.now(),
  ///   sales: '1200.00',
  ///   orders: 15,
  /// );
  /// ```
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

  /// Creates a WooSalesReportTotals instance from JSON data
  ///
  /// This factory constructor is used to deserialize sales totals data received
  /// from the WooCommerce REST API.
  ///
  /// ## Parameters
  ///
  /// * [json] - A Map containing the sales totals data in JSON format
  /// * [key] - The date key used to parse the date for this total
  ///
  /// ## Returns
  ///
  /// A `WooSalesReportTotals` instance populated with data from the JSON.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final total = WooSalesReportTotals.fromJson(jsonData, '2024-01-15');
  /// ```
  WooSalesReportTotals.fromJson(Map<String, dynamic> json, String key)
      : sales = json['sales'],
        orders = json['orders'],
        items = json['items'],
        tax = json['tax'],
        shipping = json['shipping'],
        discount = json['discount'],
        customers = json['customers'],
        date = DateTime.tryParse(key);

  /// Creates a fake WooSalesReportTotals instance for testing purposes
  ///
  /// This factory constructor generates sales totals with random but realistic
  /// data, making it useful for testing and development.
  ///
  /// ## Returns
  ///
  /// A `WooSalesReportTotals` instance with randomly generated fake data.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final fakeTotal = WooSalesReportTotals.fake();
  /// ```
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
  /// The date of this total.
  ///
  /// The specific date or time period this data represents.
  /// Used for time-based analysis and reporting.
  DateTime? date;

  /// Total sales for the date.
  ///
  /// The total sales amount for this specific time period.
  /// This represents the gross sales before any deductions.
  String? sales;

  /// Total orders for the date.
  ///
  /// The number of orders placed during this time period.
  /// This count includes all orders regardless of status.
  int? orders;

  /// Total items sold for the date.
  ///
  /// The total quantity of items sold during this time period.
  /// This represents the sum of all product quantities sold.
  int? items;

  /// Total tax for the date.
  ///
  /// The total amount of taxes collected during this time period.
  /// This includes all applicable tax types.
  String? tax;

  /// Total shipping for the date.
  ///
  /// The total amount collected for shipping costs during this time period.
  /// This includes both paid and free shipping charges.
  String? shipping;

  /// Total discount for the date.
  ///
  /// The total amount of discounts applied during this time period.
  /// This includes all types of discounts and coupons.
  String? discount;

  /// Total customers for the date.
  ///
  /// The number of unique customers who made purchases during this time period.
  /// This helps track customer acquisition and retention.
  int? customers;

  /// Converts the WooSalesReportTotals instance to JSON format
  ///
  /// This method serializes the sales totals data into a Map that can be sent
  /// to the WooCommerce REST API.
  ///
  /// ## Returns
  ///
  /// A `Map<String, dynamic>` containing the sales totals data in JSON format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final jsonData = total.toJson();
  /// ```
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

  /// Returns a string representation of the WooSalesReportTotals instance
  ///
  /// This method provides a human-readable representation of the sales totals,
  /// displaying all main fields for debugging and logging purposes.
  ///
  /// ## Returns
  ///
  /// A `String` containing the sales totals' main field values in a readable format.
  ///
  /// ## Example Usage
  ///
  /// ```dart
  /// final total = WooSalesReportTotals(sales: '1200.00', orders: 15);
  /// print(total.toString());
  /// // Output: {sales: 1200.00, orders: 15, ...}
  /// ```
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
}
