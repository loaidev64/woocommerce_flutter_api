import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

class WooRefunds {
  /// Refund ID.
  int? id;

  /// Refund reason.
  String? reason;

  /// Refund total.
  double? total;

  WooRefunds({this.id, this.reason, this.total});

  WooRefunds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reason = json['reason'];
    total = double.tryParse(json['total']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reason'] = reason;
    data['total'] = total;
    return data;
  }

  factory WooRefunds.fake() => WooRefunds(
        id: FakeHelper.integer(),
        reason: FakeHelper.sentence(),
        total: FakeHelper.decimal(),
      );
}
