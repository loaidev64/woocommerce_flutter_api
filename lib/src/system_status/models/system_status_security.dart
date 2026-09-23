import '../../helpers/fake_helper.dart';
import '../../json/woo_json.dart';

class WooSystemStatusSecurity {
  WooSystemStatusSecurity({this.secureConnection, this.hideErrors});
  factory WooSystemStatusSecurity.fromJson(Map<String, dynamic> json) =>
      WooSystemStatusSecurity(
        secureConnection: WooJson.readBool(json, 'secure_connection'),
        hideErrors: WooJson.readBool(json, 'hide_errors'),
      );
  factory WooSystemStatusSecurity.fake() => WooSystemStatusSecurity(
        secureConnection: FakeHelper.boolean(),
        hideErrors: FakeHelper.boolean(),
      );
  final bool? secureConnection;
  final bool? hideErrors;
  Map<String, dynamic> toJson() => <String, dynamic>{}
    ..putIfPresent('secure_connection', secureConnection)
    ..putIfPresent('hide_errors', hideErrors);
  WooSystemStatusSecurity copyWith({
    bool? secureConnection,
    bool? hideErrors,
  }) =>
      WooSystemStatusSecurity(
        secureConnection: secureConnection ?? this.secureConnection,
        hideErrors: hideErrors ?? this.hideErrors,
      );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WooSystemStatusSecurity &&
        other.secureConnection == secureConnection &&
        other.hideErrors == hideErrors;
  }

  @override
  int get hashCode => Object.hashAll([secureConnection, hideErrors]);
  @override
  String toString() => 'WooSystemStatusSecurity(secureConnection: '
      '$secureConnection)';
}
