import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

/// Represents a top sellers report with basic information.
///
/// Brief description of the model's purpose and usage.
class WooTopSellersReport {

  /// Creates a new WooTopSellersReport instance.
  WooTopSellersReport({
    this.title,
    this.productId,
    this.quantity,
  });

  /// Creates a WooTopSellersReport instance from JSON data.
  WooTopSellersReport.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        productId = json['product_id'],
        quantity = json['quantity'];

  factory WooTopSellersReport.fake() => WooTopSellersReport(
        title: FakeHelper.word(),
        productId: FakeHelper.integer(),
        quantity: FakeHelper.integer(),
      );
  /// Product title.
  String? title;

  /// Product ID.
  int? productId;

  /// Total number of purchases.
  int? quantity;

  Map<String, dynamic> _toJson() => {
        'title': title,
        'product_id': productId,
        'quantity': quantity,
      };

  /// Returns a string representation of the WooTopSellersReport instance.
  ///
  /// Displays all main fields for debugging and logging purposes.
  @override
  String toString() => _toJson().toString();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WooTopSellersReport &&
        other.title == title &&
        other.productId == productId &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => title.hashCode ^ productId.hashCode ^ quantity.hashCode;
}
