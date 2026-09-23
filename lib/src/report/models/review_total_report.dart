import '../../helpers/fake_helper.dart';

class WooProductReviewTotalReport {
  WooProductReviewTotalReport({this.slug, this.name, this.total});
  factory WooProductReviewTotalReport.fromJson(Map<String, dynamic> json) =>
      WooProductReviewTotalReport(
        slug: json['slug']?.toString(),
        name: json['name']?.toString(),
        total: json['total']?.toString(),
      );
  factory WooProductReviewTotalReport.fake() => WooProductReviewTotalReport(
        slug: FakeHelper.word(),
        name: FakeHelper.word(),
        total: FakeHelper.integer().toString(),
      );
  final String? slug;
  final String? name;
  final String? total;
  WooProductReviewTotalReport copyWith({
    String? slug,
    String? name,
    String? total,
  }) =>
      WooProductReviewTotalReport(
        slug: slug ?? this.slug,
        name: name ?? this.name,
        total: total ?? this.total,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooProductReviewTotalReport &&
        other.slug == slug &&
        other.name == name &&
        other.total == total;
  }

  @override
  int get hashCode => Object.hashAll([slug, name, total]);
  @override
  String toString() =>
      'WooProductReviewTotalReport(slug: $slug, name: $name, total: $total)';
}
