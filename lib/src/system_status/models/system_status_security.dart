import 'package:woocommerce_flutter_api/src/helpers/fake_helper.dart';

class WooSystemStatusSecurity {
  final bool? secureConnection;
  final bool? hideErrors;

  WooSystemStatusSecurity({
    this.secureConnection,
    this.hideErrors,
  });

  factory WooSystemStatusSecurity.fromJson(Map<String, dynamic> json) => WooSystemStatusSecurity(
    secureConnection: json['secure_connection'],
    hideErrors: json['hide_errors'],
  );

  Map<String, dynamic> toJson() => {
    'secure_connection': secureConnection,
    'hide_errors': hideErrors,
  };

  factory WooSystemStatusSecurity.fake() => WooSystemStatusSecurity(
    secureConnection: FakeHelper.boolean(),
    hideErrors: FakeHelper.boolean(),
  );
}