import '../../helpers/fake_helper.dart';

class WooOrderTotalReport {
  WooOrderTotalReport({this.slug, this.name, this.total});
  factory WooOrderTotalReport.fromJson(Map<String, dynamic> json) =>
      WooOrderTotalReport(
        slug: json['slug']?.toString(),
        name: json['name']?.toString(),
        total: json['total']?.toString(),
      );
  factory WooOrderTotalReport.fake() => WooOrderTotalReport(
        slug: FakeHelper.word(),
        name: FakeHelper.word(),
        total: FakeHelper.integer().toString(),
      );
  final String? slug;
  final String? name;
  final String? total;
  WooOrderTotalReport copyWith({String? slug, String? name, String? total}) =>
      WooOrderTotalReport(
        slug: slug ?? this.slug,
        name: name ?? this.name,
        total: total ?? this.total,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooOrderTotalReport &&
        other.slug == slug &&
        other.name == name &&
        other.total == total;
  }

  @override
  int get hashCode => Object.hashAll([slug, name, total]);
  @override
  String toString() =>
      'WooOrderTotalReport(slug: $slug, name: $name, total: $total)';
}
