# report

## report_api

### extension WooReportApi on WooCommerce

WooCommerce Report API Extension

This extension provides comprehensive reporting capabilities for WooCommerce stores.
It enables retrieval of sales analytics, top sellers data, and various total reports
to help store owners understand their business performance.

## Key Features

- **Sales Analytics**: Get detailed sales reports with financial metrics
- **Top Sellers**: Identify best-performing products and their sales data
- **Total Reports**: Access aggregated data for coupons, customers, orders, products, and reviews
- **Flexible Time Periods**: Generate reports for different time ranges (week, month, year)
- **Date Range Filtering**: Specify custom date ranges for reports

## Example Usage

```dart
// Get sales report for current month
final salesReport = await wooCommerce.getSalesReport(
  period: WooReportPeriod.month,
);

// Get top sellers for last month
final topSellers = await wooCommerce.getTopSellersReport(
  period: WooReportPeriod.last_month,
);

// Get coupon totals
final couponTotals = await wooCommerce.getCouponsTotalReport();
```

### Future<List<WooReportItem>> getReports({bool? useFaker}) async

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### Future<List<WooSalesReport>> getSalesReport({ WooContext context = WooContext.view, WooReportPeriod? period, String? dateMin, String? dateMax, bool? useFaker, }) async

Retrieves a comprehensive sales report from the WooCommerce store.

This method provides detailed sales analytics including gross sales, net sales,
order statistics, and time-based breakdowns. It supports flexible time periods
and custom date ranges for precise reporting.
https://woocommerce.github.io/woocommerce-rest-api-docs/#sales-report

## Parameters

* [context] - Scope under which the request is made; determines fields present in response.
  - `WooContext.view`: Returns basic sales information (default)
  - `WooContext.edit`: Returns full sales details including sensitive data

* [period] - Report period for the sales data. Options: week, month, last_month, year
* [dateMin] - Return sales for a specific start date, in the format `YYYY-MM-DD`
* [dateMax] - Return sales for a specific end date, in the format `YYYY-MM-DD`
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<List<WooSalesReport>>` containing the sales report objects with detailed analytics.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Get sales report for current month
final salesReport = await wooCommerce.getSalesReport(
  period: WooReportPeriod.month,
);

// Get sales report for custom date range
final customReport = await wooCommerce.getSalesReport(
  dateMin: '2024-01-01',
  dateMax: '2024-01-31',
);

// Get detailed sales report
final detailedReport = await wooCommerce.getSalesReport(
  context: WooContext.edit,
  period: WooReportPeriod.year,
);
```

### Future<List<WooTopSellersReport>> getTopSellersReport({ WooContext context = WooContext.view, WooReportPeriod? period, String? dateMin, String? dateMax, bool? useFaker, }) async

Retrieves the top sellers report from the WooCommerce store.

This method provides information about the best-performing products based on
sales quantity. It helps identify which products are selling the most during
the specified time period.
https://woocommerce.github.io/woocommerce-rest-api-docs/#top-sellers-report

## Parameters

* [context] - Scope under which the request is made; determines fields present in response.
  - `WooContext.view`: Returns basic product information (default)
  - `WooContext.edit`: Returns full product details including sensitive data

* [period] - Report period for the top sellers data. Options: week, month, last_month, year
* [dateMin] - Return top sellers for a specific start date, in the format `YYYY-MM-DD`
* [dateMax] - Return top sellers for a specific end date, in the format `YYYY-MM-DD`
* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<List<WooTopSellersReport>>` containing the top sellers report objects.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Get top sellers for current month
final topSellers = await wooCommerce.getTopSellersReport(
  period: WooReportPeriod.month,
);

// Get top sellers for last month
final lastMonthSellers = await wooCommerce.getTopSellersReport(
  period: WooReportPeriod.last_month,
);

// Get top sellers for custom date range
final customSellers = await wooCommerce.getTopSellersReport(
  dateMin: '2024-01-01',
  dateMax: '2024-01-31',
);
```

### Future<List<WooCouponTotalReport>> getCouponsTotalReport

Retrieves the coupon totals report from the WooCommerce store.

This method provides aggregated data about coupon usage, showing the total
number of coupons by type. It helps track promotional campaign effectiveness
and coupon performance.

## Parameters

* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<List<WooCouponTotalReport>>` containing the coupon totals report objects.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Get coupon totals
final couponTotals = await wooCommerce.getCouponsTotalReport();

// Get coupon totals with fake data for testing
final fakeTotals = await wooCommerce.getCouponsTotalReport(useFaker: true);
```

### Future<List<WooCustomerTotalReport>> getCustomersTotalReport

Retrieves the customer totals report from the WooCommerce store.

This method provides aggregated data about customer counts by type,
helping track customer acquisition and segmentation performance.

## Parameters

* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<List<WooCustomerTotalReport>>` containing the customer totals report objects.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Get customer totals
final customerTotals = await wooCommerce.getCustomersTotalReport();

// Get customer totals with fake data for testing
final fakeTotals = await wooCommerce.getCustomersTotalReport(useFaker: true);
```

### Future<List<WooOrderTotalReport>> getOrdersTotalReport

Retrieves the order totals report from the WooCommerce store.

This method provides aggregated data about order counts by status,
helping track order processing performance and fulfillment metrics.

## Parameters

* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<List<WooOrderTotalReport>>` containing the order totals report objects.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Get order totals
final orderTotals = await wooCommerce.getOrdersTotalReport();

// Get order totals with fake data for testing
final fakeTotals = await wooCommerce.getOrdersTotalReport(useFaker: true);
```

### Future<List<WooProductTotalReport>> getProductsTotalReport

Retrieves the product totals report from the WooCommerce store.

This method provides aggregated data about product counts by type,
helping track product catalog performance and inventory management.

## Parameters

* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<List<WooProductTotalReport>>` containing the product totals report objects.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Get product totals
final productTotals = await wooCommerce.getProductsTotalReport();

// Get product totals with fake data for testing
final fakeTotals = await wooCommerce.getProductsTotalReport(useFaker: true);
```

### Future<List<WooProductReviewTotalReport>> getProductReviewsTotalReport

Retrieves the product review totals report from the WooCommerce store.

This method provides aggregated data about product review counts by status,
helping track customer feedback and review management performance.

## Parameters

* [useFaker] - When true, returns fake data for testing purposes

## Returns

A `Future<List<WooProductReviewTotalReport>>` containing the product review totals report objects.

## Throws

* `WooCommerceException` if the request fails or access is denied

## Example Usage

```dart
// Get product review totals
final reviewTotals = await wooCommerce.getProductReviewsTotalReport();

// Get product review totals with fake data for testing
final fakeTotals = await wooCommerce.getProductReviewsTotalReport(useFaker: true);
```

## report_period

### enum WooReportPeriod implements WooEnum

WooCommerce Report Period Enumeration

Defines the possible time periods for generating reports in WooCommerce.
This enum is used to specify the time range for sales reports, top sellers reports,
and other analytics data.

## Usage Examples

```dart
// Get sales report for the current month
final salesReport = await wooCommerce.getSalesReport(
  period: WooReportPeriod.month,
);

// Get top sellers for the last month
final topSellers = await wooCommerce.getTopSellersReport(
  period: WooReportPeriod.last_month,
);

// Check report period
if (period == WooReportPeriod.year) {
  print('Generating yearly report');
}
```

### week('week'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### month('month'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### lastMonth('last_month'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### year('year'),

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### unknown('unknown')

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### const WooReportPeriod(this.value)

WooCommerce Report Period Enumeration

Defines the possible time periods for generating reports in WooCommerce.
This enum is used to specify the time range for sales reports, top sellers reports,
and other analytics data.

## Usage Examples

```dart
// Get sales report for the current month
final salesReport = await wooCommerce.getSalesReport(
  period: WooReportPeriod.month,
);

// Get top sellers for the last month
final topSellers = await wooCommerce.getTopSellersReport(
  period: WooReportPeriod.last_month,
);

// Check report period
if (period == WooReportPeriod.year) {
  print('Generating yearly report');
}
```

### final String value

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### static WooReportPeriod fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## coupon_total_report

### class WooCouponTotalReport

Represents a coupon total report with basic information.

Brief description of the model's purpose and usage.

### WooCouponTotalReport({this.slug, this.name, this.total})

Represents a coupon total report with basic information.

Brief description of the model's purpose and usage.

### factory WooCouponTotalReport.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooCouponTotalReport.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? slug

An alphanumeric identifier for the resource.

### final String? name

Coupon type name.

### final String? total

Amount of coupons.

### WooCouponTotalReport copyWith({String? slug, String? name, String? total})

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooCouponTotalReport instance.

Displays all main fields for debugging and logging purposes.

## customer_total_report

### class WooCustomerTotalReport

Represents a customer total report with basic information.

Brief description of the model's purpose and usage.

### WooCustomerTotalReport({this.slug, this.name, this.total})

Represents a customer total report with basic information.

Brief description of the model's purpose and usage.

### factory WooCustomerTotalReport.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooCustomerTotalReport.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? slug

An alphanumeric identifier for the resource.

### final String? name

Customer type name.

### final String? total

Amount of customers.

### WooCustomerTotalReport copyWith({ String? slug, String? name, String? total, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooCustomerTotalReport instance.

Displays all main fields for debugging and logging purposes.

## order_total_report

### class WooOrderTotalReport

Represents an order total report with basic information.

Brief description of the model's purpose and usage.

### WooOrderTotalReport({this.slug, this.name, this.total})

Represents an order total report with basic information.

Brief description of the model's purpose and usage.

### factory WooOrderTotalReport.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooOrderTotalReport.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? slug

An alphanumeric identifier for the resource.

### final String? name

Order type name.

### final String? total

Amount of orders.

### WooOrderTotalReport copyWith({String? slug, String? name, String? total})

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooOrderTotalReport instance.

Displays all main fields for debugging and logging purposes.

## product_total_report

### class WooProductTotalReport

Represents a product total report with basic information.

Brief description of the model's purpose and usage.

### WooProductTotalReport({this.slug, this.name, this.total})

Represents a product total report with basic information.

Brief description of the model's purpose and usage.

### factory WooProductTotalReport.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooProductTotalReport.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? slug

An alphanumeric identifier for the resource.

### final String? name

Product type name.

### final String? total

Amount of products.

### WooProductTotalReport copyWith({String? slug, String? name, String? total})

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooProductTotalReport instance.

Displays all main fields for debugging and logging purposes.

## report_item

### class WooReportItem

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooReportItem({this.slug, this.description, this.group})

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooReportItem.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooReportItem.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? slug

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? description

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? group

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### WooReportItem copyWith({ String? slug, String? description, String? group, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

## review_total_report

### class WooProductReviewTotalReport

Represents a product review total report with basic information.

Brief description of the model's purpose and usage.

### WooProductReviewTotalReport({this.slug, this.name, this.total})

Represents a product review total report with basic information.

Brief description of the model's purpose and usage.

### factory WooProductReviewTotalReport.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooProductReviewTotalReport.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? slug

An alphanumeric identifier for the resource.

### final String? name

Review type name.

### final String? total

Amount of reviews.

### WooProductReviewTotalReport copyWith({ String? slug, String? name, String? total, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooProductReviewTotalReport instance.

Displays all main fields for debugging and logging purposes.

## sales_report

### class WooSalesReport

WooCommerce Sales Report Model

Represents comprehensive sales analytics data for a WooCommerce store.
This model provides detailed insights into sales performance, including
gross sales, net sales, order statistics, and time-based breakdowns.

## Key Features

- **Sales Analytics**: Track gross sales, net sales, and average daily sales
- **Order Statistics**: Monitor total orders, items sold, and refunds
- **Financial Breakdown**: Track taxes, shipping costs, and discounts
- **Time-based Data**: Access detailed totals grouped by date periods

## Usage Examples

### Creating a Sales Report

```dart
final salesReport = WooSalesReport(
  totalSales: '15000.00',
  netSales: '12000.00',
  totalOrders: 150,
);
```

### Working with Sales Data

```dart
// Check sales performance
if (salesReport.totalSales != null) {
  print('Total Sales: \$${salesReport.totalSales}');
}

// Access time-based breakdown
for (final total in salesReport.totals ?? []) {
  print('Date: ${total.date}, Sales: ${total.sales}');
}
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = salesReport.toJson();

// Create from JSON response
final salesReport = WooSalesReport.fromJson(jsonData);
```

### WooSalesReport({ this.totalSales, this.netSales, this.averageSales, this.totalOrders, this.totalItems, this.totalTax, this.totalShipping, this.totalRefunds, this.totalDiscount, this.totalsGroupedBy, this.totals, })

WooCommerce Sales Report Model

Represents comprehensive sales analytics data for a WooCommerce store.
This model provides detailed insights into sales performance, including
gross sales, net sales, order statistics, and time-based breakdowns.

## Key Features

- **Sales Analytics**: Track gross sales, net sales, and average daily sales
- **Order Statistics**: Monitor total orders, items sold, and refunds
- **Financial Breakdown**: Track taxes, shipping costs, and discounts
- **Time-based Data**: Access detailed totals grouped by date periods

## Usage Examples

### Creating a Sales Report

```dart
final salesReport = WooSalesReport(
  totalSales: '15000.00',
  netSales: '12000.00',
  totalOrders: 150,
);
```

### Working with Sales Data

```dart
// Check sales performance
if (salesReport.totalSales != null) {
  print('Total Sales: \$${salesReport.totalSales}');
}

// Access time-based breakdown
for (final total in salesReport.totals ?? []) {
  print('Date: ${total.date}, Sales: ${total.sales}');
}
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = salesReport.toJson();

// Create from JSON response
final salesReport = WooSalesReport.fromJson(jsonData);
```

### factory WooSalesReport.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooSalesReport.fake()

Creates a fake WooSalesReport instance for testing purposes

This factory constructor generates a sales report with random but realistic
data, making it useful for testing and development.

## Returns

A `WooSalesReport` instance with randomly generated fake data.

## Example Usage

```dart
final fakeSalesReport = WooSalesReport.fake();
```

### final String? totalSales

Gross sales in the period. Read-only.

The total revenue before any deductions such as taxes, shipping,
or discounts. This represents the raw sales amount.

### final String? netSales

Net sales in the period. Read-only.

The total revenue after deducting taxes, shipping, and discounts.
This represents the actual revenue received by the store.

### final String? averageSales

Average net daily sales. Read-only.

The average daily net sales calculated over the reporting period.
Useful for understanding daily performance trends.

### final int? totalOrders

Total of orders placed. Read-only.

The total number of orders received during the reporting period.
This count includes all orders regardless of their status.

### final int? totalItems

Total of items purchased. Read-only.

The total quantity of items sold across all orders in the period.
This represents the sum of all product quantities sold.

### final String? totalTax

Total charged for taxes. Read-only.

The total amount of taxes collected on all orders during the period.
This includes all applicable tax types (sales tax, VAT, etc.).

### final String? totalShipping

Total charged for shipping. Read-only.

The total amount collected for shipping costs across all orders.
This includes both paid and free shipping charges.

### final int? totalRefunds

Total of refunded orders. Read-only.

The total number of orders that have been refunded during the period.
This helps track customer satisfaction and return rates.

### final int? totalDiscount

Total of coupons used. Read-only.

The total number of discount coupons applied to orders during the period.
This helps track promotional campaign effectiveness.

### final String? totalsGroupedBy

Group type. Read-only.

The grouping method used for the time-based totals breakdown.
Common values include 'day', 'week', 'month', or 'year'.

### final List<WooSalesReportTotals>? totals

Totals grouped by date. Read-only.

A list of detailed sales data broken down by time periods.
Each entry contains sales metrics for a specific date or period.

### WooSalesReport copyWith({ String? totalSales, String? netSales, String? averageSales, int? totalOrders, int? totalItems, String? totalTax, String? totalShipping, int? totalRefunds, int? totalDiscount, String? totalsGroupedBy, List<WooSalesReportTotals>? totals, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooSalesReport instance

This method provides a human-readable representation of the sales report,
displaying all main fields for debugging and logging purposes.

## Returns

A `String` containing the sales report's main field values in a readable format.

## Example Usage

```dart
final salesReport = WooSalesReport(totalSales: '15000.00', totalOrders: 150);
print(salesReport.toString());
// Output: {total_sales: 15000.00, total_orders: 150, ...}
```

### class WooSalesReportTotals

WooCommerce Sales Report Totals Model

Represents detailed sales data for a specific time period within a sales report.
This model provides granular breakdown of sales metrics for individual dates
or time periods, allowing for detailed analysis of sales performance.

## Key Features

- **Time-based Data**: Sales metrics for specific dates or periods
- **Financial Metrics**: Sales amounts, taxes, shipping, and discounts
- **Order Statistics**: Order counts and item quantities
- **Customer Analytics**: Customer count for the period

## Usage Examples

### Working with Time-based Data

```dart
final total = WooSalesReportTotals(
  date: DateTime.now(),
  sales: '1200.00',
  orders: 15,
  items: 45,
);
```

### Accessing Sales Data

```dart
// Check sales performance for a specific date
if (total.sales != null) {
  print('Sales for ${total.date}: \$${total.sales}');
}
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = total.toJson();

// Create from JSON response
final total = WooSalesReportTotals.fromJson(jsonData, dateKey);
```

### WooSalesReportTotals({ this.date, this.sales, this.orders, this.items, this.tax, this.shipping, this.discount, this.customers, })

WooCommerce Sales Report Totals Model

Represents detailed sales data for a specific time period within a sales report.
This model provides granular breakdown of sales metrics for individual dates
or time periods, allowing for detailed analysis of sales performance.

## Key Features

- **Time-based Data**: Sales metrics for specific dates or periods
- **Financial Metrics**: Sales amounts, taxes, shipping, and discounts
- **Order Statistics**: Order counts and item quantities
- **Customer Analytics**: Customer count for the period

## Usage Examples

### Working with Time-based Data

```dart
final total = WooSalesReportTotals(
  date: DateTime.now(),
  sales: '1200.00',
  orders: 15,
  items: 45,
);
```

### Accessing Sales Data

```dart
// Check sales performance for a specific date
if (total.sales != null) {
  print('Sales for ${total.date}: \$${total.sales}');
}
```

## JSON Serialization

The class supports full JSON serialization for API communication:

```dart
// Convert to JSON for API requests
final json = total.toJson();

// Create from JSON response
final total = WooSalesReportTotals.fromJson(jsonData, dateKey);
```

### factory WooSalesReportTotals.fromJson

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooSalesReportTotals.fake()

Creates a fake WooSalesReportTotals instance for testing purposes

This factory constructor generates sales totals with random but realistic
data, making it useful for testing and development.

## Returns

A `WooSalesReportTotals` instance with randomly generated fake data.

## Example Usage

```dart
final fakeTotal = WooSalesReportTotals.fake();
```

### final DateTime? date

The date of this total.

The specific date or time period this data represents.
Used for time-based analysis and reporting.

### final String? sales

Total sales for the date.

The total sales amount for this specific time period.
This represents the gross sales before any deductions.

### final int? orders

Total orders for the date.

The number of orders placed during this time period.
This count includes all orders regardless of status.

### final int? items

Total items sold for the date.

The total quantity of items sold during this time period.
This represents the sum of all product quantities sold.

### final String? tax

Total tax for the date.

The total amount of taxes collected during this time period.
This includes all applicable tax types.

### final String? shipping

Total shipping for the date.

The total amount collected for shipping costs during this time period.
This includes both paid and free shipping charges.

### final String? discount

Total discount for the date.

The total amount of discounts applied during this time period.
This includes all types of discounts and coupons.

### final int? customers

Total customers for the date.

The number of unique customers who made purchases during this time period.
This helps track customer acquisition and retention.

### WooSalesReportTotals copyWith({ DateTime? date, String? sales, int? orders, int? items, String? tax, String? shipping, String? discount, int? customers, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooSalesReport instance

This method provides a human-readable representation of the sales report,
displaying all main fields for debugging and logging purposes.

## Returns

A `String` containing the sales report's main field values in a readable format.

## Example Usage

```dart
final salesReport = WooSalesReport(totalSales: '15000.00', totalOrders: 150);
print(salesReport.toString());
// Output: {total_sales: 15000.00, total_orders: 150, ...}
```

## top_sellers_report

### class WooTopSellersReport

Represents a top sellers report with basic information.

Brief description of the model's purpose and usage.

### WooTopSellersReport({this.title, this.productId, this.quantity})

Represents a top sellers report with basic information.

Brief description of the model's purpose and usage.

### factory WooTopSellersReport.fromJson(Map<String, dynamic> json)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### factory WooTopSellersReport.fake()

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### final String? title

Product title.

### final int? productId

Product ID.

### final int? quantity

Total number of purchases.

### WooTopSellersReport copyWith({ String? title, int? productId, int? quantity, })

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### bool operator ==(Object other)

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### int get hashCode

*No package documentation — see SKILL.md and the official WooCommerce REST API docs.*

### String toString()

Returns a string representation of the WooTopSellersReport instance.

Displays all main fields for debugging and logging purposes.

