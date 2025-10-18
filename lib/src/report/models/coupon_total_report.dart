import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

/// Represents a coupon total report with basic information.
///
/// Brief description of the model's purpose and usage.
class WooCouponTotalReport {
  /// An alphanumeric identifier for the resource.
  String? slug;

  /// Coupon type name.
  String? name;

  /// Amount of coupons.
  String? total;

  /// Creates a new WooCouponTotalReport instance.
  WooCouponTotalReport({
    this.slug,
    this.name,
    this.total,
  });

  /// Creates a WooCouponTotalReport instance from JSON data.
  WooCouponTotalReport.fromJson(Map<String, dynamic> json)
      : slug = json['slug'],
        name = json['name'],
        total = json['total']?.toString();

  Map<String, dynamic> _toJson() => {
        'slug': slug,
        'name': name,
        'total': total,
      };

  /// Returns a string representation of the WooCouponTotalReport instance.
  ///
  /// Displays all main fields for debugging and logging purposes.
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
