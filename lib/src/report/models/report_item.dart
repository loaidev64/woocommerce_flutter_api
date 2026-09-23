import '../../helpers/fake_helper.dart';

class WooReportItem {
  WooReportItem({this.slug, this.description, this.group});
  factory WooReportItem.fromJson(Map<String, dynamic> json) => WooReportItem(
        slug: json['slug']?.toString(),
        description: json['description']?.toString(),
        group: json['group']?.toString(),
      );
  factory WooReportItem.fake() => WooReportItem(
        slug: FakeHelper.word(),
        description: FakeHelper.sentence(),
        group: FakeHelper.word(),
      );
  final String? slug;
  final String? description;
  final String? group;
  WooReportItem copyWith({
    String? slug,
    String? description,
    String? group,
  }) =>
      WooReportItem(
        slug: slug ?? this.slug,
        description: description ?? this.description,
        group: group ?? this.group,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooReportItem &&
        other.slug == slug &&
        other.description == description &&
        other.group == group;
  }

  @override
  int get hashCode => Object.hashAll([slug, description, group]);
}
