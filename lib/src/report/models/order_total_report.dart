import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

/// Represents an order total report with basic information.
///
/// Brief description of the model's purpose and usage.
class WooOrderTotalReport {
  /// An alphanumeric identifier for the resource.
  String? slug;

  /// Order type name.
  String? name;

  /// Amount of orders.
  String? total;

  /// Creates a new WooOrderTotalReport instance.
  WooOrderTotalReport({
    this.slug,
    this.name,
    this.total,
  });

  /// Creates a WooOrderTotalReport instance from JSON data.
  WooOrderTotalReport.fromJson(Map<String, dynamic> json)
      : slug = json['slug'],
        name = json['name'],
        total = json['total']?.toString();

  Map<String, dynamic> _toJson() => {
        'slug': slug,
        'name': name,
        'total': total,
      };

  /// Returns a string representation of the WooOrderTotalReport instance.
  ///
  /// Displays all main fields for debugging and logging purposes.
  @override
  String toString() => _toJson().toString();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WooOrderTotalReport &&
        other.slug == slug &&
        other.name == name &&
        other.total == total;
  }

  @override
  int get hashCode => slug.hashCode ^ name.hashCode ^ total.hashCode;

  factory WooOrderTotalReport.fake() => WooOrderTotalReport(
        slug: FakeHelper.word(),
        name: FakeHelper.word(),
        total: FakeHelper.integer().toString(),
      );
}
