import 'package:woocommerce_flutter_api/woocommerce_flutter_api.dart';

class WooPaymentGateway {
  /// Payment gateway ID
  final String? id;

  /// Payment gateway title on checkout
  final String? title;

  /// Payment gateway description on checkout
  final String? description;

  /// Payment gateway sort order
  final int? order;

  /// Payment gateway enabled status
  final bool? enabled;

  /// Payment gateway method title
  final String? methodTitle;

  /// Payment gateway method description
  final String? methodDescription;

  /// Supported features
  final List<String>? methodSupports;

  /// Payment gateway settings
  final Map<String, WooPaymentGatewaySetting>? settings;

  WooPaymentGateway({
    this.id,
    this.title,
    this.description,
    this.order,
    this.enabled,
    this.methodTitle,
    this.methodDescription,
    this.methodSupports,
    this.settings,
  });

  factory WooPaymentGateway.fromJson(Map<String, dynamic> json) {
    final settings = json['settings'] as Map<String, dynamic>?;

    return WooPaymentGateway(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      order: json['order'],
      enabled: json['enabled'],
      methodTitle: json['method_title'],
      methodDescription: json['method_description'],
      methodSupports: json['method_supports'] != null
          ? List<String>.from(json['method_supports'])
          : null,
      settings: settings?.map((key, value) =>
          MapEntry(key, WooPaymentGatewaySetting.fromJson(value))),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'order': order,
        'enabled': enabled,
        'method_title': methodTitle,
        'method_description': methodDescription,
        'method_supports': methodSupports,
        'settings':
            settings?.map((key, value) => MapEntry(key, value.toJson())),
      };

  factory WooPaymentGateway.fake() => WooPaymentGateway(
        id: FakeHelper.word(),
        title: FakeHelper.word(),
        description: FakeHelper.sentence(),
        order: FakeHelper.integer(),
        enabled: FakeHelper.boolean(),
        methodTitle: FakeHelper.sentence(),
        methodDescription: FakeHelper.sentence(),
        methodSupports: FakeHelper.list(() => FakeHelper.word()),
        settings: {
          for (var i = 0; i < FakeHelper.integer(max: 2); i++)
            FakeHelper.word(): WooPaymentGatewaySetting.fake(),
        },
      );
}
