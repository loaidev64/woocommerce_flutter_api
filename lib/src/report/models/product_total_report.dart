import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

/// Represents a product total report with basic information.
///
/// Brief description of the model's purpose and usage.
class WooProductTotalReport {
  /// An alphanumeric identifier for the resource.
  String? slug;

  /// Product type name.
  String? name;

  /// Amount of products.
  String? total;

  /// Creates a new WooProductTotalReport instance.
  WooProductTotalReport({
    this.slug,
    this.name,
    this.total,
  });

  /// Creates a WooProductTotalReport instance from JSON data.
  WooProductTotalReport.fromJson(Map<String, dynamic> json)
      : slug = json['slug'],
        name = json['name'],
        total = json['total']?.toString();

  Map<String, dynamic> _toJson() => {
        'slug': slug,
        'name': name,
        'total': total,
      };

  /// Returns a string representation of the WooProductTotalReport instance.
  ///
  /// Displays all main fields for debugging and logging purposes.
  @override
  String toString() => _toJson().toString();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WooProductTotalReport &&
        other.slug == slug &&
        other.name == name &&
        other.total == total;
  }

  @override
  int get hashCode => slug.hashCode ^ name.hashCode ^ total.hashCode;

  factory WooProductTotalReport.fake() => WooProductTotalReport(
        slug: FakeHelper.word(),
        name: FakeHelper.word(),
        total: FakeHelper.integer().toString(),
      );
}
