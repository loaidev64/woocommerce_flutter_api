import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

class WooTopSellersReport {
  /// Product title.
  String? title;

  /// Product ID.
  int? productId;

  /// Total number of purchases.
  int? quantity;

  WooTopSellersReport({
    this.title,
    this.productId,
    this.quantity,
  });

  WooTopSellersReport.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        productId = json['product_id'],
        quantity = json['quantity'];

  Map<String, dynamic> _toJson() => {
        'title': title,
        'product_id': productId,
        'quantity': quantity,
      };

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

  factory WooTopSellersReport.fake() => WooTopSellersReport(
        title: FakeHelper.word(),
        productId: FakeHelper.integer(),
        quantity: FakeHelper.integer(),
      );
}
