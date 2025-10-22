import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

/// Represents a refund summary in a WooCommerce order.
///
/// Contains basic refund information including ID, reason, and total amount.
/// Used for displaying refund summaries in order details.
class WooRefunds {
  /// Unique identifier for the refund.
  int? id;

  /// Reason for the refund.
  String? reason;

  /// Total refund amount.
  double? total;

  /// Creates a new WooRefunds instance.
  WooRefunds({this.id, this.reason, this.total});

  /// Creates a WooRefunds instance from JSON data.
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

  /// Returns a string representation of the WooRefunds instance.
  ///
  /// Displays all main fields for debugging and logging purposes.
  @override
  String toString() {
    return 'WooRefunds(id: $id, reason: $reason, total: $total)';
  }
}
