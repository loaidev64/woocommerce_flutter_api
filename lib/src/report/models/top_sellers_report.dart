import '../../helpers/fake_helper.dart';

class WooTopSellersReport {
  WooTopSellersReport({this.title, this.productId, this.quantity});
  factory WooTopSellersReport.fromJson(Map<String, dynamic> json) =>
      WooTopSellersReport(
        title: json['title']?.toString(),
        productId: json['product_id'] is int
            ? json['product_id'] as int
            : int.tryParse('${json['product_id']}'),
        quantity: json['quantity'] is int
            ? json['quantity'] as int
            : int.tryParse('${json['quantity']}'),
      );
  factory WooTopSellersReport.fake() => WooTopSellersReport(
        title: FakeHelper.word(),
        productId: FakeHelper.integer(),
        quantity: FakeHelper.integer(),
      );
  final String? title;
  final int? productId;
  final int? quantity;
  WooTopSellersReport copyWith({
    String? title,
    int? productId,
    int? quantity,
  }) =>
      WooTopSellersReport(
        title: title ?? this.title,
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooTopSellersReport &&
        other.title == title &&
        other.productId == productId &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => Object.hashAll([title, productId, quantity]);
  @override
  String toString() =>
      'WooTopSellersReport(title: $title, productId: $productId, '
      'quantity: $quantity)';
}
