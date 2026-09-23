import '../../helpers/fake_helper.dart';

class WooCustomerTotalReport {
  WooCustomerTotalReport({this.slug, this.name, this.total});
  factory WooCustomerTotalReport.fromJson(Map<String, dynamic> json) =>
      WooCustomerTotalReport(
        slug: json['slug']?.toString(),
        name: json['name']?.toString(),
        total: json['total']?.toString(),
      );
  factory WooCustomerTotalReport.fake() => WooCustomerTotalReport(
        slug: FakeHelper.word(),
        name: FakeHelper.word(),
        total: FakeHelper.integer().toString(),
      );
  final String? slug;
  final String? name;
  final String? total;
  WooCustomerTotalReport copyWith({
    String? slug,
    String? name,
    String? total,
  }) =>
      WooCustomerTotalReport(
        slug: slug ?? this.slug,
        name: name ?? this.name,
        total: total ?? this.total,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooCustomerTotalReport &&
        other.slug == slug &&
        other.name == name &&
        other.total == total;
  }

  @override
  int get hashCode => Object.hashAll([slug, name, total]);
  @override
  String toString() =>
      'WooCustomerTotalReport(slug: $slug, name: $name, total: $total)';
}
