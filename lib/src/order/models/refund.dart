import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooRefunds {
  WooRefunds({this.id, this.reason, this.total});
  factory WooRefunds.fromJson(Map<String, dynamic> json) => WooRefunds(
        id: WooJson.readInt(json, 'id'),
        reason: WooJson.readString(json, 'reason'),
        total: WooJson.readDouble(json, 'total'),
      );
  factory WooRefunds.fake() => WooRefunds(
        id: FakeHelper.integer(),
        reason: FakeHelper.sentence(),
        total: FakeHelper.decimal(),
      );
  final int? id;
  final String? reason;
  final double? total;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('id', id)
    ..putIfPresent('reason', reason)
    ..putIfPresent('total', total);
  WooRefunds copyWith({int? id, String? reason, double? total}) => WooRefunds(
        id: id ?? this.id,
        reason: reason ?? this.reason,
        total: total ?? this.total,
      );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WooRefunds &&
          other.id == id &&
          other.reason == reason &&
          other.total == total;
  @override
  int get hashCode => Object.hashAll([id, reason, total]);
  @override
  String toString() {
    return 'WooRefunds(id: $id, reason: $reason, total: $total)';
  }
}
