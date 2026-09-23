import '../../helpers/fake_helper.dart';

class WooProductTotalReport {
  WooProductTotalReport({this.slug, this.name, this.total});
  factory WooProductTotalReport.fromJson(Map<String, dynamic> json) =>
      WooProductTotalReport(
        slug: json['slug']?.toString(),
        name: json['name']?.toString(),
        total: json['total']?.toString(),
      );
  factory WooProductTotalReport.fake() => WooProductTotalReport(
        slug: FakeHelper.word(),
        name: FakeHelper.word(),
        total: FakeHelper.integer().toString(),
      );
  final String? slug;
  final String? name;
  final String? total;
  WooProductTotalReport copyWith({String? slug, String? name, String? total}) =>
      WooProductTotalReport(
        slug: slug ?? this.slug,
        name: name ?? this.name,
        total: total ?? this.total,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooProductTotalReport &&
        other.slug == slug &&
        other.name == name &&
        other.total == total;
  }

  @override
  int get hashCode => Object.hashAll([slug, name, total]);
  @override
  String toString() =>
      'WooProductTotalReport(slug: $slug, name: $name, total: $total)';
}
