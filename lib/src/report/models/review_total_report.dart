import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

/// Represents a product review total report with basic information.
///
/// Brief description of the model's purpose and usage.
class WooProductReviewTotalReport {
  /// An alphanumeric identifier for the resource.
  String? slug;

  /// Review type name.
  String? name;

  /// Amount of reviews.
  String? total;

  /// Creates a new WooProductReviewTotalReport instance.
  WooProductReviewTotalReport({
    this.slug,
    this.name,
    this.total,
  });

  /// Creates a WooProductReviewTotalReport instance from JSON data.
  WooProductReviewTotalReport.fromJson(Map<String, dynamic> json)
      : slug = json['slug'],
        name = json['name'],
        total = json['total']?.toString();

  Map<String, dynamic> _toJson() => {
        'slug': slug,
        'name': name,
        'total': total,
      };

  /// Returns a string representation of the WooProductReviewTotalReport instance.
  ///
  /// Displays all main fields for debugging and logging purposes.
  @override
  String toString() => _toJson().toString();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WooProductReviewTotalReport &&
        other.slug == slug &&
        other.name == name &&
        other.total == total;
  }

  @override
  int get hashCode => slug.hashCode ^ name.hashCode ^ total.hashCode;

  factory WooProductReviewTotalReport.fake() => WooProductReviewTotalReport(
        slug: FakeHelper.word(),
        name: FakeHelper.word(),
        total: FakeHelper.integer().toString(),
      );
}
