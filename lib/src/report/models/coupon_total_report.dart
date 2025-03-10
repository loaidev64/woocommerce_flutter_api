import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

class WooCouponTotalReport {
  /// An alphanumeric identifier for the resource.
  String? slug;

  /// Coupon type name.
  String? name;

  /// Amount of coupons.
  String? total;

  WooCouponTotalReport({
    this.slug,
    this.name,
    this.total,
  });

  WooCouponTotalReport.fromJson(Map<String, dynamic> json)
      : slug = json['slug'],
        name = json['name'],
        total = json['total']?.toString();

  Map<String, dynamic> _toJson() => {
        'slug': slug,
        'name': name,
        'total': total,
      };

  @override
  String toString() => _toJson().toString();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WooCouponTotalReport &&
        other.slug == slug &&
        other.name == name &&
        other.total == total;
  }

  @override
  int get hashCode => slug.hashCode ^ name.hashCode ^ total.hashCode;

  factory WooCouponTotalReport.fake() => WooCouponTotalReport(
        slug: FakeHelper.word(),
        name: FakeHelper.word(),
        total: FakeHelper.integer().toString(),
      );
}
