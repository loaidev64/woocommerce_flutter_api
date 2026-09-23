import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooDeleteResult {
  const WooDeleteResult({required this.id, required this.deleted});
  factory WooDeleteResult.fromJson(Map<String, dynamic> json) =>
      WooDeleteResult(
        id: switch (json['id']) {
          final int id => id,
          final num id => id.toInt(),
          final String id => int.tryParse(id),
          _ => null,
        },
        deleted: json['deleted'] == true,
      );
  factory WooDeleteResult.fake() => WooDeleteResult(
        id: FakeHelper.integer(),
        deleted: FakeHelper.boolean(),
      );
  final int? id;
  final bool deleted;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putIfPresent('deleted', deleted);
  WooDeleteResult copyWith({int? id, bool? deleted}) => WooDeleteResult(
        id: id ?? this.id,
        deleted: deleted ?? this.deleted,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooDeleteResult && other.id == id && other.deleted == deleted;
  @override
  int get hashCode => Object.hashAll([id, deleted]);
  @override
  String toString() => 'WooDeleteResult(id: $id, deleted: $deleted)';
}
