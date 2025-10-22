import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

/// Represents a customer total report with basic information.
///
/// Brief description of the model's purpose and usage.
class WooCustomerTotalReport {
  /// An alphanumeric identifier for the resource.
  String? slug;

  /// Customer type name.
  String? name;

  /// Amount of customers.
  String? total;

  /// Creates a new WooCustomerTotalReport instance.
  WooCustomerTotalReport({
    this.slug,
    this.name,
    this.total,
  });

  /// Creates a WooCustomerTotalReport instance from JSON data.
  WooCustomerTotalReport.fromJson(Map<String, dynamic> json)
      : slug = json['slug'],
        name = json['name'],
        total = json['total']?.toString();

  Map<String, dynamic> _toJson() => {
        'slug': slug,
        'name': name,
        'total': total,
      };

  /// Returns a string representation of the WooCustomerTotalReport instance.
  ///
  /// Displays all main fields for debugging and logging purposes.
  @override
  String toString() => _toJson().toString();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WooCustomerTotalReport &&
        other.slug == slug &&
        other.name == name &&
        other.total == total;
  }

  @override
  int get hashCode => slug.hashCode ^ name.hashCode ^ total.hashCode;

  factory WooCustomerTotalReport.fake() => WooCustomerTotalReport(
        slug: FakeHelper.word(),
        name: FakeHelper.word(),
        total: FakeHelper.integer().toString(),
      );
}
